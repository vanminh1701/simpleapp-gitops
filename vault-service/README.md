### vault injector benefits
- Applications remain Vault unaware as the secrets are stored on the file-system in their container.
- Existing deployments require no change; as annotations can be patched.
- Access to secrets can be enforced via Kubernetes service accounts and namespaces

### Install Vault server inside K8s
Download Helm repo

```
helm repo add hashicorp https://helm.releases.hashicorp.com
```

Install Vault server

```
kubectl create namespace vault
helm install vault hashicorp/vault --namespace vault --version 0.26.1
```

Initialize Vault server
```
kubectl exec vault-0 -- vault operator init \
    -key-shares=1 \
    -key-threshold=1 \
    -format=json > cluster-keys.json
```
Unseal
```
kubectl exec vault-0 -- vault operator unseal $(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")
```

### Apply vault agent injector
Deploy helm vault with `externalVaultAddr`
```
helm install vault-injector hashicorp/vault --namespace dev --version 0.26.1 -f helm-vault-agent-injector.yaml
```
### Configure Kubernetes authentication
### Define a Kubernetes service account
Define a service account in K8s and connect to Vault role, so that resource with this service account can access Vault server on specific permission

# Note issue when integration with Istio
https://github.com/hashicorp/vault-k8s/issues/41

Istio sidecar container manage networking of pods, so we need to make sure the injector can access the vault server by config the ExternalService

```
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: vault-service-entry
spec:
  hosts:
    - vault.vault.svc.cluster.local
  ports:
    - number: 8200
      name: http
      protocol: HTTP
  location: MESH_EXTERNAL
  resolution: DNS
```