#!/bin/bash

ca_name=signing-ca

echo "Initializing CA $ca_name"

passwd_opt='-nodes'
read -p "Encrypt with password?(y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[yY]$ ]]; then
	passwd_opt=''
fi

rm -rf ca certs*

mkdir -p ca/$ca_name/private ca/$ca_name/db certs
chmod 700 ca/$ca_name/private

touch ca/${ca_name}/db/${ca_name}.db
touch ca/${ca_name}/db/${ca_name}.db.attr
echo 01 > ca/$ca_name/db/${ca_name}.crt.srl

cert_key=ca/${ca_name}/private/${ca_name}.pem
cert_csr=ca/${ca_name}.csr
cert_file=ca/${ca_name}.pem

openssl req $passwd_opt -new -config etc/${ca_name}.conf \
	-keyout  $cert_key \
	-out $cert_csr \
	-batch

openssl ca -selfsign -config etc/${ca_name}.conf \
	-in $cert_csr \
	-out $cert_file \
	-batch

rm -f ca/${ca_name}.csr &> /dev/null

echo --------------------------------------------------------------------------------
echo  Generated CA certificate: $cert_file
echo            CA private key: $cert_key
echo --------------------------------------------------------------------------------
