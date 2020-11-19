#!/bin/sh
#
#   /////////////////////////
#  // Export DVA database //
# /////////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env


echo -e "\nExporting mysql dump of this website\n"

TODAY=$(TZ=:Australia/Sydney date -d "today" '+%Y-%m-%d_%H-%M-%S')
FILENAME="db-local-$TODAY.sql"

cd $PROJECT_LOCATION;

drush sql-dump > "$FILENAME"

gzip -f "$FILENAME" && echo "$FILENAME compressed!"

echo -e "\n-------------------------------\nDatabase export complete!\n"
