// az deployment sub create --location westeurope  --template-file .\000-project\modules1.0\modules1.1\main.bicep

targetScope='subscription'

@description('inquiries for login, passwords filled-in for convenience while developping')
param managementUserName string = 'Rogier'
@secure()
param managementPassword string = 'Pass@1234'

param webUserName string = 'Rogier'
@secure()
param webPassword string = 'Pass@1234'

param dbUserName string = 'Rogier'
@secure()
param dbPassword string = 'Pass@1234'




@description('resourcegroup/location params')
param resourceGroupName string = '000-project'
param resourceGroupLocation string = 'westeurope'



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
    diskEncryption: kv.outputs.diskEncryption
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
    diskEncryption: kv.outputs.diskEncryption
  }
}


@description('module peering')
module peering './peering.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'peering'
  params: {
    vNet1id: management.outputs.vNet1ID
    vNet1Name: management.outputs.vNet1Name
    vNet2id: webserver.outputs.vNet2ID
    vNet2Name: webserver.outputs.vNet2Name
  }
}

// @description('module storage')
// module storage './storage.bicep' ={
//   scope: az.resourceGroup(newRG.name)
//   name: 'deploymentStorage'
//   params: {
//     location: resourceGroupLocation
//     vNet1id: management.outputs.vNet1ID
//     subNet1id: management.outputs.subNet1ID
//   }
// }

// @description('module backup')
// module backup './backup.bicep' = {
//   scope: az.resourceGroup(newRG.name)
//   name: resourceGroupName
//   params: {
//   }
// }


@description('module for SQL database')
module sqlDatabase 'sqldatabase.bicep' = {
  scope: az.resourceGroup(newRG.name)
  name: 'projectSqlDatabase'
  params: {
    location: resourceGroupLocation
    dbUserName: dbUserName 
    dbPassword: dbPassword 
    subNet2Id: webserver.outputs.subnetVmssId
    vNet2ID: webserver.outputs.vNet2ID
  }
}
