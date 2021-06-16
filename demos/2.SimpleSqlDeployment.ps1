


Set-Location C:\git\dbafromthecold\sqlserverakspoc\yaml



kubectl config use-context SQLK8sCluster1



kubectl get nodes



kubectl create deployment sqlserver --image=mcr.microsoft.com/mssql/server:2019-CU11-ubuntu-18.04 --dry-run=client -o yaml



kubectl apply -f .\1.SimpleSqlDeployment.yaml



kubectl get deployment



kubectl get pods



kubectl describe pods



kubectl get pods -o wide



kubectl get nodes --watch



kubectl get pods -o wide --watch



# pod will be created on a new node in ~ 5mins (the default)
kubectl delete deployment sqlserver



kubectl get pods



# so we need to adjust the pod eviction time
# https://dbafromthecold.com/2020/04/08/adjusting-pod-eviction-time-in-kubernetes/



# if this was an on-premises cluster, we could set this cluster wide with kubeadm

# apiVersion: kubeadm.k8s.io/v1beta2
# kind: ClusterConfiguration
# kubernetesVersion: v1.18.0
# apiServer:
#   extraArgs:
#     enable-admission-plugins: DefaultTolerationSeconds
#     default-not-ready-toleration-seconds: "10"
#     default-unreachable-toleration-seconds: "10"


# but as we have no access to the control plane in AKS, we set the tolerations in the deployment yaml

#tolerations:
#- key: "node.kubernetes.io/unreachable"
#  operator: "Exists"
#  effect: "NoExecute"
#  tolerationSeconds: 10
#- key: "node.kubernetes.io/not-ready"
#  operator: "Exists"
#  effect: "NoExecute"
#  tolerationSeconds: 10



Get-Content .\2.UpdatedSqlDeployment.yaml



kubectl get pods



kubectl apply -f .\2.UpdatedSqlDeployment.yaml



kubectl get deployments



kubectl get pods -o wide



kubectl get nodes --watch



kubectl get pods -o wide --watch



kubectl get pods -o wide



kubectl get nodes --watch



kubectl get pods -o wide --watch



kubectl get pods



kubectl delete deployment sqlserver