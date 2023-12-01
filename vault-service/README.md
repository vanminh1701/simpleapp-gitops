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
kubectl exec vault-0 -n vault -- sh
vault operator init
```
Unseal
Unseal vault with 3 / 5 token seal

### Apply vault agent injector
Deploy helm vault with `externalVaultAddr`
```
helm install vault-injector hashicorp/vault --namespace dev --version 0.26.1 -f helm-vault-agent-injector.yaml
```
### Configure Kubernetes authentication
### Define a Kubernetes service account
Define a service account in K8s and connect to Vault role, so that resource with this service account can access Vault server on specific permission

### Note issue when integration with Istio
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

## Install VaultOperator to handle secret
// Enable vault k8s access
vault auth enable -path kubernetes kubernetes
// Connect K8s to Vault
vault write auth/kubernetes/config kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443"
// Enable secret kv ver 2
vault secrets enable -path=kvv2 kv-v2
// Create policy
```
  vault policy write dev - <<EOF
  path "kvv2/*" {
     capabilities = ["read"]
  }
  EOF
```
// Create Vault role and connect to K8s service account
Note: Make sure `cert-manager` existed
vault write auth/kubernetes/role/cloudflare \
   bound_service_account_names=default \
   bound_service_account_namespaces=cert-manager \
   policies=dev \
   audience=vault \
   ttl=24h

// Create vault cloudflare secret
vault kv put kvv2/cloudflare/config apiToken="CLOUDFLARE_API_TOKEN"

// Install Operator
helm install vault-secrets-operator hashicorp/vault-secrets-operator -n vault-secrets-operator-system --create-namespace --values vault-operator-values.yaml


