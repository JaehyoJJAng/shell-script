#!/bin/bash

# Parameter Check
if [[ ${#} -ne 1 ]]
then
	echo -e "${0} <Message>\n"
	exit 1
fi

# TOKEN & CHATID Load In File
INFOS=($(cat ./.telegram.info | awk -F'=' '{print $2}'))

# TELEGRAM Token
token=${INFOS[0]}

# Telegram Chat ID
chatId=${INFOS[1]}

# Request URL
URL="https://api.telegram.org/bot${token}/sendMessage"

function alarm() {
	# ===  Telegram 봇 관련 정보 ===
	# 날짜
	DATE=$(date +"%Y.%m.%d %H:%M")

	# 보낼 메시지 작성
	TEXT="${DATE} - ${1}"

	# 메시지 보내기
	curl -s -d "chat_id=${chatId}&text=${TEXT}" ${URL} > /dev/null

	echo "Done"
}

alarm ${1}
