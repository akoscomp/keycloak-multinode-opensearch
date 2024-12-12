# Keycloak with Opensearch multinode integration with SSL enabled

## Requirements
* add line in `/etc/hosts`: `127.0.0.1 keycloak opensearch`

## run the project
* `cd /certs/`
* `./generate_certs.sh`
* `docker compose pull`
* `docker compose up -d`

## Enable debug log for OpenSearch:
* `curl --insecure -X PUT "https://localhost:9200/_cluster/settings" -u 'admin:OPENSEARCH_INITIAL_ADMIN_PASSWORD' -H 'Content-Type: application/json' -d '{"persistent": {"logger": {"_root": "DEBUG","org.elasticsearch.action": "DEBUG","org.elasticsearch.action.admin.cluster.health": "TRACE"}}}'`
