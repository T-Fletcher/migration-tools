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

echo -e "\n-------------------------------\nRunning a fresh migration: $MIGRATION...\n"

echo -e "\nUnlocking $MIGRATION\n"
drush migrate-reset $MIGRATION

echo -e "\nRolling back any previous imported material generated from $MIGRATION...\n"
drush migrate-rollback $MIGRATION

echo -e "\nImporting latest config changes...\n"
drush cim -y

echo -e "\nImporting migration: $MIGRATION (defaults to 10 items, specify more with $ bash script_name migration_name count)...\n\n"
drush migrate-import $MIGRATION --limit=$LIMIT

echo -e "\nOutputting migration log, if any...\n"
drush mmsg $MIGRATION

echo -e "\n-------------------------------\nImport complete. Be sure to check the results!\n"