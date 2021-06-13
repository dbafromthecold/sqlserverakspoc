


# create ssh keys
ssh-keygen



# log into Azure
az login



# create resource group
az group create --name kubernetes --location eastus2



# create cluster one
az aks create --resource-group kubernetes --name SQLK8sCluster1 `
--node-count 3 --ssh-key-value C:\users\dbafromthecold\.ssh\aks_kubernetes.pub



# create cluster two
az aks create --resource-group kubernetes --name SQLK8sCluster2 `
--node-count 3 --ssh-key-value C:\users\dbafromthecold\.ssh\aks_kubernetes.pub



# grab credentials for cluster
az aks get-credentials --resource-group kubernetes --name SQLK8sCluster1
az aks get-credentials --resource-group kubernetes --name SQLK8sCluster2



# stop clusters
az aks stop --resource-group kubernetes --name SQLK8sCluster1
az aks stop --resource-group kubernetes --name SQLK8sCluster2



# start clusters
az aks start --resource-group kubernetes --name SQLK8sCluster1
az aks start --resource-group kubernetes --name SQLK8sCluster2