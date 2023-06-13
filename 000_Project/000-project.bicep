param location string = resourceGroup().location



param vmSize string = 'Standard_B1s'

//management
param managementUsername string = 'rogier'
@secure()
param managementPassword string

param ManagementserverName string = 'managementserver'
var ManagementnicName = '${ManagementserverName}-nic'
var Managementvnetserver = 'ManagementVNet'
var Managementsubnetserver = 'ManagementSubnet'

//web
param webUsername string = 'rogier'
@secure()
param webPassword string

param WebserverName string = 'webserver'
var WebnicName = '${WebserverName}-nic'
var Webvnetserver = 'WebVNet'
var Websubnetserver = 'WebSubnet'





//==================//
// MANAGEMENTSERVER //
//==================//

resource Managementvirtualnetwork 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: Managementvnetserver
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    subnets: [
      {
        name: Managementsubnetserver
        properties: {
          addressPrefix: '10.20.20.0/24'
        }
      }
    ]
  }
}

resource managementpublicIP 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: '${ManagementserverName}-publicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource managementnic 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: ManagementnicName
  location: location
  
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', Managementvnetserver, Managementsubnetserver)
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: managementpublicIP.id
          }
        }  
      }
    ]
  }
}

resource mngmntas 'Microsoft.Compute/availabilitySets@2022-11-01' = {
  name: 'MngmntAvail'
  location: location
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformFaultDomainCount: 2
    platformUpdateDomainCount: 20
  }
}

resource Managementvm 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: ManagementserverName
  location: location
  properties: {
    availabilitySet: {
      id: mngmntas.id
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
          id: managementnic.id
          properties: {
            deleteOption: 'Detach'
            primary: true
          }
        }
      ]
    }
  }
}

//==========================//
// WEBSERVER (webappserver) //
//==========================//


resource Webvirtualnetwork 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: Webvnetserver
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
    subnets: [
      {
        name: Websubnetserver
        properties: {
          addressPrefix: '10.10.10.0/24'
        }
      }
    ]
  }  
}  

resource webpublicIP 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: '${WebserverName}-publicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource webnic 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: WebnicName
  location: location
  
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', Webvnetserver, Websubnetserver)
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: webpublicIP.id
          }
        }  
      }
    ]
  }
}

resource webas 'Microsoft.Compute/availabilitySets@2022-11-01' = {
  name: 'WebAvail'
  location: location
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformFaultDomainCount: 2
    platformUpdateDomainCount: 20
  }
}

resource Webvm 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: WebserverName
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
      computerName: WebserverName
      adminUsername: webUsername
      adminPassword: webPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: webnic.id
          properties: {
            deleteOption: 'Detach'
            primary: true
          }
        }
      ]
    }
  }
}

