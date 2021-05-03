# folder of automagic
this is mostly so I don't forget how to do all of this in a few months lol

 
## mdapi - page layouts
To grab the ootb page layouts I need to

1. make sure the latest version of Sustainability Cloud is installed

3. build the package manifest to grab all the relevant layouts, record types, and the Admin profile (I used [viganesh/sfdx-package-generator](https://github.com/vignaesh01/sfdx-package-generator)) and store in **sustain-package.xml**

4. unfortunately it doesn’t quite put the namespace in correctly into the xml file so i had to fix all the page layout names. it’ll pull `namepace__Object__c-fieldname.layout.meta.xml` but it should be `namespace__Object__c-**namespace__**fieldname.layout.meta.xml`

5. retrieve the files from the scratch
`sfdx force:mdapi:retrieve -r mdapi -k sustain-package.xml`

6. convert mdapi to source
`sfdx force:mdapi:convert -r mdapi/unpackaged/layouts -d force-app`

7. Clean up **Admin-profile-meta.xml** (keep only the layoutAssignments) and make a copy here so when I pull source I don't have to redo all of this again

8. Push to scratch

currently Admin-profile-meta.xml is up to date for 1.14
  
## sfdmu - demo data chaos

Using the [SFDX Data Move Utility](https://github.com/forcedotcom/SFDX-Data-Move-Utility) and the [SFDMU Desktop App](https://github.com/forcedotcom/SFDX-Data-Move-Utility-Desktop-App). HIGHLY recommend!! It even does circular references. 

Cribbed from the [help docs](https://help.sfdmu.com/quick-start):

1.  Create  **export.json**  file

2.  Make sure that you already have connected to the source and target salesforce Orgs using SFDX 
    
3.  Open the directory where you have put your  **export.json**  in the terminal and enter 
`sfdx sfdmu:run --sourceusername SOURCEORGALIASORUSERNAME --targetusername TARGETORGALIASORUSERNAME`


---
*reminder to self - you stored the data locally in **Documents/SFDMU_APP** and the electron app in **Users/###/SFDX-Data-Move-Utility-Desktop-App** like a dummy, `npm start` to boot it*