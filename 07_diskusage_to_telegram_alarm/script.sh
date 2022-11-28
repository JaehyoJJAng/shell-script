#!/bin/bash

IFS_BAK=${IFS}

PWD=$(pwd)
HOST=${USER}
IP_ADDR=$(ip ad sh | grep "inet" | awk -F' ' '{print $2}' | sort | grep "/24")
TELE_FILE="${PWD}/telegram.sh"


USAGES=($(du -h / --max-depth=1 2>/dev/null | grep "G" | awk -F'G' '{print $1}' | awk -F'.' '{print $1}'))
U_PATH=($(du -h / --max-depth=1 2>/dev/null | grep "G" | awk -F'G' '{print $2}'))

for idx in ${!USAGES[@]};
do
	
	usage=${USAGES[${idx}]}
	path=${U_PATH[${idx}]}

	if [[ ${usage} -gt 3 ]]; then
		TEXT="${path}==>${usage}G"

		# 텔레그램 메시지 보내기
		${TELE_FILE} "${HOST}" "${IP_ADDR}" "${TEXT}"
	fi
done

