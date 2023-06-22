//az deployment create --location westeurope  --template-file ./000-project/modules/main.bicep


targetScope='subscription'

@secure()
param managementUserName string 

@secure()
param managementPassword string 

@secure()
param webUserName string 

@secure()
param webPassword string 

// @secure()
// param webUserName string 

// @secure()
// param webPassword string 


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
//module keyvault
module kv './keyvault.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'projectKeyvault'
  params: {
    location: resourceGroupLocation
    managementUserName: managementUserName 
    managementPassword: managementPassword
    webUserName: webUserName
    webPassword: webPassword
  }
}
  
  

//module managementserver
module management './management.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'managementServer'
  params: {
    location: resourceGroupLocation
    managementPassword: managementPassword
    managementUserName: managementUserName
  }
}
//module webserver
module webserver './webserver.bicep' ={
  scope: az.resourceGroup(newRG.name)
  name: 'webServer'
  params: {
    location: resourceGroupLocation
    webUsername: webUserName
    webPassword: webPassword
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
//module peering
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

