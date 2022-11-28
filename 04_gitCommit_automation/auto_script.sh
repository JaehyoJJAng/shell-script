#!/bin/bash

IFS_BACKUP=${IFS}
IFS=$'\n'

function create_md() {

response=$(curl --location -g --request GET 'https://www.waytothem.com/blog') || exit 1
titles=($(echo ${response} | grep -Po '<strong class="title_post">.*?</strong>'))
dates=($(echo ${response}  | grep -Po '<p class="date">.*?</p>'))

echo -e "<!-- Blog-Post -->\n" > README.md

for idx in "${!titles[@]}";
do
        title=${titles[${idx}]}
        date=${dates[${idx}]}

        echo -e "${title}\n${date}\n" >> README.md
done
echo "<!-- Blog-Post -->" >> README.md
}


echo '#### creating README.md ####'
create_md
echo '#### complete README.md ####'

echo '##### auto push start #####'
baseDir=/home/wogy12395/git/shell-script/
cd ${baseDir}


git pull origin auto
echo "> pull Complete"

fileName=$(git status -u -s | head -n 1)
fileName=$(echo ${fileName} | awk '{print $2}')

if [[ -z "${fileName}" ]]; then
	echo "##### File Not Found #####"
	exit 1
fi

commitMsg=$(cat ${fileName} | head -n 1)


git add ./
git status
git commit -m "${commitMsg}"
git push -u origin main

echo "##### auto push end #####
