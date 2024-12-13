# Keycloak with Opensearch multinode integration with SSL enabled

## Requirements
* add line in `/etc/hosts`: `127.0.0.1 keycloak.opensearch.local opensearch.opensearch.local node1.opensearch.local`

## run the project
* `cd /certs/`
* `./generate_certs.sh`
* `docker compose pull`
* `docker compose up -d`

### Connect to services:
* https://opensearch.opensearch.local:5601/
* https://keycloak.opensearch.local:5601/

## Enable debug log for OpenSearch:
* `curl --cacert ./certs/root-ca.crt -X PUT "https://node1.opensearch.local:9200/_cluster/settings" -u 'admin:OPENSEARCH_INITIAL_ADMIN_PASSWORD' -H 'Content-Type: application/json' -d '{"persistent": {"logger": {"_root": "DEBUG","org.elasticsearch.action": "DEBUG","org.elasticsearch.action.admin.cluster.health": "TRACE"}}}'`
* `curl --cacert certs/ca.crt -X GET "https://node1.mosaix.frq:9200/" -u 'admin:OPENSEARCH_INITIAL_ADMIN_PASSWORD'`
