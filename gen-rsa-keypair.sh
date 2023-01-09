#!/bin/bash

# script to generate rsa key pair for key based auth

# generate key, save private key rsa_key.p8
openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out rsa_key.p8 -nocrypt

#To generate an encrypted version, use the following command (which omits “-nocrypt”):

#openssl genrsa 2048 | openssl pkcs8 -topk8 -v2 des3 -inform PEM -out rsa_key.p8

# export public key from the key generated in the above step
openssl rsa -in rsa_key.p8 -pubout -out rsa_key.pub

