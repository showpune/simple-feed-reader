# Make sure you update your container app extension to at least 0.3.31
az extension update --name containerapp

# Set some basic environment variables
export RESOURCE_GROUP="zhiyongli-tanzu"
export LOCATION="eastus"
export ENVIRONMENT="zhiyong-containerapp-env"
export APP_NAME="feed-reader"
export REGISTRY_NAME="zhiyongliacr"

# Authenticate to both Azure and your container registry 
az login
az acr login --name $REGISTRY_NAME

# Build and launch your application on Azure Container Apps
# Important: Adjust you target-port setting to the port your application is listening on
az containerapp up --name $APP_NAME \
  --location $LOCATION \
  --environment $ENVIRONMENT \
  -g $RESOURCE_GROUP \
  --registry-server $REGISTRY_NAME.azurecr.io \
  --ingress external \
  --target-port 8080 \
  --source SimpleFeedReader