domain="opensearch.local"
LIST="admin node1 node2 node3 keycloak opensearch"
subject="/C=AT/ST=VIE/O=TestLab"

# Root CA
if [[ ! -f root-ca.key ]]; then
    openssl genrsa -out root-ca.key 4096
    openssl req -new -days 3650 -x509 -sha256 -key root-ca.key -out root-ca.crt -subj "/CN=OpenSearch-CA"
fi

# generate server certs with dedicated name
for name in ${LIST}; do

cat << EOF > ${name}-config.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${name}
DNS.2 = opensearch-${name}
DNS.3 = ${name}.${domain}
DNS.4 = opensearch-${name}.${domain}
EOF
    openssl genrsa -out ${name}.key 2048
    openssl req -new -key ${name}.key -out ${name}.csr -subj "${subject}/CN=${name}.${domain}"
    openssl x509 -req -days 3650 -in ${name}.csr -CA root-ca.crt -CAkey root-ca.key -CAcreateserial -sha256 -out ${name}.crt -extfile ${name}-config.ext
done

### Generate a certificate that is valid for all 3 nodes
name="node"
cat << EOF > ${name}-config.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${name}
DNS.2 = opensearch-${name}
DNS.3 = ${name}.${domain}
DNS.4 = opensearch-${name}.${domain}
DNS.5 = node1
DNS.6 = opensearch-node1
DNS.7 = node1.${domain}
DNS.8 = opensearch-node1.${domain}
DNS.9 = node2
DNS.10 = opensearch-node2
DNS.11 = node2.${domain}
DNS.12 = opensearch-node2.${domain}
DNS.13 = node3
DNS.14 = opensearch-node3
DNS.15 = node3.${domain}
DNS.16 = opensearch-node3.${domain}
EOF

    openssl genrsa -out ${name}.key 2048
    openssl req -new -key ${name}.key -out ${name}.csr -subj "${subject}/CN=${name}.${domain}"
    openssl x509 -req -days 3650 -in ${name}.csr -CA root-ca.crt -CAkey root-ca.key -CAcreateserial -sha256 -out ${name}.crt -extfile ${name}-config.ext

# Cleanup
rm *.csr

# set permissions
chmod +r *
