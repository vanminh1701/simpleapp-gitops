
### Install CRD
```
kubectl create ns argo-rollouts
kubectl apply -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml -n argo-rollouts
```

### Setup Rollout Notification
 
```
kubectl apply -k .
```

Setup rollout feature for simpleapp deployment, reference in [manifest resource](https://github.com/vanminh1701/simpleapp-manifests/blob/master/base/simpleapp/rollouts.yaml)

