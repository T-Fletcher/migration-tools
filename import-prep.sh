#!/bin/sh
#
#   ////////////////////////////////////////////////
#  // Prep fresh D8 install for importing config //
# ////////////////////////////////////////////////
#

echo -e "Removing import bugs\n"

#echo -e "Importing configuration into a fresh site fails after Basic page content type has been deleted -  https://www.drupal.org/project/drupal/issues/2923899#comment-13118780"
#drush cdel field.field.node.page.body
#drush cdel field.field.node.article.body

echo -e "Config import from a different site fails because of shortcut.set.default.yml - https://www.drupal.org/project/drupal/issues/2583113"
drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'

echo -e "\n-------------------------------\nScript complete!\n"
