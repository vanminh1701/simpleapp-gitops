### Apply CRD resources
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

1. Apply simple rollout
2. integrate traffic splitting with Istio
3. Custom Metric with Prometheus
4. Rollout Abort when failure metrics
5. Notification
