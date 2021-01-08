#!/bin/sh
#
#   //////////////////////////////////////////////////////
#  // Fresh D8 install including Drush migration tools //
# //////////////////////////////////////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env

cd $PROJECT_LOCATION;

read -p "Do you want to reinstalling a fresh copy of Drupal 8? The database will be overwritten!!" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo -e "\n-------------------------------\nInstalling Drupal\n"
	drush si -y
	echo -e "\n-------------------------------\nDrupal installation complete\n"
fi

read -p "Do you want to set the UUID, admin details and install basic migration tools?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo -e "\nSetting UUID of site to match PROD\n"
	drush config-set "system.site" uuid $PROD_SITE_UUID -y

	# echo -e "\nAddressing Shortcut import bug - https://www.dannyenglander.com/blog/drupal-8-development-how-import-existing-site-configuration-new-site\n"
	# drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'

	echo -e "\nInstalling Migration tools\n"
	drush en -y migrate_tools migrate_plus migrate_upgrade

	echo -e "\nResetting Admin password\n"
	drush upwd admin "admin"

	echo -e "\n-------------------------------\nHelpful stuff complete!\n"
else 
	echo "Not much to do here then..."
fi
