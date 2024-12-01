#!/usr/bin/env bash

set -e

# variables
source ./_init_variables.sh

# check minikube
command -v minikube 2>&1 || {
    echo "Could not find minikube on machine...";
    exit 1
}

# check kubectl
command -v kubectl 2>&1 || {
    echo "Could not find kubectl on machine...";
    exit 1
}

case "$(uname -s)" in
   # if running on MacOS then use hyperkit virtualizator
   Darwin*)
     minikube config set vm-driver hyperkit;;
   # driver docker or none, no nested virtualization configured
   Linux*)
     minikube config set vm-driver docker;;
   *)
     minikube config set vm-driver virtualbox;;
esac

( minikube status ) || minikube start --kubernetes-version ${KUBERNETES_VERSION} --nodes 2


# enable ingress
minikube addons enable ingress
# enable volume snapshots and CSI driver
minikube addons enable volumesnapshots
minikube addons enable csi-hostpath-driver

# set default storage class for persistent storage
kubectl patch storageclass csi-hostpath-sc -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'


MINIKUBE_IP=`minikube ip`


echo
echo "MiniKube is up on ${MINIKUBE_IP} address."
