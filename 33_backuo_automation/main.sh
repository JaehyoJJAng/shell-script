#!/bin/bash

# Daily Archive - Archive designated files & directories
################################################
#

# Gather current Date
date=$(date +"%Y%m%d")

# Set Archive File Name
FILE=archive${date}.tar.gz

# Set Configuration and Destination File
CONFIG_FILE='./Files_To_Backup'
DESTINATION='./backup_gz'

############## Main Script ##############

# Check Backup Config File exists
if [[ -f ${CONFIG_FILE} ]]
then
	echo
else
	echo -e "\n ${CONFIG_FILE} does not exists!\n"
	exit 1
fi

# Check DESTINATION DIRECTORY
if [[ ! -d ${DESTINATION} ]]
then
	echo -e "\n ${DESTINATION} does not exists"
	mkdir -p ${DESTINATION}
fi


TARGETS=$(cat ${CONFIG_FILE})

for TARGET in ${TARGETS[@]}
do
	if [[ -d ${TARGET} ]]
	then
		for item in $(ls -lh ${TARGET} | awk '{print $9}')
		do
			if [[ ! -e ${TARGET}/${item} ]]
			then
				echo "${TARGET}/${item} does not exist!"
				exit 1
			fi
		done

		# Backup
		echo -e "${TARGET} Start Archiving .."
		TMP='./tmp'

		if [[ ! -d ${TMP} ]]
		then
			mkdir ${TMP}
		fi

		tar -czpPf "${TARGET}.tar.gz" "${TARGET}" && mv "${TARGET}.tar.gz" ${TMP}
	fi
done


# Set zip Files
echo -e "\nSetting tar Files"
tar -czpPf "${DESTINATION}/${FILE}" ${TMP}/* || exit 1
echo -e "Done\n"

# Removing TMP
echo -e "\nRemoving TMP DIR"
rm -rf './tmp'


