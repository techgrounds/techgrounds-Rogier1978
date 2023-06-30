@description('location param')
param location string = resourceGroup().location

@description('vmsize param')
param vmSize string = 'Standard_B2s'

@description('login params')
param webUsername string 
@secure()
param webPassword string

var apacheDeplopyment = loadFileAsBase64('./customdata.sh')

@description('naming params')
param webServerName string = 'webServer'
param vnet2Name string = 'app-prd-vnet'
param subNet2Name string = 'app-prd-subnet'
var nic2Name = '${vnet2Name}-nic'
var sg2Name = '${vnet2Name}-nsg'

// @description('param for diskEncryption')
// param diskEncryption string




// WEBSERVER (appserver) //------------------------------------------
@description('security group with security rules')
resource nsg2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: sg2Name
  location: location
  properties: {
    securityRules: [
      {
        name: 'ssh'
        properties: {
          protocol: 'TCP'
          sourceAddressPrefix: '10.10.10.10/32' 
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
      {
        name: 'openPorts443In'
        properties: {
          priority: 300
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '443'
          }
      }
        
      // {
      //   name: 'openPorts80Out'
      //   properties: {
      //     priority: 200
      //     direction: 'Outbound'
      //     access: 'Allow'
      //     protocol: 'tcp'
      //     sourceAddressPrefix: '*'
      //     destinationAddressPrefix: '*'
      //     sourcePortRange: '80'
      //     destinationPortRange: '*'
      //   }
      // }
      // {
      //   name: 'openPorts443Out'
      //   properties: {
      //     priority: 300
      //     direction: 'Outbound'
      //     access: 'Allow'
      //     protocol: 'tcp'
      //     sourceAddressPrefix: '*'
      //     destinationAddressPrefix: '*'
      //     sourcePortRange: '443'
      //     destinationPortRange: '*'
      //     }
      // }
    ]
  }
}

@description('vnet2 with subnet2')
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
          privateEndpointNetworkPolicies: 'Disabled'
          networkSecurityGroup: nsg2.id == '' ? null : {
            id: nsg2.id
            }
      }
     }
    ]
  }
}



@description('public ip address webserver')
resource pubIP2 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: '${vnet2Name}-publicIP'
  location: location
  sku: {
    name: 'standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// resource myVmFirewallRule 'Microsoft.Network/networkInterfaces/firewallRules@2022-02-01' = {
//   name: 'Webvm/myVmFirewallRule'
//   properties: {
//     startIpAddress: '<<SQL_SERVER_IP_ADDRESS>>'
//     endIpAddress: '<<SQL_SERVER_IP_ADDRESS>>'
//   }
//   dependsOn: [
//     Webvm
//   ]
// }

@description('network interface webserver')
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
          privateIPAddress: '10.10.10.10'
          privateIPAllocationMethod: 'Static'
          publicIPAddress: {
            id: pubIP2.id
          }
        }  
      }
    ]
  }
}

@description('availibility set web')
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

@description('vm for the webserver')
resource Webvm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: webServerName
  location: location
  properties: {
    userData: apacheDeplopyment
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
        name: '${vnet2Name}_OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk:{
          // diskEncryptionSet:{
          //   id: diskEncryption
          // }          
        }
      }
    }
    osProfile: {
      computerName: '${webServerName}computer'
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


@description('outputs for vnet')
output vnet2ID string = vNet2.id
output vnet2Name string = vNet2.name
output subnetWebId string = vNet2.properties.subnets[0].id
output webServerId string = Webvm.id
