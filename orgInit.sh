#!/usr/bin/env bash

# run chmod u+x orgInit.sh
# to actually execute: bash orgInit.sh
#
# get alias from user 
echo "this is a 1.14 sustainability scratch. name your org:"
read sname

echo "your org alias is $sname"
echo creating your scratch org... 
sfdx force:org:create -f config/project-scratch-def.json -s -a $sname

# PSL/Perms 
# using shane's plugins https://github.com/mshanemc/shane-sfdx-plugins
# i am pretty sure the xDOs we'll need to assign the PSL to the running user first...
# sfdx shane:user:psl -l User -g User -n sustain_app_SustainabilityCloudPsl
# sfdx shane:user:psl -l User -g User -n InsightsInboxAdminAnalyticsPsl

# install 1.14.0
# echo "installing sustainability cloud"
sfdx force:package:install -p 04t3k0000027CZ1AAM -w 20 

sfdx force:user:permset:assign -n SustainabilityCloud
sfdx force:user:permset:assign -n SustainabilityAppManager
sfdx force:user:permset:assign -n SustainabilityAnalytics
sfdx force:user:permset:assign -n EventMonitoringWaveAdmin 

sfdx shane:user:permset:assign -l User -g Integration -n SustainabilityAnalytics

#load data 
# echo "loading data... this could take a minute"
# sfdx sfdmu:run --sourceusername csvfile --targetusername $sname -p automagic/demo-data --verbose

#create tableau crm apps
sfdx analytics:app:create -t sustain_app__Sustainability -n ClimateAction
sfdx analytics:app:create -t sustain_app__Sustainability_Audit -n SustainabilityAudit

# alrighty lets push source - i have to wait bc of the analytics embedded dash on the home page
sfdx force:source:push

# open sesame
# sfdx force:org:open 

## for sandboxes 
## sfdx force:org:deploy -u tfdevbox -p force-app
## sfdx force:org:deploy -u tfdevbox -p base-demo