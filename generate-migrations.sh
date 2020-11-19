#!/bin/sh
#
#   //////////////////////////////////
#  // Generate Drupal 7 migrations //
# //////////////////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env


cd $PROJECT_LOCATION;

echo -e "\n\nGenerating Drupal 7 migrations - to be run inside the Docker CLI container\n\n";

drush migrate-upgrade --legacy-db-key=$DB_KEY --legacy-root=$SOURCE_SITE --configure-only

echo -e "\n-------------------------------\nMigration generation complete. Run drush cex -y to export the migrations as configuration. \n"
