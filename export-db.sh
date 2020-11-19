#!/bin/sh
#
#   /////////////////////////
#  // Export DVA database //
# /////////////////////////
#

echo -e "\nExporting mysql dump of this website\n"

TODAY=$(TZ=:Australia/Sydney date -d "today" '+%Y-%m-%d_%H-%M-%S')
FILENAME="db-local-$TODAY.sql"

drush sql-dump > "$FILENAME"

gzip -f "$FILENAME" && echo "$FILENAME compressed!"

echo -e "\n-------------------------------\nDatabase export complete!\n"
