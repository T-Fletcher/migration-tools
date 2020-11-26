#!/bin/sh
#
#   //////////////////////////////
#  // Run a single  migrations //
# //////////////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env
MIGRATION=$1
LIMIT=${2:-10}

cd $PROJECT_LOCATION;

echo -e "\n-------------------------------\nRunning a fresh migration: $MIGRATION\n"

echo -e "Unlocking $MIGRATION"
drush migrate-reset $MIGRATION

echo -e "Rolling back any previous imported material generated from $MIGRATION..."
drush migrate-rollback $MIGRATION

echo -e "Importing latest config changes..."
drush cim -y

echo -e "Importing migration: $MIGRATION (defaults to 10 items, specify more with $ bash script_name migration_name count)"
drush migrate-import $MIGRATION --limit=$LIMIT

echo -e "\n-------------------------------\nScript complete!\n"