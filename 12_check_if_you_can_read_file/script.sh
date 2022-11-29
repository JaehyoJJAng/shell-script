#!/bin/bash

# testing if you can read a file


# first test if the file exists , and is a file

#pwfile=/var/log/auth.log
pwfile=/etc/shadow

if [[ -f ${pwfile} ]]
then
	# now test if you can read
	if [[ -r ${pwfile} ]]
	then
		tail -n 2 ${pwfile}
	else
		echo "Soory, I am unable to read the ${pwfile} file"
	fi
else
	echo "Sorry, the file ${pwfile} does not exist"
fi
