#!/bin/bash

# Redirecting SQL output to a variable

MYSQL=$(which mysql)

dbs=$(${MYSQL} -u test -Bse 'SHOW DATABASES')

for db in ${dbs}
do
	echo ${db}
done
