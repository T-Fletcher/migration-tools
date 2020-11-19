#!/bin/sh
#
#   //////////////////////////////////////////////////////
#  // Fresh D8 install including Drush migration tools //
# //////////////////////////////////////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env


read -p "Reinstalling a fresh copy of Drupal 8 - the database will be overwritten!! Are you sure you want to continue? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo -e "\n-------------------------------\nInstalling Drupal\n"
	drush si -y

	echo -e "\nSetting UUID of site to match PROD\n"
	drush config-set "system.site" uuid $PROD_SITE_UUID -y

	# echo -e "\nAddressing Shortcut import bug - https://www.dannyenglander.com/blog/drupal-8-development-how-import-existing-site-configuration-new-site\n"
	# drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'

	echo -e "\nInstalling Migration tools\n"
	drush en -y migrate_tools migrate_plus migrate_upgrade

	echo -e "\nResetting Admin password\n"
	drush upwd admin "admin"

	echo -e "\n-------------------------------\nScript complete!\n"
else 
	echo "Probably a wise choise..."
fi
