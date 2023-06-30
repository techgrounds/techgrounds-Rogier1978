@description('location param')
param location string = resourceGroup().location
//param resourceGroupName string

@description('vmsize param')
param vmSize string = 'Standard_D2ds_v4'

@description('login params')
param managementUserName string 
@secure()
param managementPassword string 

@description('naming params')
param ManagementserverName string = 'ManageServer'
param vnet1Name string = 'management-prd-vnet'
param subNet1Name string = 'management-prd-subnet'
var nic1Name = '${vnet1Name}-nic'
var sg1Name = '${vnet1Name}-nsg'

@description('allowed ip param for the nsg')
param ipAllowList array = ['83.128.17.253']//My public address


// param keyVaultId string
// param key1Id string

//management

targetScope ='resourceGroup'

@description('security group with security rules')
resource nsg1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: sg1Name
  location: location
  properties: {
    securityRules: [
      {
        name: 'managementIPAccessIn'
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
      {
        name: 'managementIPAccessOut'
        properties: {
          priority: 200
          direction: 'Outbound'
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

@description('vnet1 with subnet1')
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

@description('public ip address managementserver')
resource pubIP1 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: '${vnet1Name}-publicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

@description('public ip address managementserver')
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

@description('availibility set management')
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


// resource ManagementEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2022-07-02' = {
//   name: 'ManagementEncryption'
//   location: location
//   properties: {
//     activeKey: {
//       sourceVault: {
//         id: keyVaultId // Replace with your Key Vault details
//       }
//       keyUrl: keyProps // Replace with your Key Vault details
//     }
//   }
// }


@description('vm for the managementserver')
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
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition' //https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-bicep?tabs=CLI
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'standard_LRS'
         
          
        }
        // encryptionSettings: {
        //   diskEncryptionKey: {
        //     sourceVault: {
        //       id: keyVaultId
        //     }
        //     secretUrl: keyVaultUri/secrets/key1/ 
        //   }
        // }
      }
    }
    osProfile: {
      computerName: ManagementserverName
      adminUsername: managementUserName
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

@description('outputs for vnet')
output vNet1ID string = vNet1.id
output vNet1Name string = vNet1.name

@description('outputs for vnet')
output manVm string = managementVM.id
output manVMname string = managementVM.name


