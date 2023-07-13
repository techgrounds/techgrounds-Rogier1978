//Storage account for deployment (blob storage)
param location string = resourceGroup().location

param storageAccountName string = '000projectstorage'
param storageKind string = 'StorageV2'
param storageSKU string = 'Standard_LRS'

param vNet1id string
param subNet1id string


param storageEndpointName string = 'storageEndpoint'
param storagePrivateEndpointName string = 'storagePrivateEndpoint'


//param containerNames string = 'deploymentstorage'

// STORAGE ACCOUNT FOR DEPLOYMENT //

resource vnet1 'Microsoft.Network/virtualNetworks@2022-11-01'existing = {
  name: vNet1id
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01'={
  name: storageAccountName
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

// Create container
resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  name: 'deplpoymentscripts'
  parent: blobService
  properties: {
    publicAccess: 'None'
    metadata: {}
  }
}

resource storageEndpoint 'Microsoft.Network/privateEndpoints@2022-11-01' ={
  name: storageEndpointName
  location: location
  properties: {
    subnet: {
      id: subNet1id
    }
    privateLinkServiceConnections: [
      {
        name: storagePrivateEndpointName
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'myStorageID'
          ]
        }
      }
    ]
  }
  dependsOn: [
    vnet1
  ]
}
