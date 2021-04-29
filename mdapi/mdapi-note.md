
(this is mostly so I don't forget how to do this in a few months)

To grab the ootb page layouts I need to 

1. make sure the latest version of Sustainability Cloud is installed
2. build the package manifest to grab all the relevant layouts, record types, and the Admin profile (I used [viganesh/sfdx-package-generator](https://github.com/vignaesh01/sfdx-package-generator)) and store in [*sustain-package.xml*](./sustain-package.xml)
3. retrieve the files from the scratch
	`sfdx force:mdapi:retrieve -r mdapi -k sustain-package.xml`
4. convert mdapi to source 
    `sfdx force:mdapi:convert -r mdapi/unpackaged/layouts -d force-app` 
5. Clean up [*Admin-profile-meta.xml*](./Admin-profile-meta.xml) (keep only the layoutAssignments) and make a copy here so when I pull source I don't have to redo all of this again
6. Push to scratch 

currently Admin-profile-meta.xml is up to date for 1.14

mdapi/sustain-package.xml