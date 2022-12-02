#!/bin/bash

# 데이터 추가하기

MYSQL=$(which mysql)
DB="test"
TBL="testTBL"

if [[ ${#} -ne 4 ]]
then
	echo -e "Usage: ${0} empid lastname firstname salary\n"
else
	statement="INSERT INTO ${DB}.${TBL}(empid,lastname,firstname,salary) VALUES (${1},'${2}','${3}','${4}');"
	
	# 쿼리 보내기
	${MYSQL} -u test << EOF
	${statement}
EOF
	
	if [[ ${?} -eq 0 ]]
	then
		echo "Data Successfully added"
	else
		echo "Problem adding data"
	fi
fi
