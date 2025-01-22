fefwrgDevOps Task: Certificates and Kubernetes

Subtask 1: Certificate Preparation

Generate client and server certificates for the domain myservice.example.com,\
ensuring they are signed by your designated CA certificate. This will authenticate\
and secure communications between
the clients and the server.

Subtask 2: Kubernetes Deployment

Configure a Kubernetes deployment that includes an Ingress nginx controller routing\
HTTPS traffic to port 8443. This setup should target a pod service running an\
HTTPS-enabled daemon, accessible publicly.

Domain should be myservice.example.com.

**Steps:**

>  **Ingress Controller Setup:**\
> •Install the Ingress Nginx (https://kubernetes.github.io/ingress-nginx/) controller in your Kubernetes cluster.
>
> •Configure the Ingress controller to route HTTPS traffic to port 8443
> of the backend service.
>
> **Service and Pod Configuration:**\
> •Deploy a pod running a publicly available HTTPS daemon service.
>
> •Ensure the HTTPS service within the pod is configured to utilize the
> certificates generated in step 1.

**Deployment Files:**

> **Prepare and detail Kubernetes YAML deployment files for:**\
> •The Ingress nginx controller, integrating SSL/TLS configurations
> using the generated certificates.
>
> •The backend HTTPS service, defining the necessary service and deployment specifications to handle HTTPS\
> traffic on port 8443. You can use for backend HTTPS service any publicly available docker image as for example\
> HTTPS daemon or you can code your own HTTPS service.
>
> •Ensure both the Ingress controller and the HTTPS service pods are utilizing the same certificates for SSL/TLS\
> termination, providing a secure, encrypted communication channel.

For this task, you may utilize Docker Desktop's Kubernetes feature
(available on Windows and MacOS) or MiniKube (for Linux environments).\
Alternatively, you are welcome to employ any Kubernetes environment of
your preference.

Requirements

> **1.Documentation:**\
> •Clearly document all necessary steps and technical specifications
> required for the task. Each step should be detailed in a structured\
> document to enhance readability and ease of execution.
>
> **2.Deployment Artifacts:**\
> •Include all relevant Kubernetes YAML deployment files and the
> necessary certificates. Ensure these files are correctly configured to\
> integrate with the specified Kubernetes environment.
>
> **3.Version Control:**\
> •Store all documents, deployment files, and certificates in a GitHub
> or GitLab repository.
>
> **4.Submission:**\
> •Please provide a link to the repository containing all the
> task-related materials. Ensure that the repository is accessible to us
> for review.
