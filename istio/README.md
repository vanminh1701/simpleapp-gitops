### Install with istioctl
Make sure the kubectl can connect to the cluster
Custom `serviceAnnotations` to create AWS NLB
Run the command:
```
istioctl install -f istio.yaml

```

### Install kiali, Prometheus, Jaeger, Grafana
Run `addon.sh` script

### Add label to `dev` namespace to enable mesh
```
kubectl label namespace dev istio-injection=enabled
```

