#!/bin/sh

# Colors
YEL='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Usage
REPO_OPT="<repository>"
WDIR_OPT="<workdir>=."
USER_OPT="<user>"

usage() {
    echo "Usage: $0 $USER_OPT $REPO_OPT [$WDIR_OPT]"
}

USER=$1
REPO=$2
WORKDIR=$3

# If repository name is not specified, show usage
if [[ $REPO == "" ]]; then
    echo "${YEL}SCRIPT: ${RED}Repositoty missed.${NC}"
    usage;
    exit 1;
fi

# if work directory is specified, change directory
if [[ ! $WORKDIR == "" ]]; then
    echo "${YEL}SCRIPT: ${NC}change directory to $WORKDIR..."
    cd $WORKDIR;
fi

# Create directory for the repository
if [[ -d $REPO ]]; then
    echo "${YEL}SCRIPT: ${NC}directory for the repository exists.;"
else
    echo "${YEL}SCRIPT: ${NC}creating a directory for the repository...";
    mkdir $REPO;
fi

cd $REPO

echo "${YEL}SCRIPT: ${NC}Initicializing the repository..." && \
git init \
&& echo "${YEL}SCRIPT: ${NC}add new remote repository '$REPO'" && \
git remote add origin "https://github.com/$USER/$REPO" \
&& echo "${YEL}SCRIPT: ${NC}set url for the remote repository..." && \
git remote set-url origin "git@github.com:$USER/$REPO" \
&& echo "${YEL}SCRIPT: ${NC}pull data" && \
git pull origin main \
&& echo "${YEL}SCRIPT: ${NC}push updates" && \
git push --set-upstream origin main \
&& echo "${YEL}SCRIPT: ${NC}The new repository sucessfully created."

