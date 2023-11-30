### Install with istioctl
Make sure the kubectl can connect to the cluster
Run the command:
```
istioctl install
```

### Install kiali UI, Prometheus, jaeger
```
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/kiali.yaml
```
### Add label to `dev` namespace to enable mesh
```
kubectl label namespace dev istio-injection=enabled
```

### Research Gateway API to alternate current VS and DR
