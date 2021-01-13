#!/bin/sh
#
#   //////////////////////////////////
#  // Run Icon Agency's migrations //
# //////////////////////////////////
#

START=`date +%s`

echo -e "\n\n***************\nRunning a fresh migration"

echo -e "\n-------------\nReplacing database with fresh template..."
drush sql-drop -y
drush sql-cli < /Users/tim/repositories/dva-d9/localhost-dvamigrate-empty-site.sql

echo -e "\n-------------\nEnabling required modules..."
drush en -y migrate_plus migrate_drupal migrate_tools migrate_upgrade media_migration smart_sql_idmap field_group field_group_migrate

echo -e "\n-------------\nImporting Icon migration configuration"
drush config-import -y --partial --source=modules/custom/icon_migrate/config/install

echo -e "\n-------------\nMigrating Configuration"
drush migrate:import --group=icon_migrate --tag=Configuration --execute-dependencies --continue-on-failure

echo -e "\n-------------\nMigrating Files and assets"
drush migrate:import --group=icon_migrate --tag=Asset --execute-dependencies --continue-on-failure

echo -e "\n-------------\nMigrating Nodes (this will take a while)"
drush migrate:import --group=icon_migrate --tag=Node --execute-dependencies

echo -e "\n-------------\nMigrating Menus"
drush migrate:import --group=icon_migrate --tag=Menu --execute-dependencies

echo -e "\n-------------\nEnabling Icon Migrate Blocks module"
drush en -y icon_migrate_block

echo -e "\n-------------\nMigrating Blocks"
drush migrate:import --group=icon_migrate_block --tag=Block


END=`date +%s`
TIMER_SECONDS=$((END-START))

printf 'Migration completed in %02dh:%02dm:%02ds\n' $(($TIMER_SECONDS/3600)) $(($TIMER_SECONDS%3600/60)) $(($TIMER_SECONDS%60))

echo -e "\n\n*********** Migration complete ***************\n\n"
