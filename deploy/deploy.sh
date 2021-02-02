#!/bin/bash
# 
# deploy.sh
#
#
# Running instructions
# > ./deploy.sh
#
#

# Settings
gitrepo="git@github.com:aalshukri/DevOps-Drupal-Deploy-TEST.git"

dir_git="/home/root/gitrepo/DevOps-Drupal-Deploy-TEST/"
dir_build=$dir_git"www/drupalwebapp/"
dir_live="/var/www/html/TMP/"

# Function checkCmdStatus()
#  check the status of previously executed command
#    [ $? -eq 0 ] && echo "Command was successful" || echo "FAILED!!!"
func_checkCmdStatus(){
    if [ $? -eq 0 ]
    then
        echo "--OK $1"
    else
        echo "Failure: command failed $1" >&2
        echo "Exiting!!!" >&2
        exit 1
    fi    
}


# Function startup()
#  outputs basic system level settings
func_startup(){
    start=`date +%s`
    echo "start  : "$(date)
    echo "whoami : "$(whoami)
    echo "pwd    : "$(pwd)
    echo "uptime : "$(uptime -p)
}

# Function end()
#  Outputs script execution time
func_end(){
    end=`date +%s`
    runtime=$((end-start))
    hours=$((runtime / 3600)); 
    minutes=$(( (runtime % 3600) / 60 )); 
    seconds=$(( (runtime % 3600) % 60 )); 
    echo "Runtime: $hours:$minutes:$seconds (hh:mm:ss)"
}

# Function updateCode()
#  gets latest version of code from github
func_updateCode(){
    echo "-UpdateCode"
    echo "  repo = "$gitrepo
    echo "  dir  = "$dir_git
    cd $dir_git
    git pull
    func_checkCmdStatus "git pull"
    echo "-Done"
}

# Function build()
#  executes application build process.
func_build(){
    echo "-Build"
    cd $dir_build
    composer install
    func_checkCmdStatus "composer install"
    echo "-Done"    
}

# Function goLive()
#  copy code to live directory
func_goLive(){
    echo "-GoLive"
    #mantainence mode enabled
    
    source=$dir_git
    destination=$dir_live
    rsync -rv --progress --stats \
        --exclude=dir_git".git" \
        --exclude=dir_git".github" \
        --exclude=dir_git"deploy" \        
        --exclude=dir_git"docker" \
        $source $destination

    func_checkCmdStatus "rsync"
    #mantainence mode disabled        
    echo "-Done"
}


#
# Main
func_startup;
func_updateCode;
func_build;
func_goLive;
func_end;