#!/bin/sh
#
#   //////////////////////////
#  // Roll back migrations //
# //////////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env

cd $PROJECT_LOCATION;

echo -e "\n\nRolling back Drupal 8 migrations...\n\n";

# Loop over the first argument, which should be a file containing the migration names
file=$1


echo -e "\n-------------------------------\nRolling back migrations listed in $file\n"

while read p; do
	echo "Rolling back $p"
	drush migrate-rollback "$p"
done < "$file"

echo -e "\n-------------------------------\nRollback complete\n"
