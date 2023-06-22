param location string = resourceGroup().location

param vmSize string = 'Standard_D2ds_v4'

param managementUserName string 
@secure()
param managementPassword string 

param ipAllowList array = ['83.128.17.253']//My public address

param ManagementserverName string = 'ManageServer'
param vnet1Name string = 'management-prd-vnet'
param subNet1Name string = 'management-prd-subnet'
var nic1Name = '${vnet1Name}-nic'
var sg1Name = '${vnet1Name}-nsg'

//management

targetScope ='resourceGroup'

resource nsg1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: sg1Name
  location: location
  properties: {
    securityRules: [
      {
        name: 'BlockAllIPIn'
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
        name: 'BlockAllIPOut'
        properties: {
          priority: 100
          direction: 'Outbound'
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

output vNet1ID string = vNet1.id
output vNet1Name string = vNet1.name



