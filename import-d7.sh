#!/bin/sh
#
#   /////////////////////
#  // Import Drupal 7 //
# /////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env


cd $PROJECT_LOCATION;

echo -e "\n\nImporting Drupal 7 database - to be run inside the Docker CLI container\n\n";

USAGE="import-d7.sh {mysql port} {local database} \n\n e.g. import-d7.sh $MYSQL_PORT my_d7_db.sql"
BACKUP=${2}

if [ "$MYSQL_PORT" = "" ]; then
        echo -e "\nERROR: You didn't include the MySQL container's port. Run 'docker ps' to get it, and include it in .env. \n\n $USAGE "
        exit
elif [ "$BACKUP" = "" ]; then
        echo -e "\nERROR: No local database mentioned!\n\n $USAGE"
        exit
fi

mysql -u $DB_USER -p\$DB_PWD -h docker.for.mac.host.internal -P $MYSQL_PORT $D7_DB_NAME < $BACKUP

echo -e "\n-------------------------------\nImport complete\n"
