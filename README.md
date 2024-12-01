<p align="center">
Tronius - DevOps Task: Certificates and Kubernetes <br />
v1.0
</p>


<h1><b><p align="center">
Documentation
</p>
</b>
</h1>

<h1\>1\. Prerequirements</h1\>

1.1 Edit GNU/Linux (minikube host)\[1\]  or Windows(public external client)\[2\] hosts file

\[1\] echo "<minikube-ip\> myservice.example.com" >> /etc/hosts

\[2\] add line:

      <public-ip-adress\> myservice.example.com

    to C:\\Windows\\System32\\drivers\\etc\\hosts

1.2 On the minikube host:

  install docker:

     dnf update

     dnf install docker

  install git:

    dnf update

    dnf install git

  install kubectl:

     curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

     install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && rm kubectl

  install minikube:

    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

    install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

  clone git repository:

    mkdir -p /opt/repos/devops/

    cd /opt/repos/devops/

    git clone https://github.com/mblazic/tronius-devops-task.git

    cd tronius-devops-task

    git checkout v1.0

<h1\>2\. Project - tronius-devops-task - start</h1\>

2.1 execute:

      bash 00-minikube-up.sh

    The bash script will export the version of the Kubernetes version, check if kubectl and minikube

    binaries are ready and set the appropriate driver. Lastly, it will start the minikube cluster.

2.2 execute:

      bash 01-create-certificates.sh

    The bash script will create CA certificate and key:

    ssl/certs/cacert.pem

    ssl/private/cakey.pem

    CSR:

    ssl/csr/example.com.csr

    TLS certificate and key for CN example.com and SAN myservice.example.com:

    ssl/certs/example.com.pem

    ssl/private/example.com.pem

    If certificate needs to be revoked, please execute:

    openssl ca -config ssl/openssl-ca.cfg -revoke ssl/certs/example.pem

    Check file ssl/index.txt to confirm successful revocation.

2.3 execute:

      bash 02-project-up.sh

    The bash script will work with Kubernetes:

      create namespace tronius-task

      create secret ssl-example-com with the TLS certificate and key example.com in the tronius-task namespace

      create configmap nginx-config with the nginx configuration (configs/nginx.conf) in the tronius-task namespace

      apply nginx deployment (configs/deployment-nginx.yaml) in the tronius-task namespace

      apply nginx service (configs/service-nginx.yaml) in the tronius-task namespace

      apply nginx ingress (configs/ingress-nginx.yaml) in the tronius-task namespace

2.4 execute:

      minikube tunnel

    Tunnel creates a route to services deployed with type LoadBalancer and sets their Ingress to their ClusterIP.

      The project should accassable:

        via mini kube FQDN (minikube host)

        curl -kv https://myservice.example.com

        via web browser (Windows public external client) - minikube tunnel:

        https://myservice.example.com/

<h1\>3\. Project - tronius-devops-task - stop</h1\>

3.1 execute:

      bash 98-project-down.sh

    The bash script will stop and remove all previously created Kubernetes objects related to tronius-devops-task.

3.2 execute:

      bash 99-minikube-down.sh

    The bash script will stop and remove minikube Kubernetes cluster.
