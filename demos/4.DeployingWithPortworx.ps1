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



# Portworx website
# https://portworx.com/
# https://portworx.com/how-to-run-ha-sql-server-on-azure-kubernetes-service/ 



# switch context to cluster 1
kubectl config use-context SQLK8sCluster1



# navigate to yaml files
Set-Location C:\git\dbafromthecold\sqlserverakspoc\yaml



# create service principal
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"



# create secret for portworx to access Azure APIs
kubectl create secret generic -n kube-system px-azure --from-literal=AZURE_TENANT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx `
                                                      --from-literal=AZURE_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx `
                                                      --from-literal=AZURE_CLIENT_SECRET=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx




# apply config generated from Portworx portal
kubectl apply -f portworx_essentials.yaml



# view portworx resources in kube-system namespace
kubectl get all -n kube-system



# view daemonsets
kubectl get ds -n kube-system



# view Portworx pods
kubectl get pods -n=kube-system -l name=portworx -o wide



# get Portworx status
PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')
kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl status



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
kubectl delete deployment sqlserver
kubectl delete pvc mssql-data mssql-log mssql-system