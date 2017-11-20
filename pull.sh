#!/usr/bin/sh

cd "$(dirname "$0")"
echo -e "\033[31;49;1m>>>>>>> PULLING <<<<<<< \033[39;49;0m"
git fetch --all
git reset --hard origin/master
git pull
echo -e "\033[31;49;1m>>>>>>>   DONE  <<<<<<< \033[39;49;0m"
