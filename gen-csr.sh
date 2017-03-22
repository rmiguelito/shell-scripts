#!/bin/bash

#Maintener Rodrigo Miguel rodrigomvi@algartech.com 
#Required
domain=$1
commonname=$domain
 
#Change to your company details
country='BR'
state='DF'
locality='Brasilia'
organization='ORG'
organizationalunit='OU'
email='email'
 
#Optional
password=pass
 
if [ -z "$domain" ]
then
    echo "Argument not present."
    echo "Useage $0 [common name]"
 
    exit 99
fi
 
echo "Generating key and Creating CSR request for $domain"
 
 
#Create the request
echo "Creating CSR"
openssl req -newkey rsa:2048 -keyout $domain.key -keyform PEM -SHA256 -out $domain.csr -passout pass:$password \
    -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

#Remove passphrase from the key. Comment the line out to keep the passphrase
echo "Removing passphrase from key"
openssl rsa -in $domain.key -passin pass:$password -out $domain.key


	
echo "---------------------------"
echo "-----Below is your CSR-----"
echo "---------------------------"
echo
cat $domain.csr
 
echo
echo "---------------------------"
echo "-----Below is your Key-----"
echo "---------------------------"
echo
cat $domain.key
