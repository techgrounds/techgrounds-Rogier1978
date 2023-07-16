# PLANNING

Week 1 - 
  - [x] Study BICEPS & IAC, ENCRYPTION, BOOTSTRAP-SCRIPTS.
  - [x] Demands / Assumptions
  - [x] Overview of services
  - [ ] Basic script ready with all modules
  - [x] Deployment scripts documentation  
        https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-script-template 

Week 2 - 
  - [x] IP-address planning (10.10.10.0/24 and 10.20.20.0/24)
  - [x] Create basics of the project in bicep, webserver / managementserver.

Week 3 - 
 - [x] - Splitting up in modules. Need to deploy a resourcegroup.
 - [x] - Apache script for website
 - [x] - keyvault
 - [x] - disk encryption

Week 4 -
 - [x] = keyvault with encryption
 - [ ] - recovery vault back-up
 - [ ] - blob storage for post deployment script

Week 5 - 
 - [x] Get overview new requirements
 - [x] Create Scaleset and Application Gateway

Week 6 -  
 - [ ] Recovery vault back-up
 - [ ] certificate
 - [ ] ....

# DEMANDS
  - [x] Every VM disk is encrypted
  - [ ] All data traffic is encrypted
  - [ ] Daily backups (stored for 7 days)
  - [x Each subnet include firewall (security group)
  - [x] Webserver installed automatically with public ip.
  - [x] Admin/Management server from trusted locations (Conditional Access, Azure AD Premium P2)
  - [x] Webserver connection via SSH/RDP only via Admin server
  - [ ] Storage location for BOOTSTRAP-SCRIPTS, accessible via Admin/Management server.
  - [x] Webserver is scalable (Q&A 6-6-2023 version 1.1)
  
# ASSUMPTIONS
  - [x] DDOS protection for Web server. Not needed, the product owner is developing own security.
  - [x] One billing
  - [ ] Use cheapest available options possible, according to demands (it's learning project)
  - [x] No private network available
  - [x] Azure AD 
  - [ ] MFA for Admin/Management

# USER STORIES  
## Virtual Networks
  - [x] I want to use two Vnets. One for the web-server, one for the management-server.
  - [x] All the V-Nets will have subnets equiped with a NSG to control network traffic.
  - [x] There is peering link between management server and web server via SSH.

## Web-server  
  - [x] The installation needs to be done automated.
        https://learn.microsoft.com/en-us/training/modules/automate-virtual-machine-software-installation-configuration/
  - [x] Webserver is for low density traffic with some times peakmoments. I use VM's for this, because they scale better. They are, however, a bit more costly and require some maintenance.  
        https://dzone.com/articles/microsoft-azure-app-service-cloud-services-or-vms  
  - [x] The VM's needs encryption. We can do this via the disk settings. The key for the encryption will be stored in the Key-Vault.
  - [x] Azure SQL database will be added to store data.
        https://www.sqlshack.com/azure-sql-database-vs-sql-server-on-azure-virtual-machines/  
  - [ ] The server need a daily backup, what is stored for 7 days. We implement this with Azure Backup. This also needs a "Recovery Services Vault" to store the backup. No one needs access to this vault for security reasons.

## Management-server  
  - [x] https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/azure-server-management/
  - [x] public ip address (At the moment mine public IP adres)
  - [x] The VM's needs encryption. We can do this via the disk settings. The key for the encryption will be stored in the Key-Vault.
  - [x] Conditional Access (use Azure AD). You can only access this via one ip address.
        https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/plan-conditional-access
  - [x] Security (NSG)  
  - [x] Via managemnet-server we need to cennect to web-servers,
  - [ ] post-deploymentscripts.
    
## PostDeployment Scripts
  - [x] This will be a blobstorage. 
  - [ ] Needs a connection from the management server for posting updated script, and to the webvm to deploy these scripts.

## Azure AD
  - [ ] Make overview of user roles (week 3). This will not be used. Using access policies in key vault.

## Key Vault
  - [x] To store all the secret info. (encryption, passwords etc.)
  - [ ] Possibility for repeployment

## Security
  - [x] Firewall on each subnet (security group)
  - [x] Conditional access to management server (via single IP address)
  - [x] Public webaccess only via port 80 aand 443
  - [x] Encryption of all harddrives  
  - [ ] Traffic encrypted
  - [x] key-vault to store sensitive dat

## Version 1.1
 - [x] Scaleset with application gateway
 - [ ] Certificate TLS 1.2
 - [ ] Health check

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


