## Time log
Below is an overview of the timelog. I had a difficult time planning because I wasn't sure what to expect and what sort f problems I would encounter. I made some requirements I wanted to work to, so I could maintain some flexibility in the planning.  
What I did expect in the start was that the key-vault and data-recovery would give me problems. These are things that aren't working at the moment. I see that I pu too much time in this so other services aren't working either. I believe the post deployment-storage and database could have worked if I had put more effort in these then in the key-vault. The reasoing behind this is that I wanted a secure environment.
I also had a good start and was very early deploying my services.


## WEEK 1

Monday 05-06-2023
- Demands & Assumptions list
- Bicep intro

Tuesday - 06-06-2023
- Bicep
- Overview diagram
- Explorations (see "user stories")

Wednesday - 07-06-2023
- Started with Management VNet in Bicep (only security needs to be done)

Thursday - 08-06-2023
- Brainstorming about deployment scripts.
- State of network today. There are some security issues here, and it is incomplete but it's a work in progress.
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/000_Project/000-project%20-%20network.png)

Friday - 09-06-2023
-Learning module

### END OF WEEK 1 REVIEW:
I have the basics thought out, and have created 2 v-nets, one for webappservices and one for management services. They are two different files at the moment, but the idea is to create one bicep code for the complete project. This will avoid issues about connecting different modules.
There are however two issues that needs to be solver before the end of next week:
- I have a child-parent connection that causes error in de appservice
- The appservice needs to be placed within the its own v-net.  

When I can manage this I have a code of the backbone of the project that is good to show after two weeks  

I also need to make an overview of the expected cost.  

I use the next two weeks to create the following:
- post-deployment storage and deployment
- app server backup
- security / firewalls / access control
- secret key-vault
- azure active directory
- tags
- encryption
I have estimated two days per subject to tackle the above issues.  

## WEEK 2
Monday 12-06-2023
- Merged the managemet server with web server

Tuesday 13-06-2023
- Decided to use VMs for the webapp. Akram said it would be easier so let's find out. Have now two Vnet both with a subnet and a VM. Made a start for a storage account. This will be in the management Network in its own sub net.

Wednesday 14-06-2023
- Need more attention to what file to deploy. Spent too much time deploying the wrong file to the portal and wondering why the errors keep coming! Lesson learnt. Have now to VM's within Vnet and subnet. Also created a storage account. Made a fileshare, but I think blob storage is easier to handle a variety of filetypes. I created some order in the params and vars in the bicep code. It was a mess. I placed my subnets out of my Vnets (they were nested there), but now I can't deploy my script a second time without errors. Says it can't remove a subnet. 

Thursday 15-06-2023  
- Vnets and subnets are working now. VM's are inside the subnets and I can deploy my scripts multiple times. I made a start with a keyvault. I als need Azure AD for this. I guess I have to use modules to make this work with one command for the bicep. I am going to find this out next week.

Friday 16-06-2023  
- Study day. I studied the Microsoft learning modules about Bicep. Not too much to worry about. Naming services logical and clearly reamains challenging.

### END OF WEEK 2 REVIEW  

Schematic of the project as of the end of week 2.  

![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/000_Project/000-project(3).png)  

The project gets more shape. Lot of the tings are deployed. They only need to connect to each other. It deplys without error, so that's good. In the final week I need to split it up in modules. I need this for the resourcegroup creation and for the Azure AD to make the key-vault work. I will do this in the final week. 
Next week I want to to fix:  
- Azure Bastion to connect managementserver with appserver with SSH and RDP
- peerings  
- security
- backup
- webserver deployment
- key vault with azure ad  

## WEEK 3  
Monday 19-06-2023  
- Created MY Nsg's and peering for the Vnets. It's all working now. However I am not sure how to check the state of my portconfiguration for the webserver. I wanted to deploy an apache server on the Appserver-vm. But I am not sure how to make tis work.

Tuesday 20-06-2023  
- Got my Apache script in the portal but not deployed. I stop with it for now. Return to it later. I make a start with backup. It is deployed but not connected. I think lot of the info on Microsofts website is very cryptic.

Wednesday 21-06-2023  
- Splitting it up in modules. I want to create a resourcegroup when deployng so ni choice. I use the VSC bicep visualizer as starting point. This is lot of work to get it working.

Thursday 22-06-2023  
- Modules start to work nicely. Organised the labeling of params etc. This takes some experience to get right. Made key-vault and stored passwords. Are they coming back? I think they are stored somewhere in memory and in the key-vault.

Friday 23-06-2023  
- Studied keyvault. When removing key-vault it doesn't remove. You need to purge it and need permissions to do so.

### END OF WEEK 3 REVIEW  
Basicaly eveything van be deployed. But not eveything is connected. It's gonna be busy next week cause a lot has to be done.
Here's a list:  
- Key-vault with managed identity
- Encryption (need key-vault)
- database connection to webserver (private endpoint) and to management server.
- backup, I have this started but not working
- blob-storage needs connection to management server.

## WEEK 4  
Monday 26-06-2023  
- Working with the key-vault. Nothing seems to work. All day the error no access. Everybody working on it in the team is having troubles here. This day was not very productive.

Tuesday 27-06-2023  
- Finally is my Apache working. Busy with the database. Got something working. I need an endpoint to my webserver. I am not sure if this is gonna work. I realise that this project is not completely finished this Friday.

Wednesday 28-06-2023  
- I managed to log into my managment Windows server and could connect to my Linux VM via SSH. Need powershell not powershellx86, that's pretty nice. Cleaning up my code a bit for delivery. Everything goes slow this week. All the easy stuff is done I guess.

Thursday 29-06-2023  
- Last day for delivery. Dive into keyvault and encryption today. The keyencryption will not access the vault. Took me the whole day to not make this work.

Friday 30-06-2023  
- Day for documentation.


### END OF WEEK 4 REVIEW  
I know the easy things have been deployed. Everything takes more time then before. Need to change my mindset. Things that need to be done:
- Database  
- Postdeployment scripts (there is a storage account with blob drive but not functioning as desired)  
- Recovery vault  
- Improve Key vault  
- Redeployment
- (Version 1.1)  

## WEEK 5  
Monday 03-07-2023  
Made an overview of version 1.1. Things to change:
- Webserver needs to be a proxy server. Can make an application gateway for this?
- HTTPS connection with TLS 1.2 or up, make certificate for the website. Also when accessing via HTTP.  
- Health checks with automatic restore.
- Scaleset for 1-3 instances.
Started with scaleset and application gateway. Hope this will work at the end of the week.

Tuesday 04-07-2023  
- Continued with scaleset and VMSS. I can replace my complete 'webserver' module. Also try to make an application gateway run with two VM's. This works.

Wednesday 05-07-2023  
- Short day because of appointment with possible employer. Tried to make VMSS work.

Thursday 06-07-2023  
- Made VMSS work with application gateway. Security rules needs adjustments but will fix this when making the HTTPS connection.

Friday 07-07-2023  
- Got my diskencryption working on VMSS and management server.  

### END OF WEEK 5 REVIEW  
Got VMSS with application gateway working with diskencryption. Things that need to be done for MVP:
- Database
- Postdeployment scripts (there is a storage account with blob drive but not functioning as desired)
- Recovery vault
- Redeployment
- HTTPS & TLS on webserver (can you make a certificate with a keyvault?)
- Health checks with auto restore for webserver


## WEEK 6  
Monday 10-07-2023  
- Got failure with deployment 'Bad parameter request'-error. Can't find out why.

Tuesday 11-07-2023  
- Found the error. Had access policy set to 'all' and was not allowed. Took me a day.  

Wednesday 12-07-2023  
- Continuing database.

Thursday 13-07-2023  
- Continue with database. Need private endpoints for this.

Friday 14-07-2023  
- Improvement day. Renamed some resources and modules for clarity. Made some minor adjustments.

### END OF WEEK 6 REVIEW  
Not much time left and quite some stuf to do. This is what I still need to do next week:
- database connection check
- making blob storage connection to management server for postdeployment scripts
- health checks in the App Gateway
- recovery vault
- certificiate/TLS1.2 for the web server
Recovery vault and certificate have priority.

Deployment 16-07-2023:
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/000_Project/000_Version1.1/docs/x-deployment1.1a.png)

