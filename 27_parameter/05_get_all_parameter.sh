#!/bin/bash

paramCount=${#}

if [[ ${paramCount} -ne 4 ]]
then
	echo -e "Usage ${0} a b c d"
else
	allParam=${@}
	echo ${allParam}
fi
