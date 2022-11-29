#!/bin/bash

# check if a file is writable

item_name="${HOME}/sentinel"

if [[ -f ${item_name} ]]
then
	echo "Yes, ${item_name} is a file"
	echo "But is it writeable?"

	if [[ -w ${item_name} ]]
	then
		echo "Writing current time to ${item_name}"
		date +"%Y_%m_%d_%H%M" >> ${item_name}
	else
		echo "Unable to write to ${item_name}"
	fi
else
	echo "The file ${item_name} is not a file"
fi
