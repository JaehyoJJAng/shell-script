#!/bin/bash

IFS=:
users=($(cat /etc/passwd))
for user in "${users[@]}"
do
	echo ${user}
done


