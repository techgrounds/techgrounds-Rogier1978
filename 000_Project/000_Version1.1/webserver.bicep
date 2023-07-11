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

var vmssName = 'myVmssVM'
var virtualNetworkName = 'myVNet'
var networkInterfaceName = 'net-int'
var ipconfigName = 'ipconfig'

var nsgAGName = 'appgat_nsg'
var nsgVmssName = 'vmss_nsg'

param diskEncryption string

var virtualNetworkPrefix = '10.10.10.0/24'
var subnetPrefix = '10.10.10.0/25'
var backendSubnetPrefix = '10.10.10.128/25'

var applicationGateWayName = '${vmssName}Ag'


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
    ]
  }
}

resource nsgVmss 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsgVmssName
  location: location
  properties: {
    securityRules: [
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
        //   networkSecurityGroup: nsgAG.id == '' ? null : {
        //   id: nsgAG.id
        // }
      }
      }
      {
        name: 'myBackendSubnet'
        properties: {
          addressPrefix: backendSubnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          networkSecurityGroup: nsgVmss.id == '' ? null : {
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
    singlePlacementGroup: true
    platformFaultDomainCount: 1
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
    }
  }
  dependsOn: [
    networkInterface
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
            id: resourceId('Microsoft.Network/publicIPAddresses', 'publicIPAddressName')
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
          // pickHostNameFromBackendAddress: false
          // requestTimeout: 20
        }
      }
      {
        name: 'myHTTPSetting443'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          // sslCertificate: {
          //   id: ''
          // }
          pickHostNameFromBackendAddress: false
          requestTimeout: 20
        }
      }
    ]
    httpListeners: [
      {
        name: 'myListener80'
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
      // {
      //   name: 'myListener443'
      //   properties: {
      //     frontendIPConfiguration: {
      //       id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateWayName, 'appGwPublicFrontendIp')
      //     }
      //     frontendPort: {
      //       id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateWayName, 'port_443')
      //     }
      //     protocol: 'Https'
      //     requireServerNameIndication: false
      //   }
      // }
    ]
    requestRoutingRules: [
      {
        name: 'myRoutingRule80'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'myListener80')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateWayName, 'myHTTPSetting80')
          }
          priority: 1000
        }
      }
      // {
      //   name: 'myRoutingRule443'
      //   properties: {
      //     ruleType: 'Basic'
      //     httpListener: {
      //       id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'myListener443')
      //     }
      //     backendAddressPool: {
      //       id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
      //     }
      //     backendHttpSettings: {
      //       id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateWayName, 'myHTTPSetting443')
      //     }
      //     priority: 1100
      //   }
      // }
    ]
    // sslCertificates: [
    //   {
    //     //id: 'string'
    //     name: 'sslCertificate'
    //     properties: {
    //       data: 'string'
    //       keyVaultSecretId: 'string'
    //       password: 'string'
    //     }
    //   }
    // ]
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 10
    }
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-11-01' =  {
  name: 'publicIPAddressName'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: ipconfigName
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, 'myBackendSubnet')
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          applicationGatewayBackendAddressPools: [
            {
              id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
            }
          ]
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroups', nsgAGName)
    }
  }
  dependsOn: [
    applicationGateWay
    nsgAG
  ]
  
}


@description('outputs for vnet')
output vNet2ID string = virtualNetwork.id
output vNet2Name string = virtualNetwork.name
