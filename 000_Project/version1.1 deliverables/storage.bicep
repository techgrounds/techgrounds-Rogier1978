//Storage account for deployment (blob storage)
param location string = resourceGroup().location

@maxLength(24)
param storageAccountName string = 'storeageacc000project'

param storageKind string = 'StorageV2'
param storageSKU string = 'Standard_LRS'





resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01'={
  name: storageAccountName
  location: location
  sku: {
    name: storageSKU
  }
  kind:storageKind  
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  name: '${storageAccountName}/default/deployments'
  properties: {
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccount
  ]
}



