### Install cert-manager with Vault server

1. Install cert
Install CRDs
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.crds.yaml
Install resource
helm install cert-manager jetstack/cert-manager \
	--namespace cert-manager \
	--create-namespace \
	--version v1.13.0

2. Install ClusterIssuer
Create ClusterIssuer with Cloudflare and owned domain
```
kubectl apply -f clusterissuer.yaml
```
Using `letsencrypt-staging` for testing and development.
Using `letsencrypt` for production.

3. Update Istio IngressGateway
```
kubectl apply -f gateway-tls.yaml
```

Apply the Issuer to istio ingress gateway
```
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: ingress-cert
  namespace: istio-system
spec:
  secretName: ingress-cert
  dnsNames:
  - 'tvminh.co'
  issuerRef:
#    name: letsencrypt-staging // Staging issuer
    name: letsencrypt // Production issuer
    kind: ClusterIssuer
```
