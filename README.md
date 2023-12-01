### Simple application with GitOps practice
This project is an GitOps demo project with full Software developer life cycle. The project focus to automation pipeline with Jenkins and use some common components in Kubernetes ecosystem.

### Motivation
The containerization is more and more popular than virtualization these days. Almost of developers choose this technology for their new project or decide to migrate from VM to container.
Kubernetes is a powerful and extensible container orchestration technology that allows you to deploy and manage containerized applications at scale.

This project contains parts:

1. Automation CI/CD

    The Jenkins pipeline includes steps:
    
    - Integrate a webhook with Github repository to trigger pipeline whenever code commits are merged to `production` or `canary` branch
    - Contain main stages to build source code, build and upload docker image and update Argo application to deploy Kubernetes services.
    - Pipeline status notification to Slack

2. Environments
    - Local Development

        Although [minikube](https://minikube.sigs.k8s.io/docs/start/) is a very popular and native supported by Kubernetes community, I decide to choose to use [K3s](https://k3s.io/) because it is faster and consume less resources.
    - AWS Cloud

        Deploy Kubernetes to AWS using [EKS service](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html). The installation is done with Terraform project
3. Infrastructure as Code
    
    [Terraform](https://www.terraform.io/) is a famous infrastructure tool to provision and manage resource in and cloud. I choose it to setup all infrastructure on AWS cloud.
    
    [Reference](/terraform/)

4. Kubernetes systems

    - GitOps with [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)
    
        ArgoCD is a common GitOps continuous delivery tool for Kubernetes. It has a very nice UI for operator to make easier understand the workflow and changes on CD phase. 
        Manifest files in repository is managed by [Kustomize](https://kustomize.io/) tool.

        The configuration is in folder [argocd/](/argocd/)
    
    - Service Mesh: [Istio](https://istio.io/latest/)

        A service mesh is a layer is added to infrastructure. It allows you to transparently add capabilities like observability, traffic management, and security, without adding them to your own code.
        I use Istio to enable mTLS, canary deployment flow and setup a gateway for K8s cluster.

        The configuration is in folder [istio/](/istio/)

    - Manage Credentials: [Vault](https://www.vaultproject.io/)

        Install a Vault server inside cluster to manage whole project credentials. It contains Vault Operator and Vault Agent Injector

        - Vault Operator: help to synchronize vault secrets to K8s native Secret object. It will interval check secret in Vault server and sync to K8s
        - Vault Agent Injector: help to render Vault secrets to a shared memory volume in pods. 

        [Reference](/vault-service/)

    - Certificate Management: [cert-manager](https://cert-manager.io/)
    
        Cert-manager help to setup TLS termination for cluster.
        Certificates are created by Let's Encrypt issuer and connect to Istio ingress gateway to handle HTTPS requests.

        [Reference](/cert-manager/)

    - Helm

        Helm is used to manage and deploy above packages: Vault, cert-manager. 

