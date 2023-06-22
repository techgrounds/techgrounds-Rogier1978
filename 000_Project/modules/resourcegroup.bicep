targetScope = 'subscription'

param  resourceGroupName  string
param  resourceGroupLocation  string

// Creating resource group
resource newRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

output rgname string = newRG.name
output location string = newRG.location

