@description('location and naming params')
param location string = resourceGroup().location

@maxLength(24)
param keyVaultName string = 'project-${utcNow()}'


// @description('stored secrets params')
// @secure()
// param managementPassword string
// @secure()
// param webPassword string
// @secure()
// param dbPassword string

targetScope = 'resourceGroup'

@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get it by using Get-AzSubscription cmdlet.')
param tenantId string = 'de60b253-74bd-4365-b598-b9e55a2b208d'
param managedId string = 'userid${uniqueString(resourceGroup().name)}' 
param objectId string = '446c5516-08bf-4e1c-a434-bc4b2bc206a6'


//keyvault
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
    enablePurgeProtection: true    
    tenantId: tenantId
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    createMode: 'default'               // Creating or updating the key vault (not recovering)
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: objectId     
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
          storage: [
            'all'
          ]
        }
      }
    ]
    networkAcls: {
      defaultAction: 'Allow'          
      bypass: 'AzureServices'
      ipRules: [
        {
        value: '83.128.17.253'                        // own IP
      }
    ]
    }
  }
}

//managedidentity
@description('Create a managed identity')
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name:  managedId
  location: location
}

@description('diskEncryption')
resource encryptionKey1 'Microsoft.KeyVault/vaults/keys@2023-02-01' = {
  name: 'diskEncryption'
  parent: keyVault
  properties: {
    attributes: {
      enabled: true
    }
    keyOps: [
      'decrypt'
      'encrypt'
      'unwrapKey'
      'wrapKey'
    ]
    keySize: 4096
    kty:'RSA'
  }  
}

resource diskEncryption 'Microsoft.Compute/diskEncryptionSets@2022-07-02' = {
  name: 'diskEncryptionSets'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    rotationToLatestKeyVersionEnabled: true
    activeKey: {
      keyUrl: encryptionKey1.properties.keyUriWithVersion
    }
  }
  dependsOn: [
    keyVault
  ]
}

resource keyVaultAccessPolicy 'Microsoft.KeyVault/vaults/accessPolicies@2023-02-01' = {
  name: 'add'
  parent: keyVault
  properties: {
    accessPolicies:[
      {
        tenantId: tenantId
        objectId: diskEncryption.identity.principalId
        permissions: {
          keys: [
            'all'
          ]
          // secrets: [
          //   'all'
          // ]
          // certificates: [
          //   'all'
          // ]
          // storage: [
          //   'all'
          // ]
        }
      }
    ]
  }
}



output keyVaultID string = keyVault.id
// output key1Id string = key1.id
output keyVaultName string = keyVaultName
output diskEncryption string = diskEncryption.id
// output certificatTls string = webAppCertificate.id
