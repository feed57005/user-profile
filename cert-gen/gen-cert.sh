#!/bin/bash

cert_name=cert
if [ $# -eq 1 ]; then
	cert_name=$1
fi
ca_name=signing-ca

passwd_opt='-nodes'
read -p "Encrypt with password?(y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[yY]$ ]]; then
	passwd_opt=''
fi

extension=server_ext
read -p "Extension to use (s)erver, (c)lient:" -n 1 -r
echo
if [[ $REPLY =~ ^[cC]$ ]]; then
	extension=client_ext
fi

cert_key=certs/${cert_name}-key.pem
cert_csr=certs/${cert_name}.csr
cert_file=certs/${cert_name}.pem

openssl req $passwd_opt -new -config etc/${ca_name}.conf \
	-keyout $cert_key \
	-out $cert_csr

openssl ca -config etc/${ca_name}.conf \
	-in $cert_csr \
	-out $cert_file \
	-extensions $extension \
	-batch

rm -f $cert_csr &> /dev/null

echo --------------------------------------------------------------------------------
echo  Generated certificate: $cert_file
echo            private key: $cert_key
echo --------------------------------------------------------------------------------
