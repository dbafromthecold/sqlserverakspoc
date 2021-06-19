############################################################################
############################################################################
#
# SQL Server on AKS Proof of Concept - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/sqlserverakspoc
# Deploying SQL Server with Portworx persistent storage
#
############################################################################
############################################################################



# navigate to yaml files
Set-Location C:\git\dbafromthecold\sqlserverakspoc\yaml



# view yaml to create portworx storage class
Get-Content .\5.CreatePortworxStorageClass.yaml



# create Portworx storage class
kubectl apply -f .\5.CreatePortworxStorageClass.yaml



# view storage classes
kubectl get storageclass



# view yaml to create Portworx PVCs
Get-Content .\6.CreatePortworxPVCs.yaml



# create Portworx PVCs
kubectl apply -f .\6.CreatePortworxPVCs.yaml



# view persistent volume claims
kubectl get pvc



# view persistent volume claims
kubectl get pv



# view yaml to create SQL Server using Portworx PVCs
Get-Content .\7.SqlServerDeploymentWithPortworx.yaml



# deploy SQL Server using Portworx PVCs
kubectl apply -f .\7.SqlServerDeploymentWithPortworx.yaml



# confirm deployments
kubectl get deployment



# view pods
kubectl get pods



# view pod events
# notice no attach/detach controller
kubectl describe pods



# confirm node that pod is running on
kubectl get pods -o wide



##
## shut down node that pod is running on
##



# watch node until it is NotReady
kubectl get nodes --watch



# watch pod to see if it is moved to new node
kubectl get pods -o wide --watch



# confirm pod
kubectl get pods -o wide



# view pod events
kubectl describe pods



# have another look at the pod
kubectl get pods -o wide



# clean up
kubectl delete deployment sqlserverakspoc
kubectl delete pvc mssql-data mssql-log mssql-system