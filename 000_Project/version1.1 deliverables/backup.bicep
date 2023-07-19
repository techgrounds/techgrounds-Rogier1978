param location string = resourceGroup().location
param recoveryVaultName string = 'recoveryVaultName'
param managementName string


var backupFabric = 'Azure'
var protectionContainer = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${managementName}'
var protectedItem = 'vm;iaasvmcontainerv2;${resourceGroup().name};${managementName}'

resource managementVM 'Microsoft.Compute/virtualMachines@2022-03-01' existing = {
  name: managementName
}



resource recoveryVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: recoveryVaultName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  tags: {
    Location: location
  }
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    monitoringSettings: {
      azureMonitorAlertSettings: {
        alertsForAllJobFailures: 'Enabled'   
      }
      classicAlertSettings: {
        alertsForCriticalOperations: 'Enabled'
      }
    }
    publicNetworkAccess: 'Disabled'
  }
  dependsOn: [
    managementVM
  ]
}



// Enables backup of the management server with a default policy.
resource mgmtBackup 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2023-02-01' = {
  name: '${recoveryVaultName}/${backupFabric}/${protectionContainer}/${protectedItem}'
  location: location
  properties: {
    protectedItemType: 'Microsoft.Compute/virtualMachines'
    policyId: '${recoveryVault.id}/backupPolicies/DefaultPolicy'
    sourceResourceId: managementVM.id
  }
  dependsOn: [
    managementVM
  ]
}



