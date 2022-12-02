#!/bin/bash

# Big_Users - Find Big disk space users in various directories

# Parameters for Script
#
# Directories to check
CHECK_DIRECTORIES=" /var/log /home" 
#
################ MAIN SCRIPT ######################
#
# Date for report file
DATE=$(date +"%Y%m%d")

# Make report file STDOUT
exec > disk_space_${DATE}.rpt

# Report Header
echo "============ Top Ten Disk Space Usage ==============" 
echo "for ${CHECK_DIRECTORIES} Directories"
echo "============                          =============="

for DIR_CHECK in ${CHECK_DIRECTORIES};
do
	echo ""
	echo "The ${DIR_CHECK} Directory:"

	# Create a Listing of top ten disk space users in this dir
	du -S ${DIR_CHECK} 2>/dev/null |
		sort -rn |
		sed '{11,$D; =}' |
		sed 'N; s/\n/ /' |
		gawk '{printf $1 ":" "\t" $2 "\t" $3 "\n"}'
	exit
done
