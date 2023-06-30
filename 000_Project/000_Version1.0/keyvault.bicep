@description('location and naming params')
param location string = resourceGroup().location
@maxLength(24)
param keyVaultName string = 'keyvault${utcNow(location)}'

@description('stored secrets params')
@secure()
param managementPassword string
@secure()
param webPassword string



@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get it by using Get-AzSubscription cmdlet.')
param tenantId string = 'de60b253-74bd-4365-b598-b9e55a2b208d'
param managedId string = 'userid${uniqueString(resourceGroup().name)}' 




@description('keyvault resource')
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
    tenantId: tenantId
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    createMode: 'default'               // Creating or updating the key vault (not recovering)
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: managedIdentity.properties.principalId     
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
    networkAcls: {
      defaultAction: 'Allow'          
      bypass: 'AzureServices'
      ipRules: [{
        value: '83.128.17.253'                        // my own public IP
      }]
    }
  }
}

@description('Create a managed identity')
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name:  managedId
  location: location
}

//PASSWORDS============================================================
@description('here below are the stored secrets')
resource secretManPW 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: 'secretMan'
  properties: {
    value: managementPassword
  }
}
resource secretWebPW 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: keyVault
  name: 'secretWeb'
  properties: {
    value: webPassword
  }
}
//======================================================================




output keyVaultID string = keyVault.id
// output key1Id string = key1.id
output keyVaultName string = keyVaultName
// output diskEncryption string = key1.id
