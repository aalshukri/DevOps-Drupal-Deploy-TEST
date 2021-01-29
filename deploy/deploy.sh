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

dir_git="/home/root/gitrepo/DevOps-Drupal-Deploy-TEST"
dir_build=""
dir_live="/var/www/html"


# Function startup()
#  Outputs basic system level settings
func_startup(){
    start=`date +%s`
    echo "start  : "$(date)
    echo "whoami : "$(whoami)
    echo "pwd    : "$(pwd)
    echo "uptime : "$(uptime -p)
}

# Function end()
#  outputs script execution time
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
    echo "-Done"
}

# Function build()
#  executes application build process.
func_build(){
    echo "-Build"
    echo "-Done"    
}

# Function goLive()
#  copy code to live directory
func_goLive(){
    echo "-GoLive"
    #mantainence mode enabled
    
    source="/home/octru/triage/TRIAGE/code/www/triage" 
    destination="/var/www/html/"
    sudo rsync -rv --progress --stats \
        --exclude="/home/octru/triage/TRIAGE/code/www/triage/tests/" \
        $source $destination      

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