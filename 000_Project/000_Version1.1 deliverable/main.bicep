// az deployment sub create --location westeurope  --template-file .\000-project\modules1.1\main.bicep
//@description ('loginSQL from webserver')
// mysql -h sqldbserver000proj.mysql.database.azure.com -u Rogier@sqldbserver000proj -p
targetScope='subscription'

@description('inquiries for login, passwords filled-in for convenience while developping')
param UserName string 
@secure()
param Password string 
param ipManagementServer string 


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
    managementPassword: Password
    managementUserName: UserName
    diskEncryption: kv.outputs.diskEncryption
    ipManagementServer: ipManagementServer    
  }
}


@description('module webserver')
module webserver './webserver.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'webServer'
  params: {
    location: resourceGroupLocation
    webUsername: UserName
    webPassword: Password
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

@description('module storage')
module storage './storage.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'deploymentStorage'
  params: {
    location: resourceGroupLocation
  }
}

@description('module backup')
module backup './backup.bicep' = {
  scope: az.resourceGroup(newRG.name)
  name: resourceGroupName
  params: {
    location: resourceGroupLocation
    managementName: management.outputs.manVMname
  }
}


@description('module for SQL database')
module sqlDatabase 'sqldatabase.bicep' = {
  scope: az.resourceGroup(newRG.name)
  name: 'projectSqlDatabase'
  params: {
    location: resourceGroupLocation
    dbUserName: UserName 
    dbPassword: Password 
    vNet2ID: webserver.outputs.vNet2ID
    subNet2Id: webserver.outputs.subnetVmssId
  }
}
