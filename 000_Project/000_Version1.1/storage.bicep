//Storage account for deployment (blob storage)
param location string = resourceGroup().location

param storageAccountName string = '000projectstorage'
param storageKind string = 'StorageV2'
param storageSKU string = 'Standard_LRS'

param vNet1id string
param subNet1id string


param privateEndpointName string = 'myPrivateEndpoint'



//param containerNames string = 'deploymentstorage'

// STORAGE ACCOUNT FOR DEPLOYMENT //

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

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: subNet1id
    }
    privateLinkServiceConnections: [
      {
        name: privateEndpointName
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'blobService'
          ]
        }
      }
    ]
  }
  // dependsOn: [
  //   vNet1id
  // ]
}

