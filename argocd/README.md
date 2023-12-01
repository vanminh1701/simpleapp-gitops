### Install ArgoCD CRD
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
### Install application
```
  kubectl apply -f application.yaml
```
