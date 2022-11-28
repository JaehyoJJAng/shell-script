#!/bin/bash

FILESYSTEMS=($(df -h | awk '{ print $1}' | grep -v [A-Z]))
USAGES=($(df -h | awk '{gsub(/%/,""); print $5}' | grep -v [A-Z]))
MOUNTS=($(df -h | awk '{print $6}' | grep -v [A-Z]))
for idx in ${!USAGES[@]};
do
	FILESYSTEM=${FILESYSTEMS[${idx}]}
	USAGE=${USAGES[${idx}]}
	MOUNT=${MOUNTS[${idx}]}

	if [[ ${USAGE} -gt 50 ]];then
		echo -e "${FILESYSTEM}\t${USAGE}\t${MOUNT}\n"
	fi

done
