############################################################################
############################################################################
#
# SQL Server on AKS Proof of Concept - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/sqlserverakspoc
# Azure Arc SQL Managed Instances
#
############################################################################
############################################################################



# MS documentation
# https://docs.microsoft.com/en-us/azure/azure-arc/data/create-sql-managed-instance



# switch context to cluster 2
kubectl config use-context SQLK8sCluster2



# confirm connection to cluster
kubectl get nodes



# view storage classes
kubectl get storageclass



# view ARC data controller configs
azdata arc dc config list



# create Azure Arc Data Controller
azdata arc dc create `
--connectivity-mode Indirect `
--name arc-dc-01 `
--namespace arc `
--subscription fafcfdcb-d2a1-43a6-adbe-ca29842135a3 `
--resource-group "kubernetes" `
--location eastus2 `
--storage-class default `
--profile-name azure-arc-aks-default-storage



# view pods created in arc namespace
kubectl get pods -n arc



# login to data controller
azdata login -ns arc



# create SQL Managed Instance with 3 replicas
azdata arc sql mi create `
--name sql-01 `
--replicas 3 `
--storage-class-data default `
--storage-class-logs default `
--storage-class-data-logs default `
--storage-class-backups default



# view Managed Instance config
azdata arc sql mi list



# get more info about the Managed Instances
azdata arc sql mi show -n sql-01



# view pods running in arc namespace and get the nodes
kubectl get pods -n arc -o wide



# view the statefulsets
kubectl get statefulsets -n arc



# view the services
kubectl get services -n arc



# test connection to the primary instance
mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "SELECT @@SERVERNAME"



# test connection to the secondary instance
mssql-cli -S 20.72.122.236 -U dbafromthecold -Q "SELECT @@SERVERNAME"



# view the SQL pods
kubectl get pods sql-01-0 sql-01-1 sql-01-2 -n arc -o wide



##
## shut down node the primary pod is running on
##



# watch node until it becomes NotReady
kubectl get nodes --watch



# view pods
kubectl get pods sql-01-0 sql-01-1 sql-01-2 -n arc -o wide



##
## start node the primary pod is running on
##



# watch node until it becomes Ready
kubectl get nodes --watch



# view pods
kubectl get pods sql-01-0 sql-01-1 sql-01-2 -n arc -o wide



# confirm node that primary is running on
mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "SELECT @@SERVERNAME"



# get availability group name
mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "SELECT [name] FROM sys.availability_groups"



# attempt a manual failover
mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "ALTER AVAILABILITY GROUP [containedag] SET (ROLE = SECONDARY);"
mssql-cli -S 20.72.122.236 -U dbafromthecold -Q "ALTER AVAILABILITY GROUP current SET (ROLE = PRIMARY);"



# confirm connection to primary pod
mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "SELECT @@SERVERNAME"



# clean up
azdata arc sql mi delete --name sql-01
azdata arc dc delete --name arc-dc-01 --namespace arc