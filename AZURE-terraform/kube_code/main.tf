
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

  CLIENT_ID = "f031ce1d-a362-4cd3-b4d6-e0826fffaefd"
  CLIENT_SECRET = "727af339-49bd-4780-a5a5-95fb2a295d5b"
  prefix = "your-custom-resource-prefix"
}