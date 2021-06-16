


Set-Location C:\git\dbafromthecold\sqlserverakspoc\yaml



kubectl get storageclass



Get-Content .\3.CreatePVCs.yaml



kubectl apply -f .\3.CreatePVCs.yaml



kubectl get pvc



kubectl get pv



kubectl apply -f .\4.SqlServerDeploymentWithStorage.yaml



kubectl get deployments



kubectl get pvc



kubectl get pv



kubectl get deployments



kubectl get pods



kubectl describe pods



kubectl get pods -o wide



kubectl get nodes --watch



kubectl get pods -o wide --watch



kubectl get pods



kubectl describe pod sqlserver-8577dc65fc-mkdp



kubectl get pods



kubectl get nodes --watch



# once the node comes back online the old pod will be terminated and the new one will come online (eventually)
kubectl get pods --watch



kubectl get pods



kubectl describe pods



kubectl delete deployment sqlserver
kubectl delete pvc mssql-system mssql-data mssql-log