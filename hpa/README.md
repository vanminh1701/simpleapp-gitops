### Apply Horizontal Autoscaler Pod with KEDA external metric
This example will help to setup HPA with request rate on Prometheus Traefik load balancer
```
    query: |
       sum(rate(traefik_service_requests_total{code="200"}[1m]))
    threshold: "2.0"
```

### Install Prometheus server
```
helm install -f prom-values.yaml prom prometheus-community/prometheus -n prom
```

### Install KEDA CRD
```
kubectl apply -f https://github.com/kedacore/keda/releases/download/v2.4.0/keda-2.4.0.yaml
```

### Install resource and ScaledObject
```
kubectl apply -f php-apache.yaml hpa.yaml
```

