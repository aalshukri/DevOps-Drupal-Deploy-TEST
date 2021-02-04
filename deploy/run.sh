#!/bin/bash
# 
# run.sh
# @version 0.1
# @author Ayesh Alshukri
#
# This script executes the deployment insturctions
# within the deploy.sh script for the environment 
# (env) set in your config file.
#
# Running instructions
# > ./run.sh
#

source ./deploy.sh
func_init;
func_updateCode;

func_startup;
func_updateCode;
func_build;
func_goLive;
func_end;