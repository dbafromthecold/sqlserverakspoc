############################################################################
############################################################################
#
# SQL Server on AKS Proof of Concept - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/sqlserverakspoc
# Creating the clusters for the demos
#
############################################################################
############################################################################



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



# test connection to clusters
kubectl config use-context SQLK8sCluster1
kubectl get nodes

kubectl config use-context SQLK8sCluster2
kubectl get nodes



# stop clusters
az aks stop --resource-group kubernetes --name SQLK8sCluster1
az aks stop --resource-group kubernetes --name SQLK8sCluster2



# start clusters
az aks start --resource-group kubernetes --name SQLK8sCluster1
az aks start --resource-group kubernetes --name SQLK8sCluster2