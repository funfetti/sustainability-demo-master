sfdx force:org:create -f config/project-scratch-def.json -s 

# install 1.10
sfdx force:package:install -p 04t3k000001yv66AAA -w 20 

# PSL/Perms 
# using shane's plugins https://github.com/mshanemc/shane-sfdx-plugins

sfdx shane:user:psl -l User -g User -n sustain_app_SustainabilityCloudPsl
sfdx shane:user:psl -l User -g User -n InsightsInboxAdminAnalyticsPsl

sfdx force:user:permset:assign -n SustainabilityAnalytics
sfdx force:user:permset:assign -n SustainabilityAppAuditor
sfdx force:user:permset:assign -n SustainabilityAppManager
sfdx force:user:permset:assign -n SustainabilityCloud

sfdx shane:user:permset:assign -l User -g Integration -n SustainabilityAnalytics

# alrighty lets push source
# make sure wave folder is deleted!!! 
sfdx force:source:push 

#load data 
sfdx automig:load -d demo-data/ --concise --mappingobjects RecordType:DeveloperName 

#create EA apps
sfdx analytics:app:create -m Sustainability  
sfdx analytics:app:create -m Sustainability_Audit -a 