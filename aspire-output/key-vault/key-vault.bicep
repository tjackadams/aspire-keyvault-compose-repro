@description('The location for the resource(s) to be deployed.')
param location string = resourceGroup().location

param keyvaultname string

resource key_vault 'Microsoft.KeyVault/vaults@2024-11-01' existing = {
  name: keyvaultname
}

output vaultUri string = key_vault.properties.vaultUri

output name string = key_vault.name

output id string = key_vault.id