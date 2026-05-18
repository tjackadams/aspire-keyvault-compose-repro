var builder = DistributedApplication.CreateBuilder(args);

builder.AddDockerComposeEnvironment("env");

var keyVaultName = builder.AddParameter("keyvaultname");
var keyVaultResourceGroup = builder.AddParameter("keyvaultresourcegroup");

var keyVault = builder.AddAzureKeyVault("key-vault")
    .RunAsExisting(keyVaultName, keyVaultResourceGroup)
    .PublishAsExisting(keyVaultName, keyVaultResourceGroup);

builder.AddContainer("api", "nginx", "alpine")
    .WithReference(keyVault);

builder.Build().Run();