

param location string = resourceGroup().location

param vmSize string = 'Standard_B1s'

//management
param managementUsername string = 'rogier'
@secure()
param managementPassword string

param ManagementserverName string = 'ManagementServer'
param vnet1Name string = 'management-prd-vnet'
param subNet1Name string = 'managementSubnet'
var nic1Name = '${vnet1Name}-nic'

//Storage account for deployment
param storageKind string = 'StorageV2'
param storageSKU string = 'Standard_LRS'

//web
param appUsername string = 'rogier'
@secure()
param appPassword string

param appServerName string = 'appServer'
param vnet2Name string = 'app-prd-vnet'
param subNet2Name string = 'appSubnet'
var nic2Name = '${vnet2Name}-nic'


//==================//
// MANAGEMENTSERVER //
//==================//


resource vNet1 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
  }
}

resource subNet1 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = { 
  name: subNet1Name
  parent: vNet1
  properties: {
    addressPrefix: '10.20.20.0/24'
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
            id: subNet1.id
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

resource service 'Microsoft.Storage/storageAccounts/fileServices@2022-09-01' = {
  parent: storageAccount
  name: 'default'
}

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-09-01' = {
  parent: service
  name: 'deployshare'
  properties: {
    accessTier: 'hot'
  }  
}



//=======================//
// WEBSERVER (appserver) //
//=======================//


resource vNet2 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnet2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
  }
}

resource subNet2 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = { 
  name: subNet2Name
  parent: vNet2
  properties: {
    addressPrefix: '10.10.10.0/24'
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
            id: subNet2.id
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

