var apacheDeplopyment = loadFileAsBase64('./customdata.sh')


@description('Admin username for the backend servers')
param webUsername string
@description('Password for the admin account on the backend servers')
@secure()
param webPassword string 

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Size of the virtual machine.')
param vmSize string = 'Standard_DS2_v2'

param vmssName string = 'webserverVmss'
var virtualNetworkName = 'vnetWebserverVmss'

var nsgAGName = 'webserverAgNsg'
var nsgVmssName = 'webServerVmssNsg'
param publicIPAddressName string = '${vmssName}PublicIp'

param diskEncryption string

var virtualNetworkPrefix = '10.10.10.0/24'
var subnetPrefix = '10.10.10.0/25'
var vmssSubnetPrefix = '10.10.10.128/25'

var applicationGateWayName = '${vmssName}Ag'

param sslCertificateName string = 'sslCertificateAG'
var sslCertificate = loadFileAsBase64('selfSignedCertificate.pfx')


resource nsgAG 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsgAGName
  location: location
  properties: {
    securityRules: [
      {
        name: 'openPorts80In'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '80'
        }
      }
      {
        name: 'openPorts443In'
        properties: {
          priority: 250
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '443'
        }
      }
      {
        name: 'openPorts65200-65535In'
        properties: {
          priority: 300
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '65200-65535'
        }
      }
    ]
  }
}

resource nsgVmss 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsgVmssName
  location: location
  properties: {
    securityRules: [
      {
        name: 'openPorts80In'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '80'
        }
      }
      {
        name: 'openPorts443In'
        properties: {
          priority: 250
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '443'
        }
      }
      {
        name: 'ssh'
        properties: {
          protocol: 'TCP'
          sourceAddressPrefix: '10.10.10.0/24' 
          sourcePortRange: '*' 
          destinationAddressPrefix: '*' 
          destinationPortRange: '22'
          access: 'Allow'
          priority: 400
          direction: 'Inbound'
        }
      }
    ]
  }
}


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        virtualNetworkPrefix
      ]
    }
    subnets: [
      {
        name: 'myAGSubnet'
        properties: {
          addressPrefix: subnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          networkSecurityGroup: {
          id: nsgAG.id
          }
        }
      }
      {
        name: 'myBackendSubnet'
        properties: {
          addressPrefix: vmssSubnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          networkSecurityGroup: {
            id: nsgVmss.id
        }
      }
      }
    ]
    enableDdosProtection: false
    enableVmProtection: false
  }
}

resource vmScaleSet 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: vmssName 
  location: location
  sku: {
    name: vmSize
    tier: 'Standard'
    capacity: 3
  }
  properties: {
    overprovision: true
    upgradePolicy: {
      mode: 'Automatic'
    }
    automaticRepairsPolicy : {
      enabled: true
      gracePeriod: 'PT10M'
    }
    singlePlacementGroup: true
    platformFaultDomainCount: 5
    virtualMachineProfile: {
      userData: apacheDeplopyment
      storageProfile: {
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
          managedDisk: {
            storageAccountType: 'Standard_LRS'
            diskEncryptionSet: {
              id: diskEncryption
            }
          }
        }
        imageReference: {
          publisher: 'canonical'
          offer: '0001-com-ubuntu-server-focal'
          sku: '20_04-lts'
          version: 'latest'
        }
      }
      osProfile: {
        computerNamePrefix: vmssName
        adminUsername: webUsername
        adminPassword: webPassword
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: '${vmssName}nic'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: '${vmssName}ipConfig'
                  properties: {
                    subnet: {
                      id: virtualNetwork.properties.subnets[1].id
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                     id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
                      }
                    ]     
                  }
                }
              ]
            }
          }
        ]
      }
      extensionProfile: {
        extensions: [
          {
            name: 'healthName'
            properties: {
              enableAutomaticUpgrade: true
              publisher: 'Microsoft.ManagedServices'
              type: 'ApplicationHealthLinux'
              typeHandlerVersion: '1.0'
              settings: {
                port: 80
                protocol: 'http'
                requestPath: ''
              }
            }
          }
        ]
      } 
    }
  }
  dependsOn: [
    applicationGateWay
  ]
}


resource autoscalehost 'Microsoft.Insights/autoscalesettings@2022-10-01' = {
  name: 'autoscalehost'
  location: location
  properties: {
    name: 'autoscalehost'
    targetResourceUri: vmScaleSet.id
    enabled: true
    profiles: [
      {
        name: 'Profile1'
        capacity: {
          minimum: '1'
          maximum: '3'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmScaleSet.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 70
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmScaleSet.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 30
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
        ]
      }
    ]
  }
}





//=================================================================================================================================
//APPGATEWAY=======================================================================================================================
//=================================================================================================================================

resource applicationGateWay 'Microsoft.Network/applicationGateways@2022-11-01' = {
  name: applicationGateWayName
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    sslCertificates: [
      {
        name: sslCertificateName
        properties: {
          data: sslCertificate
          password: '1234'
        }
      }
    ]
    sslPolicy: {
      policyType: 'Custom'
      minProtocolVersion: 'TLSv1_2'
      cipherSuites: [
        'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384'
        'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256'
        'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384'
        'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256'
      ]
    }


    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, 'myAGSubnet')
          }
        }
      }
    ]



    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]



    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
      {
        name: 'port_443'
        properties: {
          port: 443
        }
      }
    ]




    backendAddressPools: [
      {
        name: 'myBackendPool'
        properties: {}
      }
    ]




    backendHttpSettingsCollection: [
      {
        name: 'myHTTPSetting80'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 30
        }
      }
    ]





    redirectConfigurations: [
      {
        name: 'redirect_config'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'HttpsListener')
          }
        }
      }
    ]




    httpListeners: [
      {
        name: 'HttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateWayName, 'appGwPublicFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateWayName, 'port_80')
          }
          protocol: 'Http'
          requireServerNameIndication: false
        }
      }
      {
        name: 'HttpsListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateWayName, 'appGwPublicFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateWayName, 'port_443')
          }
          protocol: 'Https'
          requireServerNameIndication: false
          sslCertificate: {
            id: resourceId('Microsoft.Network/applicationGateways/sslCertificates', applicationGateWayName, sslCertificateName)
          }
        }
      }
    ]




    requestRoutingRules: [
      {
        name: 'myRoutingRule80'
        properties: {
          ruleType: 'Basic'
          priority: 1000
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'HttpListener')
          }
          redirectConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/redirectConfigurations', applicationGateWayName, 'redirect_config')
          }
        }
      }
      {
        name: 'myRoutingRule443'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'HttpsListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateWayName, 'myHTTPSetting80')
          }
          priority: 1100
        }
      }
    ]
   

    forceFirewallPolicyAssociation: false
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 10
    }
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-11-01' =  {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    dnsSettings: {
      domainNameLabel: 'project-000'
    }
  }
}


@description('outputs for vnet')
output vNet2ID string = virtualNetwork.id
output vNet2Name string = virtualNetwork.name

output subnetWebId string = virtualNetwork.properties.subnets[0].id
output subnetVmssId string = virtualNetwork.properties.subnets[1].id

output webServerId string = vmScaleSet.id
