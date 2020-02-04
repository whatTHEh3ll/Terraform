
# REGISTRY 
# https://registry.terraform.io/modules/Azure/aks/azurerm/2.0.0

# GET CREDENTIALS FOR NEW SERVICE PROVIDER 
# az ad sp create-for-rbac --name "test-udemy-sp" --role="Contributor" --scopes="/subscriptions/YOUR_ID_GOES_HERE"


# CONNECT 
# az aks install-cli
# az aks get-credentials --resource-group your-custom-resource-prefix-resources --name your-custom-resource-prefix-aks
# kubectl get nodes

module "aks" {
  source  = "Azure/aks/azurerm"
  version = "2.0.0"

  CLIENT_ID = "FROM AZURE ACTIVE DIRECTORY"
  CLIENT_SECRET = "PASSWORD FROM CREDENTIALS SERVICE PROVIDER COMMAND"
  prefix = "your-custom-resource-prefix"
}