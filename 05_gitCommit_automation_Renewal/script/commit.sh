#!/bin/bash
git=$(which git)
if [[ $(git status --porcelain) ]]
then
	${git} config user.name "JaehyoJJAng"
	${git} config user.email "yshrim12@naver.com"
	${git} add -A
	${git} commit -m "Update README"
	${git} push -u origin main
fi