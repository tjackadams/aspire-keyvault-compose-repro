# Aspire Key Vault + Docker Compose output repro

## Repro steps

```powershell
$env:Parameters__keyvaultname = 'demo-kv'
$env:Parameters__keyvaultresourcegroup = 'demo-rg'
aspire do prepare-env --non-interactive --nologo
```

Then inspect:

```powershell
Get-Content .\aspire-output\docker-compose.yaml
Get-Content .\aspire-output\.env
```

## Actual output

`docker-compose.yaml` contains:

```yaml
ConnectionStrings__key-vault: "${KEY_VAULT_OUTPUTS_VAULTURI}"
KEY_VAULT_URI: "${KEY_VAULT_OUTPUTS_VAULTURI}"
```

`.env` contains:

```env
KEY_VAULT_OUTPUTS_VAULTURI=
```

`prepare-env` completes successfully even though the only environment value required by the container remains blank.

## Expected

Either:

1. the Key Vault URI is materialized for Docker Compose deployment, or
2. Aspire warns/fails clearly that this Azure output cannot be resolved for this target instead of emitting a silently blank env value.