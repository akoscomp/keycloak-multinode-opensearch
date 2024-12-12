#!/bin/bash
set -e

# Import realm with overwrite strategy
/opt/keycloak/bin/kc.sh import --file=/opt/keycloak/data/import/realm.json --override=false

# Start Keycloak
exec /opt/keycloak/bin/kc.sh start
