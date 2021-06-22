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



# get service IP addresses
$PrimaryIP = $(kubectl get service sql-01-external-svc -n arc --no-headers -o custom-columns=":status.loadBalancer.ingress[*].ip")
$SecondaryIP = $(kubectl get service sql-01-secondary-external-svc -n arc --no-headers -o custom-columns=":status.loadBalancer.ingress[*].ip")



# test connection to the primary instance
mssql-cli -S $PrimaryIP -U dbafromthecold -P Testing1122 -Q "SELECT @@SERVERNAME AS [Server Name];"



# test connection to the secondary instance
mssql-cli -S $SecondaryIP -U dbafromthecold -P Testing1122 -Q "SELECT @@SERVERNAME AS [Server Name]"



# view the SQL pods
kubectl get pods sql-01-0 sql-01-1 sql-01-2 -n arc -o wide



# get primary pod name
$Pod = $(kubectl get pod sql-01-0 -n arc --no-headers -o custom-columns=":metadata.name")



# copy backup to primary pod
kubectl cp C:\git\dbafromthecold\sqlserverakspoc\backup\testdatabase.bak `
$Pod`:var/opt/mssql/data/testdatabase.bak -c arc-sqlmi -n arc



# confirm backup
kubectl exec $Pod -c arc-sqlmi -n arc -- ls /var/opt/mssql/data



# restore database
mssql-cli -S $PrimaryIP -U dbafromthecold -P Testing1122 -Q "RESTORE DATABASE [testdatabase] FROM DISK = '/var/opt/mssql/data/testdatabase.bak'"



# confirm database
mssql-cli -S $PrimaryIP -U dbafromthecold -P Testing1122 -Q "SELECT [name] FROM sys.databases;"
mssql-cli -S $SecondaryIP -U dbafromthecold -P Testing1122 -Q "SELECT [name] FROM sys.databases;"



# get availability group name
mssql-cli -S $PrimaryIP -U dbafromthecold -P Testing1122 -Q "SELECT [name] FROM sys.availability_groups"



# attempt a manual failover
mssql-cli -S $PrimaryIP -d master -U dbafromthecold -P Testing1122 -Q "ALTER AVAILABILITY GROUP current SET (ROLE = SECONDARY);"
mssql-cli -S $SecondaryIP -d master -U dbafromthecold -P Testing1122 -Q "ALTER AVAILABILITY GROUP current SET (ROLE = PRIMARY);"



# confirm new primary & secondary
mssql-cli -S $PrimaryIP -U dbafromthecold -P Testing1122 -Q "SELECT @@SERVERNAME AS [Server Name];"
mssql-cli -S $SecondaryIP -U dbafromthecold -P Testing1122 -Q "SELECT @@SERVERNAME AS [Server Name];"



# clean up
azdata arc sql mi delete --name sql-01
azdata arc dc delete --name arc-dc-01 --namespace arc