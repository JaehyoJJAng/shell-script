#!/bin/bash

####### Check if either a directory or file exists ########

item_name=${HOME}

echo -e "\nthe item being checked: ${item_name}\n"

if [[ -e ${item_name} ]]; then
	echo "The item ${item_name}, does exists"
	echo "But is it a file?"

	if [[ -f ${item_name} ]]; then
		echo "Yes , ${item_name} is a file"
	else
		echo "No , ${item_name} is not a file"
	fi

else
	echo "The item , ${item_name} does not exists"
fi
