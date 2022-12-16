#!/bin/bash 

###################
# IFS Setting
IFS_BACK=${IFS}
IFS=$'\n'

####################
# Get Login Info
info=($(cat ./.login.info | awk -F':' '{print $2}'))
mysql_id=${info[0]}
IFS=${IFS_BACK}
#

#####################
# MySQL Command
MYSQL=$(which mysql)
#

#####################
#
count="$(${MYSQL} --login-path=${mysql_id} < ./count.sql | awk  '{print $1}' | grep -v [^0-9])"

####################
# testTBL 카운트가 1000건 넘었는지 확인
if [[ ${count} -ge 1 ]]
then
	echo -e "test.testTBL 테이블의 데이터가 ${count}건이 넘었습니다"
	
	TEXT="데이터가${count}건이넘었습니다"

	# 텔레그램으로 메시지 보내기
	./telegram.sh "${TEXT}"
fi
