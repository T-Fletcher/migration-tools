#!/bin/sh
#
#   /////////////////////////////////
#  // Revert all field migrations //
# /////////////////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env

cd $PROJECT_LOCATION;

echo -e "\n-------------------------------\nRolling back Field migrations\n"

drush migrate-rollback upgrade_d7_field
drush migrate-rollback upgrade_d7_field_formatter_settings
drush migrate-rollback upgrade_d7_field_instance
drush migrate-rollback upgrade_d7_field_instance_widget_settings

echo -e "\n-------------------------------\nScript complete!\n"