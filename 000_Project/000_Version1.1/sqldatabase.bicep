@description('location param')
param location string = resourceGroup().location

param dbUserName string
@secure()
param dbPassword string

param serverName string = 'projectMySqlServer'
// param sqlEndpoint string = 'sqlEndpoint'
param mysqlVersion string = '8.0'
// param subNet2Id string
// param webServerId string


resource mysqlDbServer 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: serverName
  location: location
  sku: {
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    capacity: 2
    size: '5120'  //a string is expected here but a int for the storageProfile...
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
}

// resource virtualNetworkRule 'virtualNetworkRules@2017-12-01' = {
//   name: virtualNetworkRuleName
//   properties: {
//     virtualNetworkSubnetId: subnet.id
//     ignoreMissingVnetServiceEndpoint: true
//   }
// }

// resource mySqlEndpoint 'Microsoft.Network/privateEndpoints@2022-11-01' ={
//   name: sqlEndpoint
//   location: location
//   properties: {
//     applicationSecurityGroups: [
//       {
//         id: 'string'
//         location: 'string'
//         properties: {}
//         tags: {}
//       }
//     ]
//     subnet: {
//       id: subNet2Id
//       name: webServerId
//       properties: {
//         //addressPrefix: 'string'
//         //addressPrefixes: [
//         //  'string'
//         //]
        
//         ipAllocations: [
//           {
//             id: 'string'
//           }
//         ]
//         natGateway: {
//           id: 'string'
//         }
//         networkSecurityGroup: {
//           id: 'string'
//           location: 'string'
//           properties: {
//             securityRules: [
//               {
//                 id: 'string'
//                 name: 'string'
//                 properties: {
//                   access: 'string'
//                   description: 'string'
//                   destinationAddressPrefix: 'string'
//                   destinationAddressPrefixes: [
//                     'string'
//                   ]
//                   destinationApplicationSecurityGroups: [
//                     {
//                       id: 'string'
//                       location: 'string'
//                       properties: {}
//                       tags: {}
//                     }
//                   ]
//                   destinationPortRange: 'string'
//                   destinationPortRanges: [
//                     'string'
//                   ]
//                   direction: 'string'
//                   priority: int
//                   protocol: 'string'
//                   sourceAddressPrefix: 'string'
//                   sourceAddressPrefixes: [
//                     'string'
//                   ]
//                   sourceApplicationSecurityGroups: [
//                     {
//                       id: 'string'
//                       location: 'string'
//                       properties: {}
//                       tags: {}
//                     }
//                   ]
//                   sourcePortRange: 'string'
//                   sourcePortRanges: [
//                     'string'
//                   ]
//                 }
//                 type: 'string'
//               }
//             ]
//           }
//         }
//       }
//     }
//   }
// }















// resource mySqlServer 'Microsoft.Sql/servers@2022-11-01-preview' = {
//   name: '000-projectSqlServer'
//   location: location
//   properties: {
//     administratorLogin: dbUserName
//     administratorLoginPassword: dbPassword
//     version: '12.0'
//     publicNetworkAccess: 'Disabled'
//   }
// }

// resource mySqlDatabase 'Microsoft.Sql/servers/databases@2022-11-01-preview' = {
//   name: '000-projectDb'
//   parent: mySqlServer
//   location: location
//   sku: {
//     name: 'Basic'
//     tier: 'Basic'
//     capacity: 5
//   }
//   properties: {
//     collation: 'SQL_Latin1_General_CP1_CI_AS'
//     maxSizeBytes: 1073741824 // 1 GB
//     sampleName: 'AdventureWorksLT'
//   }
//       dependsOn: [
//         mySqlServer
//       ]
// }

// resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
//   name: '000-database'
//   location: location
  
//   sku: {
//     capacity: int
//     family: 'string'
//     name: 'GP_S_Gen5_1'
//     size: 'string'
//     tier: 'GeneralPurpose'
//   }
//   parent: resourceSymbolicName
//   identity: {
//     type: 'string'
//     userAssignedIdentities: {}
//   }
//   properties: {
//     //autoPauseDelay: 60
//     catalogCollation: 'string'
//     //collation: 'string'
//     createMode: 'string'
//     elasticPoolId: 'string'
//     federatedClientId: 'string'
//     highAvailabilityReplicaCount: int
//     isLedgerOn: bool
//     licenseType: 'string'
//     longTermRetentionBackupResourceId: 'string'
//     maintenanceConfigurationId: 'string'
//     //maxSizeBytes: 34359738368
//     minCapacity: json('decimal-as-string')
//     preferredEnclaveType: 'string'
//     readScale: 'string'
//     recoverableDatabaseId: 'string'
//     recoveryServicesRecoveryPointId: 'string'
//     requestedBackupStorageRedundancy: 'string'
//     restorableDroppedDatabaseId: 'string'
//     restorePointInTime: 'string'
//     sampleName: 'string'
//     secondaryType: 'string'
//     sourceDatabaseDeletionDate: 'string'
//     sourceDatabaseId: 'string'
//     sourceResourceId: 'string'
//     zoneRedundant: bool
//   }
// }

output mysqlDbServerId string = mysqlDbServer.id
