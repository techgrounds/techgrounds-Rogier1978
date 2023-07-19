@description('location param')
param location string = resourceGroup().location

param dbUserName string
@secure()
param dbPassword string

param serverName string = 'sqlDbServer000Proj'
param sqlEndpoint string = 'sqlDbEndpoint'
param mysqlVersion string = '8.0'
param subNet2Id string
param vNet2ID string

param privateEndpointName string = '${serverName}-EndPoint'
param privateDnsZoneName string = 'privatelink.mysql.database.azure.com'
param pvtEndpointDnsGroupName string = 'privateDnsEndpoint'



resource vnet2 'Microsoft.Network/virtualNetworks@2022-11-01'existing = {
  name: vNet2ID
}
resource mysqlDbServer 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: serverName
  location: location
  sku: {
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    capacity: 2
    size: '5120'  
    family: 'Gen5'
  }
  properties: {
    createMode: 'Default'
    version: mysqlVersion
    administratorLogin: dbUserName
    administratorLoginPassword: dbPassword
    storageProfile: {
      storageMB: 5120
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
  }
  resource virtualNetworkRule 'virtualNetworkRules@2017-12-01' = {
    name: 'virtualNetworkRuleName'
    properties: {
      virtualNetworkSubnetId: subNet2Id
      ignoreMissingVnetServiceEndpoint: true
    }
  }
}

resource mySqlDB 'Microsoft.DBforMySQL/servers/databases@2017-12-01' = {
  parent: mysqlDbServer
  name: 'sqlMyDB'
}






resource mySqlEndpoint 'Microsoft.Network/privateEndpoints@2022-11-01' ={
  name: sqlEndpoint
  location: location
  properties: {
    subnet: {
      id: subNet2Id
    }
    privateLinkServiceConnections: [
      {
        name: privateEndpointName
        properties: {
          privateLinkServiceId: mysqlDbServer.id
          groupIds: [
            'mySqlServer'
          ]
        }
      }
    ]
  }
  dependsOn: [
    vnet2
  ]
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZoneName
  location: 'global'
  properties: {}
  dependsOn: [
    vnet2
  ]
}

resource privateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZone
  name: '${privateDnsZoneName}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vNet2ID
    }
  }
}



resource pvtEndDnspointGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2022-11-01' = {
  name: pvtEndpointDnsGroupName
  parent: mySqlEndpoint
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZone.id
        }
      }
    ]
  }
}


      
output mysqlDbServerId string = mysqlDbServer.id
