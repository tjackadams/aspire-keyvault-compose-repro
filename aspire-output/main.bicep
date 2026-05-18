targetScope = 'subscription'

param resourceGroupName string

param location string

param principalId string

param keyvaultresourcegroup string

param keyvaultname string

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
}

module key_vault 'key-vault/key-vault.bicep' = {
  name: 'key-vault'
  scope: resourceGroup(keyvaultresourcegroup)
  params: {
    location: location
    keyvaultname: keyvaultname
  }
}

module key_vault_roles 'key-vault-roles/key-vault-roles.bicep' = {
  name: 'key-vault-roles'
  scope: resourceGroup(keyvaultresourcegroup)
  params: {
    location: location
    keyvaultname: keyvaultname
    principalType: ''
    principalId: principalId
  }
}