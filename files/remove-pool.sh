#!/bin/bash

# To be run after removing a pool from Duffy's config

# This will remove all history of the pool from Duffy's DB, which will then
# mean Zabbix will stop trying to monitor the old pool

pool=$1

if [ -z $pool ] ; then
  echo "Usage: remove-pool.sh POOL_NAME"
  exit 1
fi

psql -U duffy duffy -e -c "DELETE FROM sessions_nodes WHERE pool='$pool' ;"
psql -U duffy duffy -e -c "DELETE FROM sessions WHERE data->'nodes_specs'->0->>'pool'='$pool' ;"
psql -U duffy duffy -e -c "DELETE FROM nodes WHERE pool='$pool' ;"
