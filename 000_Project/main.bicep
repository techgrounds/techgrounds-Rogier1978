targetScope='subscription'


//param resourceGroup string = 'resourcegroup-000-project'
param resourceGroupName string = '000-project'
param resourceGroupLocation string = 'westeurope'

// module deployed to subscription
module newRG './resourcegroup.bicep' = {
  name: resourceGroupName
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: resourceGroupLocation
  }
}
//module managementserver
module management './management.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'managementServer'
  params: {
    location: resourceGroupLocation
  }
}
//module webserver
module app './webserver.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'webServer'
  params: {
    location: resourceGroupLocation
  }
}
//module storage
module storage './storage.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'deploymentStorage'
  params: {
    location: resourceGroupLocation
  }
}
