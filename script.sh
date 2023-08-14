#!/bin/bash

mkdir sysA
mkdir sysB

openssl genpkey -algorithm RSA -out private.pem
opensll rsa -pubout -in private.pem -out public.pem
openssl genpkey -algorithm RSA -out systemb_public.pem
opnessl rsa -pubout -in systemb_private.pem -out systemb_public.pem

dataA="Hello This Is System A"
dataB= "Hello This Is System B"
symmetrickeys=kali

echo "dataA" | openssl enc -aes-256-cbc -k "$symmetrickeys" -out encA.enc
echo "dataB" | openssl enc -aes-256-cbc -k "$symmetrickeys" -out encB.enc

cp systemb_public.pem sysA
cp public.pem sysB

openssl dgst -sh256 -sign private.pem -out signA.sha encA.enc
openssl dgst -sh256 -sign systemb_private.pem -out signB.sha encB.enc

#sysA decrypts sysb's Data
openssl enc -aes-256-cbc -d -k "$symmetrickeys" -in encB.enc -out decryptedB_data.txt
openssl dgst -sha256 -verify systemb_private.pem -signature signB.sha encB.enc

#sysB decrypts sysA Data
decrypted_data.txt 
openssl enc -aes-256-cbc -d -k "$symmetrickeys" -in encB.enc -out decrypted_data.txt
openssl dgst -sha256 -verify private.pem -signature signa.sha encA.enc

echo "decrypted data from A : $(cat decrypted_data.txt)"
echo "decrypted data from B: $(cat decryptedB_data.txt)"
