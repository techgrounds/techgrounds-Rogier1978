// param backupName string = 'backUp'
// param location string = resourceGroup().location
// param vnet2Id string
// param resourceGroupName string
// param vaultName string = 'backupName'
// // param vNet2 string
// // param appServerName string


// resource backupVault 'Microsoft.RecoveryServices/vaults@2023-04-01' = {
//   name: backupName
//   location: location
//   sku: {
//     name: 'RS0'
//     tier: 'Standard'
//   }
//   properties: {
//     publicNetworkAccess: 'Disabled'
//   }
// }



// resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-02-01' = {
//   name: 'myBackupPolicy'
//   parent: backupVault
//   //id: resourceId('Microsoft.RecoveryServices/vaults', subscription().subscriptionId, resourceGroupName, vaultName)
//   properties: {
//     backupManagementType: 'AzureIaasVM'
//     schedulePolicy: {
//       schedulePolicyType:'SimpleSchedulePolicy'
//       scheduleRunFrequency:'Daily'
//       scheduleRunTimes: [
//         '2023-06-21T03:00:00Z'
//       ]
      
//     }
//     retentionPolicy: {
//       retentionDuration: {
//         count: 7
//         durationType: 'Days'
//       }
//       retentionPolicyType: 'SimpleRetentionPolicy'    
//     }
//   }
// }

// resource backupProtection 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2023-02-01' = {
//   name: 'webServer'
//   parent: backupVault
//   properties: {
//     protectionIntentItemType: 'Microsoft.Compute/virtualMachines'
//     policyId: 'backupPolicy.id'
//     sourceResourceId: vnet2Id
//   }
// }
