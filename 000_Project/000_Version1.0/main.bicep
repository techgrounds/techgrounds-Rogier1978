//az deployment sub create --location uksouth  --template-file main.bicep

targetScope='subscription'

@description('inquiries for login')
param managementUserName string 
@secure()
param managementPassword string 

param webUserName string 
@secure()
param webPassword string 

param dbUserName string 
@secure()
param dbPassword string 




@description('resourcegroup/location params')
param resourceGroupName string = '000-project'
param resourceGroupLocation string = 'uksouth'



@description('module deployed to subscription')
module newRG './resourcegroup.bicep' = {
  name: resourceGroupName
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: resourceGroupLocation
  }
}



@description('module keyvault')
module kv './keyvault.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'projectKeyvault'
  params: {
    location: resourceGroupLocation
    managementPassword: managementPassword
    webPassword: webPassword
  }
}
  





@description('module for SQL database')
module sqlDatabase 'sqldatabase.bicep' = {
  scope: az.resourceGroup(newRG.name)
  name: 'projectSqlDatabase'
  params: {
    location: resourceGroupLocation
    dbUserName: dbUserName 
    dbPassword: dbPassword 
    // subNet2Id: webserver.outputs.subnetWebId 
    // webServerId: webserver.outputs.webServerId
  }
}
  






@description('module managementserver')
module management './management.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'managementServer'
  params: {
    location: resourceGroupLocation
    managementPassword: managementPassword
    managementUserName: managementUserName
  }
}
@description('module webserver')
module webserver './webserver.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'webServer'
  params: {
    location: resourceGroupLocation
    webUsername: webUserName
    webPassword: webPassword
  }
}
@description('module storage')
module storage './storage.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'deploymentStorage'
  params: {
    location: resourceGroupLocation
  }
}
@description('module peering')
module peering './peering.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'peering'
  params: {
    vNet1id: management.outputs.vNet1ID
    vNet1Name: management.outputs.vNet1Name
    vNet2id: webserver.outputs.vnet2ID
    vNet2Name: webserver.outputs.vnet2Name
  }
}

@description('module backup')
module backup './backup.bicep' = {
  scope: az.resourceGroup(newRG.name)
  name: resourceGroupName
  params: {
  }
}
