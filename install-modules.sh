#!/bin/sh
#
#   ////////////////////////////
#  // Install DVA D8 modules //
# ////////////////////////////
#

# Import sensitive variables here. See .env.example for an example
LOC=$(dirname $(realpath $0))
source $LOC/.env

cd $PROJECT_LOCATION;

echo -e "\n\nInstalling D8 version of Drupal 7 DVA modules with a D8 upgrade path\n\n";

# Loop over the first argument, which should be a file containing the module names
file=$1


echo -e "\n-------------------------------\nInstalling modules listed in $file\n"

while read p; do
	echo "Installing $p"
	drush en -y "$p"
done < "$file"

echo -e "\n-------------------------------\nModule installation complete\n"
