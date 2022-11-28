#!/bin/bash

# Testing Nested ifs - use elif & else

testUser='NoSuchUser'

if grep ${testUser} /etc/passwd; then
	echo "The user ${testUser} exists on this system"
elif ls -d /home/${testUser} 2>/dev/null; then
	echo -e "The user ${testUser} does not exists on this system"
	echo "However, ${testUser} has a directory"
else
	echo -e "The user ${testUser} does not exists on this system"
	echo -e "And, ${testUser} does not have a directory"
fi



