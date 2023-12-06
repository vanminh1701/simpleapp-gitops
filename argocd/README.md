### Install ArgoCD CRD
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Install Slack notification
```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-notifications/release-1.0/catalog/install.yaml
kubectl patch secret argocd-notifications-secret -n argocd --type merge --patch '{"stringData":{"slack-token": "xoxb-XXX"}}'
kubectl patch configmap argocd-notifications-cm -n argocd --type merge -p '{"data": {"service.slack": "token: $slack-token"}}'

```

### Install application
```
  kubectl apply -f application.yaml
```
