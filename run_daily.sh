#!/bin/bash

source ~/.bash_profile
source ~/miniconda3/bin/activate base || echo "Activate base failed, trying the scripts"

cd ~/git/covid-19-forecaster

echo $GOOGLE_APPLICATION_CREDENTIALS_PATH

runipy 4.create_UK_response.ipynb
runipy 5.create_US_response.ipynb
runipy 6.create_joint_response.ipynb
