@description('location param')
param location string 


@description('vmsize param')
param vmSize string = 'Standard_D2_v4'

@description('login params')
param managementUserName string 
@secure()
param managementPassword string 

@description('naming params')
param ManagementserverName string = 'managementVm'
param vnet1Name string = 'vnetManagementServer'
param subNet1Name string = 'managementSubnet'
var nic1Name = '${ManagementserverName}Nic'
var sg1Name = '${ManagementserverName}Nsg'

param diskEncryption string

@description('allowed ip param for the nsg')
param ipManagementServer string


//managementServer

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
          sourceAddressPrefix: '${ipManagementServer}/32'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          description: 'Allow specific IP address'
        }
      }
      {
        name: 'managementSoragePort445'
        properties: {
          priority: 300
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '445'
          description: 'Allow port for deployment fileshare'
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
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
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
  name: '${ManagementserverName}PublicIp'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

@description('network interface managementserver')
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

@description('availibility set managementserver')
resource mngmntAs 'Microsoft.Compute/availabilitySets@2022-11-01' = {
  name: '${ManagementserverName}Availibilityset'
  location: location
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformFaultDomainCount: 2
    platformUpdateDomainCount: 3
  }
}

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
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'standard_LRS'
          diskEncryptionSet:{
            id: diskEncryption
          }          
        }
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

@description('outputs for subnets')
output subNet1ID string = vNet1.properties.subnets[0].id
output subNet1Name string = subNet1Name

@description('outputs for vnet')
output manVm string = managementVM.id
output manVMname string = managementVM.name


