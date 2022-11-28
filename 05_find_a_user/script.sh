#### Find a user ####

users=($(cat /etc/passwd | awk -F':' '{print $1}'))

for user in ${users[@]};
do
	echo ${user}
done
