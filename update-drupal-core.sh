#!/bin/sh
#
#   ///////////////////////////
#  // Upgrade Drupal 8 core //
# ///////////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env

TODAY=$(TZ=:Australia/Sydney date -d "today" '+%Y-%m-%d_%H-%M-%S')
FILENAME="db-local-$TODAY.sql"


cd $PROJECT_LOCATION;

echo -e "Exporting database dump before attempting core update..."

drush sql-dump > "$FILENAME"
gzip -f "$FILENAME" && echo "$FILENAME compressed!"

echo -e "\n\nUpdating Drupal 8 - to be run inside the Docker CLI container\n\n";

composer update drupal/core-recommended --with-dependencies

echo "Backing up hidden core files, these will be restored after the update..."
cd web && tar -cf core-files.tar .csslintrc .editorconfig .eslintignore .eslintrc.json .gitattributes .ht.router.php .htaccess index.php
mv core-files.tar ..
cd ..

echo -e "Running database updates, if any..."

drush updb
drush status

echo -e "Restoring hidden core files..."
tar -xf core-files.tar -C web/

echo -e "Removing archive..."
rm -f core-files.tar

echo -e "\n-------------------------------\nCore update complete. Be sure to check the site!\n"
