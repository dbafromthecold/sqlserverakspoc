############################################################################
############################################################################
#
# SQL Server on AKS Proof of Concept - Andrew Pruski
# @dbafromthecold
# dbafromthecold@gmail.com
# https://github.com/dbafromthecold/sqlserverakspoc
# A simple SQL Server Deployment
#
############################################################################
############################################################################



# switch context to cluster 1
kubectl config use-context SQLK8sCluster1



# navigate to yaml files
Set-Location C:\git\dbafromthecold\sqlserverakspoc\yaml



# set context to cluster 1
kubectl config use-context SQLK8sCluster1



# test connection to cluster
kubectl get nodes



# generate yaml for sqlserver deployment
kubectl create deployment sqlserver --image=mcr.microsoft.com/mssql/server:2019-CU11-ubuntu-18.04 --dry-run=client -o yaml



# deploy sql server to cluster
kubectl apply -f .\1.SimpleSqlDeployment.yaml



# view deployment
kubectl get deployment



# view pods
kubectl get pods



# see pod events
kubectl describe pods



# get nodes that pod is deployed on
kubectl get pods -o wide


##
## shut down node that pod is running on
##



# watch node until it becomes NotReady
kubectl get nodes --watch



# watch pod to see if it is moved to a new node
# pod will be created on a new node in ~ 5mins (the default)
kubectl get pods -o wide --watch



# delete deployment
kubectl delete deployment sqlserver



# confirm pod is gone
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



# view updated yaml file
Get-Content .\2.UpdatedSqlDeployment.yaml



# deploy updated yaml file
kubectl apply -f .\2.UpdatedSqlDeployment.yaml



# confirm deployment
kubectl get deployments



# view which node the pod is deployed on
kubectl get pods -o wide



##
## shut down node that pod is running on
##



# watch node until it is NotReady
kubectl get nodes --watch



# watch pod to see if it is moved to a new node
kubectl get pods -o wide --watch



# confirm new pod
kubectl get pods -o wide



##
## start node that pod was running on
##



# watch node until it is in a Ready state
kubectl get nodes --watch



# watch the pods
kubectl get pods -o wide --watch



# confirm pod
kubectl get pods



# delete the deployment
kubectl delete deployment sqlserver