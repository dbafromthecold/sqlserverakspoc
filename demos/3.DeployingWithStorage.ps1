############################################################################
############################################################################
#
# SQL Server on AKS Proof of Concept - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/sqlserverakspoc
# Deploying SQL Server with persistent storage
#
############################################################################
############################################################################



# switch context to cluster 1
kubectl config use-context SQLK8sCluster1



# navigate to yaml files
Set-Location C:\git\dbafromthecold\sqlserverakspoc\yaml



# view storage classes
kubectl get storageclass



# view yaml to create persistent volume claims
Get-Content .\3.CreatePVCs.yaml



# create persistent volume claims
kubectl apply -f .\3.CreatePVCs.yaml



# view persistent volumes claims
kubectl get pvc



# view persistent volumes
kubectl get pv



# view yaml to deploy SQL Server using PVCs
Get-Content .\4.SqlServerDeploymentWithStorage.yaml



# deploy SQL Server
kubectl apply -f .\4.SqlServerDeploymentWithStorage.yaml



# confirm deployment
kubectl get deployments



# view persistent volume claims
kubectl get pvc



# view persistent volumes created dynamically
kubectl get pv



# view pod
kubectl get pods



# view pod events
kubectl describe pods



# confirm node that pod is running on
kubectl get pods -o wide



##
## shut down node that pod is running on
##



# watch node until it becomes NotReady
kubectl get nodes --watch



# confirm node is NotReady
kubectl get nodes



# watch pod to see if it is moved to a new node
kubectl get pods -o wide --watch



# get new pod name
kubectl get pods



# get new pod events
kubectl describe pod PODNAME



# view pod state
kubectl get pods



##
## start node that old pod is running on
##



# watch node until it is in a state of Ready
kubectl get nodes --watch



# once the node comes back online the old pod will be terminated and the new one will come online (eventually)
kubectl get pods --watch



# view pod
kubectl get pods



# get pod events
kubectl describe pod sqlserver-8577dc65fc-6g8n8



# clean up
kubectl delete deployment sqlserver
kubectl delete pvc mssql-system mssql-data mssql-log