#!/bin/bash

set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

kubectl delete -f configs/ingress-nginx.yaml > /dev/null 2>&1
echo "nginx ingress terminated"

kubectl delete -f configs/service-nginx.yaml > /dev/null 2>&1
echo "nginx service terminated"

kubectl delete -f configs/deployment-nginx.yaml > /dev/null 2>&1
echo "nginx deployment terminated"

kubectl -n tronius-task delete configmaps nginx-config > /dev/null 2>&1
echo "nginx configmap terminated"

kubectl -n tronius-task delete secrets ssl-example-com > /dev/null 2>&1
echo "ssl certificate secret terminated"

kubectl delete namespace tronius-task > /dev/null 2>&1
echo "tronius-task namespace terminated"
echo

echo
echo "project successfully terminated!"
