#!/bin/sh
#
#   ////////////////////
#  // Run migrations //
# ////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env

cd $PROJECT_LOCATION;

echo -e "\n\nRunning Drupal 8 migrations...\n\n";

# Loop over the first argument, which should be a file containing the migration names
file=$1


echo -e "\n-------------------------------\nRunning migrations listed in $file\n"

while read p; do
	echo -e "\n\n*****\nRunning migration: $p\n********\n\n"

	echo -e "\nUnlocking $p\n"
	drush migrate-reset "$p"

	echo -e "\nRolling back any previous imported material generated from $p...\n"
	drush migrate-rollback "$p"
	
	echo -e "\nImporting migration: $p...\n\n"
	drush migrate-import "$p"

	echo -e "\nOutputting migration log, if any...\n"
	drush mmsg "$p"

done < "$file"

echo -e "\n-------------------------------\nMigrations complete\n"
