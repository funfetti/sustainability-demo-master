#!/usr/bin/env bash

# run chmod u+x orgInit.sh
# to actually execute: bash orgInit.sh
#
# get alias from user 
echo "this is a 1.11 sustainability scratch. name your org:"
read sname

echo "your org alias is $sname"
echo creating your scratch org... 
sfdx force:org:create -f config/project-scratch-def.json -s -a $sname

# install 1.12.0
sfdx force:package:install -p 04t3k000000iy8qAAA -w 20 

# PSL/Perms 
# using shane's plugins https://github.com/mshanemc/shane-sfdx-plugins

sfdx shane:user:psl -l User -g User -n sustain_app_SustainabilityCloudPsl
sfdx shane:user:psl -l User -g User -n InsightsInboxAdminAnalyticsPsl

sfdx force:user:permset:assign -n SustainabilityAnalytics
sfdx force:user:permset:assign -n SustainabilityAppAuditor
sfdx force:user:permset:assign -n SustainabilityAppManager
sfdx force:user:permset:assign -n SustainabilityCloud

sfdx shane:user:permset:assign -l User -g Integration -n SustainabilityAnalytics

#load data 
sfdx automig:load -d demo-data/ --concise --mappingobjects RecordType:DeveloperName,sustain_app__EmissionFactorElectricity__c:Name,sustain_app__EmissionFactorOther__c:Name,sustain_app__EmissionFactorScope3__c:Name

#create EA apps
#sfdx analytics:app:create --templatename Sustainability
#sfdx analytics:app:create --templatename Sustainability_Audit -a
#sfdx analytics:app:create -f assets/Sustainability-EA.json
#sfdx analytics:app:create -f assets/SustainabilityAudit-EA.json 

# alrighty lets push source - i have to wait bc of the analytics embedded dash on the home page
#sfdx force:source:push

# open sesame
sfdx force:org:open 