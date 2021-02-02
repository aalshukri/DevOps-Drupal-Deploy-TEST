#!/bin/bash
# 
# deploy.sh
#
#
# Running instructions
# > ./deploy.sh
#
#

# Function init()
#  loads config file with specifc env variables
#  env='local', 'test', 'stage', 'prod'
func_init(){    
    configFile='config'
    if [ -f "$configFile" ]; then
        source $configFile;
        echo $ENV

        #Load settings
        env=$ENV;
        gitrepo=$GIT_REPO;
        #gitrepo="git@github.com:aalshukri/DevOps-Drupal-Deploy-TEST.git"

        #dir_git="/home/root/gitrepo/DevOps-Drupal-Deploy-TEST/"
        dir_git=$DIR_GIT
        dir_build=$DIR_BUILD
        dir_live=$DIR_LIVE

    else
        echo "Config file not found [$configFile]" >&2
        echo "Exiting!!!" >&2
        exit 1
    fi
}
func_init;


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
    echo "env    : "$env
    echo "whoami : "$(whoami)
    echo "pwd    : "$(pwd)
    echo "uptime : "$(uptime -p)
    echo "Settings"
    echo "gitrepo: "$gitrepo  
    echo "git    : "$dir_git  
    echo "build  : "$dir_build
    echo "live   : "$dir_live
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

# Function enable/disable maintenance mode
func_maintenanceMode(){
    if [ "$1" = true ] ; then
        echo "enable maintenance mode";
    elif [ "$1" = false ] ; then
        echo "disable maintenance mode";
    else    
        echo "maintenance mode option not recognised";
    fi
}

# Function back up live
#  used for roll back in the event of failure
func_backupLive(){
    echo "do nothing";
}

# Function seed data
#  populate database with seed data.
func_dataSeed(){
    echo "do nothing";
}

# Function restore data
#  
func_dataRestore(){
    echo "do nothing";    
}

# Function update Live
#  copy code from build dir to live
func_updateLive(){
    source=$dir_git"www/"
    destination=$dir_live

    echo "source : "$source
    echo "dest   : "$destination

    rsync -rv --progress --stats \
        $source $destination

        #--exclude=dir_git".git" \
        #--exclude=dir_git".github" \
        #--exclude=dir_git"deploy" \        
        #--exclude=dir_git"docker" \
        #$source $destination

    func_checkCmdStatus "rsync"
}

# Function goLive()
#  copy code to live directory
func_goLive(){
    echo "-GoLive"

    if [ $env = "local" ]; then
        echo "-local"
        func_maintenanceMode true;        
        func_updateLive;
        func_dataSeed;        
        func_maintenanceMode false;          
    elif [ $env = "test" ]; then
        echo "-test"
        func_maintenanceMode true;
        func_dataSeed;
        func_updateLive;
        func_maintenanceMode false;         
    elif [ $env = "stage" ]; then
        echo "-stage"  
        func_maintenanceMode true;
        func_dataRestore;
        func_updateLive;
        func_maintenanceMode false;         
    elif [ $env = "prod" ]; then
        echo "-prod"
        func_maintenanceMode true;
        func_backupLive;
        func_updateLive;
        func_maintenanceMode false;         
    else
        echo "Failure: ENV not set" >&2
        echo "Exiting!!!" >&2
        exit 1
    fi

    echo "-Done"
}


#
# Main
func_startup;
func_updateCode;
func_build;
func_goLive;
func_end;