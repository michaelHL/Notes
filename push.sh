#!/usr/bin/sh

cd "$(dirname "$0")"
echo -e "\033[32;49;1m>>>>>>> PUSHING <<<<<<< \033[39;49;0m"
git add -A
git commit -m 'update'
git push origin master
echo -e "\033[32;49;1m>>>>>>>   DONE  <<<<<<< \033[39;49;0m"
