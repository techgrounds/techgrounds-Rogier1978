param location string = resourceGroup().location

param vmSize string = 'Standard_B2s'


param webUsername string 
@secure()
param webPassword string

param webServerName string = 'webServer'
param vnet2Name string = 'app-prd-vnet'
param subNet2Name string = 'app-prd-subnet'


var nic2Name = '${vnet2Name}-nic'
var sg2Name = '${vnet2Name}-nsg'

// WEBSERVER (appserver) //------------------------------------------

resource nsg2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: sg2Name
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowRDP'
        properties: {
          priority: 1000
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          destinationPortRange: '3389'
          destinationAddressPrefix: '*'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
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
  name: webServerName
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
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition' //https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-bicep?tabs=CLI
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: webServerName
      adminUsername: webUsername
      adminPassword: webPassword
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

// resource deploymentscript 'Microsoft.Compute/virtualMachines/runCommands@2023-03-01' = {
//   parent: Webvm
//   name: 'postDeploymentapacheInstall'
//   location: location
//   properties: {
//     source: {
//       script: '''#!/bin/bash
//       sudo su
//       apt update
//       apt install apache2 -y
//       ufw allow 'Apache'
//       systemctl enable apache2
//       systemctl restart apache2'''
//     }
//   }
// }

// resource vmName_install_apache 'Microsoft.Compute/virtualMachines/extensions@2023-03-01' = {
//   parent: Webvm
//   name: 'customscript'
//   location: location
//   properties: {
//     publisher: 'Microsoft.Azure.Extensions'
//     type: 'CustomScript'
//     typeHandlerVersion: '2.1'
//     autoUpgradeMinorVersion: true
//     settings: {
//       fileUris: [
//         scriptFilePath
//       ]
//     }
//     protectedSettings: {
//       commandToExecute: 'bash ${scriptFilePath}'
//     }
//   }
// }

output vnet2ID string = vNet2.id
output vnet2Name string = vNet2.name
