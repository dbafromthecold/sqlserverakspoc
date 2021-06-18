

# https://docs.microsoft.com/en-us/azure/azure-arc/data/create-sql-managed-instance



kubectl config use-context SQLK8sCluster2



kubectl get nodes



kubectl get storageclass



azdata arc dc config list



azdata arc dc create `
--connectivity-mode Indirect `
--name arc-dc-01 `
--namespace arc `
--subscription fafcfdcb-d2a1-43a6-adbe-ca29842135a3 `
--resource-group "kubernetes" `
--location eastus2 `
--storage-class default `
--profile-name azure-arc-aks-default-storage



kubectl get pods -n arc



azdata login -ns arc



azdata arc sql mi create `
--name sql-01 `
--replicas 3 `
--storage-class-data default `
--storage-class-logs default `
--storage-class-data-logs default `
--storage-class-backups default



azdata arc sql mi list



azdata arc sql mi show -n sql-01


kubectl get pods -n arc -o wide



kubectl get statefulsets -n arc



kubectl get services -n arc



mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "SELECT @@SERVERNAME"



mssql-cli -S 20.72.122.236 -U dbafromthecold -Q "SELECT @@SERVERNAME"



kubectl get pods sql-01-0 sql-01-1 sql-01-2 -n arc -o wide



kubectl get nodes --watch



kubectl get pods sql-01-0 sql-01-1 sql-01-2 -n arc -o wide



mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "SELECT @@SERVERNAME"



mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "SELECT [name] FROM sys.availability_groups"



mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "ALTER AVAILABILITY GROUP [containedag] SET (ROLE = SECONDARY);"



mssql-cli -S 20.72.122.236 -U dbafromthecold -Q "ALTER AVAILABILITY GROUP current SET (ROLE = PRIMARY);"



mssql-cli -S 20.72.123.69 -U dbafromthecold -Q "SELECT @@SERVERNAME"


azdata arc sql mi delete --name sql-01
azdata arc dc delete --name arc-dc-01 --namespace arc