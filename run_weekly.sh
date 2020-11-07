#!/bin/bash

source ~/.bash_profile
source ~/miniconda3/bin/activate base || echo "Activate base failed, trying the scripts"

cd ~/git/covid-19-forecaster

echo $GOOGLE_APPLICATION_CREDENTIALS_PATH

runipy 0.get_country_data.ipynb
runipy 1.get_region_data.ipynb
runipy 2.train_weekly.ipynb
runipy 3.predict_weekly.ipynb
runipy 4.create_UK_response.ipynb
runipy 5.create_US_response.ipynb
runipy 6.create_joint_response.ipynb
