#!/bin/sh
#
#   /////////////////////////////////
#  // Revert all field migrations //
# /////////////////////////////////
#

echo -e "\n-------------------------------\nRolling back Field migrations\n"

drush migrate-rollback upgrade_d7_field
drush migrate-rollback upgrade_d7_field_formatter_settings
drush migrate-rollback upgrade_d7_field_instance
drush migrate-rollback upgrade_d7_field_instance_widget_settings

echo -e "\n-------------------------------\nScript complete!\n"