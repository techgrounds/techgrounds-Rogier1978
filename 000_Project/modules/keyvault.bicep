// az deployment group create --resource-group 000-project  --template-file ./000-project/modules/keyvault.bicep

param location string = resourceGroup().location
param keyVaultName string = 'rogiersVault'

param managementUserName string
param managementPassword string
param webUserName string
param webPassword string



@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get it by using Get-AzSubscription cmdlet.')
param tenantId string = subscription().tenantId

@description('Specifies the object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. Get it by using Get-AzADUser or Get-AzADServicePrincipal cmdlets.')
param objectId string = '446c5516-08bf-4e1c-a434-bc4b2bc206a6'




resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    enabledForDeployment: true          // VMs can retrieve certificates
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true  // ARM can retrieve values
    enableRbacAuthorization: false      
    tenantId: subscription().tenantId
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    createMode: 'default'               // Creating or updating the key vault (not recovering)
    accessPolicies: [
      {
        objectId: objectId
        tenantId: tenantId
        permissions: {
          secrets: [
            'all'
          ]
          certificates: [
            'all'
          ]
          keys: [
            'all'
          ]
        }
      }
    ]
  }
}
resource secret1 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: 'secretName1'
  properties: {
    value: managementUserName
  }
}

resource secret2 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: 'secretName2'
  properties: {
    value: managementPassword
  }
}

resource secret3 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: 'secretName3'
  properties: {
    value: webUserName
  }
}

resource secret4 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: 'secretName4'
  properties: {
    value: webPassword
  }
}

