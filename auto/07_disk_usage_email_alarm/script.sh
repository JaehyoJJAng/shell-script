#!/bin/bash

####################
# IFS Setting
IFS_BACK=${IFS}
# 

#####################
# sudo 
sudo=$(which sudo)
#

####################
# File Name
FILE="./df.log"
#

#####################
# To Email Address
TO_EMAIL="$(cat ./.address.mail | awk -F'=' '{print $2}')"
#

#####################
# Disk Free Checking
function df_checking() { 
	df_leng=$(df -h | awk '{print $1}' | grep -v "[A-Z]" | wc -l)
	usages=($(df -h | awk '{print $5}' | grep -v "[A-Z]" | awk -F'%' '{print $1}'))
	mounts=($(df -h | awk '{print $6}' | grep -v "[A-Z]" | awk -F'%' '{print $1}'))
	
	exec 3> ${1}
	for idx in $(eval seq 0 $[ ${df_leng} - 1 ])
	do
		usage=${usages[${idx}]}
		mount=${mounts[${idx}]}
		filesystem=${filesystems[${idx}]}

		echo -e "${usage}\t${mount}%" >&3   
	done 
}

# Send Email Function
function send() {
	# 디스크 체킹
	df_checking ${1}
	
	# IFS Setting Change
	IFS='\t'
	
	# MAIL MSG
	EMAIL_MSG=$(cat ${1})

	# Subject
	SUBJECT="Shell Script : Disk Free Monitoring"

	# To
	TO_EMAIL="yshrim12@naver.com"
	
	echo "${EMAIL_MSG}" | /usr/bin/mail -s "${SUBJECT}" "${TO_EMAIL}"
}

send ${FILE}
