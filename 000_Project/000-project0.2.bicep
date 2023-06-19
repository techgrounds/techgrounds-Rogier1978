//DEPLOY: az deployment group create --resource-group 000-project  --template-file ./000-project/000-project-appasvm.bicep

param location string = resourceGroup().location

param vmSize string = 'Standard_B1s'

//management
param managementUsername string = 'rogier'
@secure()
param managementPassword string

param ipAllowList array = ['83.128.17.253']//My public address

param ManagementserverName string = 'ManagementServer'
param vnet1Name string = 'management-prd-vnet'
param subNet1Name string = 'management-prd-subnet'
var nic1Name = '${vnet1Name}-nic'
var sg1Name = '${vnet1Name}-nsg'


//web
param appUsername string = 'rogier'
@secure()
param appPassword string

param appServerName string = 'appServer'
param vnet2Name string = 'app-prd-vnet'
param subNet2Name string = 'app-prd-subnet'
var nic2Name = '${vnet2Name}-nic'
var sg2Name = '${vnet2Name}-nsg'

//peering
param peeringName1 string = 'peeringManagementToApp-App'
param peeringName2 string = 'peeringApp-Management'

//Storage account for deployment (blob storage)
param storageKind string = 'StorageV2'
param storageSKU string = 'Standard_LRS'

param containerNames array = ['blobstorage1']
//========================================================================================================================================================================//


  //==================//
 // MANAGEMENTSERVER //
//==================//

resource nsg1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: sg1Name
  location: location
  properties: {
    securityRules: [
      {
        name: 'BlockAllIP'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourceAddressPrefix: '10.0.0.0/24'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          description: 'Block all IP addresses except the specific IP'
        }
      }
      {
        name: 'managementIPAccess'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: '${ipAllowList[0]}/32'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          description: 'Allow specific IP address'
        }
      }
    ]
  }
}

resource vNet1 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    subnets: [ 
      {
      name: subNet1Name
        properties: {
          addressPrefix: '10.20.20.0/24'  
          networkSecurityGroup: nsg1.id == '' ? null : {
          id: nsg1.id
          }
        }
      }
    ]    
  }
}

resource pubIP1 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: '${vnet1Name}-publicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource nic1 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: nic1Name
  location: location
  
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vNet1.name, subNet1Name)
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pubIP1.id
          }
        }  
      }
    ]
  }
}

resource mngmntAs 'Microsoft.Compute/availabilitySets@2022-11-01' = {
  name: '${vnet1Name}-Availibility-set'
  location: location
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformFaultDomainCount: 2
    platformUpdateDomainCount: 20
  }
}

resource managementVM 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: ManagementserverName
  location: location
  properties: {
    availabilitySet: {
      id: mngmntAs.id
    } 
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: ManagementserverName
      adminUsername: managementUsername
      adminPassword: managementPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic1.id
          properties: {
            deleteOption: 'Detach'
            primary: true
          }
        }
      ]
    }
  }
}

  //=======================//
 // WEBSERVER (appserver) //
//=======================//

resource nsg2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: sg2Name
  location: location
  properties: {
    securityRules: [
      // {
      //   name: 'BlockAll'
      //   properties: {
      //     priority: 400
      //     direction: 'Inbound'
      //     access: 'Deny'
      //     protocol: '*'
      //     sourceAddressPrefix: '*'
      //     destinationAddressPrefix: '*'
      //     sourcePortRange: '*'
      //     destinationPortRange: '*'
      //     description: 'Block all IP addresses except the specific IP'
      //   }
      // }
      {
        name: 'openPorts1'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '1'
          destinationPortRange: '*'
          description: 'Allow specific IP address'
        }
      }
      {
        name: 'openPorts80'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '80'
          destinationPortRange: '*'
          description: 'Allow specific IP address'
        }
      }
      {
        name: 'openPorts443'
        properties: {
          priority: 300
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '443'
          destinationPortRange: '*'
          description: 'Allow specific IP address'
        }
      }
    ]
  }
}

resource vNet2 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnet2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
    subnets: [ 
     {
      name: subNet2Name
      properties: {
          addressPrefix: '10.10.10.0/24'
          networkSecurityGroup: nsg2.id == '' ? null : {
            id: nsg2.id
            }
      }
     }
    ]
  }
}

resource pubIP2 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: '${vnet2Name}-publicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource nic2 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: nic2Name
  location: location
  
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig2'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vNet2.name, subNet2Name)
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pubIP2.id
          }
        }  
      }
    ]
  }
}

resource webas 'Microsoft.Compute/availabilitySets@2022-11-01' = {
  name: '${vnet2Name}-Availibility-set'
  location: location
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformFaultDomainCount: 2
    platformUpdateDomainCount: 20
  }
}

resource Webvm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: appServerName
  location: location
  properties: {
    availabilitySet: {
      id: webas.id
    } 
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: appServerName
      adminUsername: appUsername
      adminPassword: appPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic2.id
          properties: {
            deleteOption: 'Detach'
            primary: true
          }
        }
      ]
    }
  }  
}
// resource vmName_install_apache 'Microsoft.Compute/virtualMachines/extensions@2023-03-01' = {
//   parent: Webvm
//   name: 'install_apache'
//   location: location
//   properties: {
//     publisher: 'Microsoft.Azure.Extensions'
//     type: 'CustomScript'
//     typeHandlerVersion: '2.1'
//     autoUpgradeMinorVersion: true
//     settings: {
//       commandToExecute: ' bash -c "apt-get update && apt-get install -y apache2"'
//     }
//   }
// }

  //=========//
 // PEERING //
//=========//

resource peering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-07-01' = {
  name: peeringName1
  parent: vNet1
  properties: {
    remoteVirtualNetwork: {
      id: vNet2.id
    }
    allowForwardedTraffic: false
    allowGatewayTransit: true
    allowVirtualNetworkAccess: true
    doNotVerifyRemoteGateways: false
  }
}
resource peering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-07-01' = {
  name: peeringName2
  parent: vNet2
  properties: {
    remoteVirtualNetwork: {
      id: vNet1.id
    }
    allowForwardedTraffic: false
    allowGatewayTransit: true
    allowVirtualNetworkAccess: true
    doNotVerifyRemoteGateways: false
  }
}

  //================================//
 // STORAGE ACCOUNT FOR DEPLOYMENT //
//================================//

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01'={
  name: '000project'
  location: location
  sku: {
    name: storageSKU
  }
  kind:storageKind  
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  parent: storageAccount
  name: 'default'
}

// Create containers if specified
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = [for containerName in containerNames: {
  parent: blobService
  name: !empty(containerNames) ? '${toLower(containerName)}' : 'placeholder'
  properties: {
    publicAccess: 'None'
    metadata: {}
  }
}]

