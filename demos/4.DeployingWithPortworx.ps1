


Set-Location C:\git\dbafromthecold\sqlserverakspoc\yaml



Get-Content .\5.CreatePortworxStorageClass.yaml



kubectl apply -f .\5.CreatePortworxStorageClass.yaml



kubectl get storageclass



Get-Content .\6.CreatePortworxPVCs.yaml



kubectl apply -f .\6.CreatePortworxPVCs.yaml



kubectl get pvc



kubectl get pv



Get-Content .\7.SqlServerDeploymentWithPortworx.yaml



kubectl apply -f .\7.SqlServerDeploymentWithPortworx.yaml



kubectl get deployment



kubectl get pods



# notice no attach/detach controller
kubectl describe pods



kubectl get pods -o wide



kubectl get nodes --watch



kubectl get pods -o wide --watch



kubectl get pods



kubectl describe pods



kubectl get pods



kubectl delete deployment sqlserverakspoc
kubectl delete pvc mssql-data mssql-log mssql-system