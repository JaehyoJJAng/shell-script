#!/bin/bash

# testing file execution

FILE='./test.sh'

if [[ -x ${FILE} ]]
then
	echo "You can run the script:"
	${FILE}
else
	echo "Sorry, you are unable to execute the script"
fi
