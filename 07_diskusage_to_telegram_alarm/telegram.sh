#!/bin/bash

if [[ ${#} -ne 3 ]]; then
	echo -e "\nUSAGE ==> ${0} <HOSTNAME> <IP ADDRESS> <MESSAGE>\n"
	echo -e "==> ${0} user-01 192.168.100.1 /var 100%"
	exit 1
fi

# TELEGRAM TOKEN
TOKEN=''

# TELEGRAM CHAT ID
CHATID=''

# Request URL
URL="https://api.telegram.org/bot${TOKEN}/sendMessage"

function alarm() {
	# ===  Telegram 봇 관련 정보 ===
	# 날짜
	DATE=$(date +"%Y.%m.%d %H:%M")

	# 보낼 메시지 작성
	TEXT="${1}(${2}) - ${3}"

	# 메시지 보내기
	curl -s -d "chat_id=${CHATID}&text=${TEXT}" ${URL} > /dev/null

	echo "Done"
}

alarm ${1} ${2} ${3}
