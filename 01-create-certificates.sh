#!/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

ssl_dir=/opt/repos/devops/tronius-devops-task/ssl

if [[ ! -f ssl/cacert.pem && ! -f ssl/private/cakey.pem ]]; then
    openssl req -x509 -new -config $ssl_dir/openssl-ca.cfg -days 365 -out $ssl_dir/certs/cacert.pem -keyout $ssl_dir/private/cakey.pem
else
    echo "CA certificate and key already exist"
fi


if [[ ! -f ssl/csr/example.com.csr ]]; then
    openssl req -config $ssl_dir/openssl-server.cfg -newkey rsa:4096 -sha256 -nodes -out $ssl_dir/csr/example.com.csr -outform PEM
else
    echo "CSR already exist"
fi


if [[ ! -f ssl/certs/example.com.pem ]]; then
    openssl ca -config $ssl_dir/openssl-ca.cfg -policy policy_anything -extensions signing_req -out $ssl_dir/certs/example.com.pem -infiles $ssl_dir/csr/example.com.csr
else
    echo "example.com certificate and key already exists"
fi


exit 0
