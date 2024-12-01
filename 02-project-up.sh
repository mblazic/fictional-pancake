#!/bin/bash

set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

kubectl create namespace tronius-task > /dev/null 2>&1
echo "namespace tronius-task created"

kubectl -n tronius-task create secret tls ssl-example-com \
        --cert=ssl/certs/example.com.pem \
        --key=ssl/private/example.com.pem > /dev/null 2>&1
echo "exmaple.com certificate and key imported as secret into namespace tronius-task"

kubectl -n tronius-task create configmap nginx-config --from-file=configs/nginx.conf > /dev/null 2>&1
echo "nginx configuration configmap successfully created"

kubectl apply -f configs/deployment-nginx.yaml > /dev/null 2>&1
echo "nginx deployment created"

kubectl apply -f configs/service-nginx.yaml > /dev/null 2>&1
echo "nginx service created"

kubectl apply -f configs/ingress-nginx.yaml > /dev/null 2>&1
echo "nginx ingress created"
