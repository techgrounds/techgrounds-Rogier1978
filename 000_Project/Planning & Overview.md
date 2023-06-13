# PLANNING

Week 1 - 
  - [ ] Study BICEPS & IAC, ENCRYPTION, BOOTSTRAP-SCRIPTS.
  - [ ] Demands / Assumptions
  - [ ] Overview of services with costs
  - [ ] Basic script ready with all modules
  - [ ] Deployment scripts documentation  
        https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-script-template 

Week 2 - 
  - [ ] IP-address planning (10.10.10.0/24 and 10.20.20.0/24)
  - [ ] Cost overview


# DEMANDS
  - [ ] Every VM disk is encrypted
  - [ ] All data traffic is encrypted
  - [ ] Daily backups (stored for 7 days)
  - [ ] Each subnet include firewall
  - [ ] Webserver installed automatically with public ip.
  - [ ] Admin/Management server from trusted locations (Conditional Access, Azure AD Premium P2)
  - [ ] Webserver connection via SSH/RDP only via Admin server
  - [ ] Storage location for BOOTSTRAP-SCRIPTS, accessible via Admin/Management server.
  - [ ] Webserver is scalable (Q&A 6-6-2023)
  
# ASSUMPTIONS
  - [ ] DDOS protection for Web server
  - [ ] One billing
  - [ ] Use cheapest available options possible, according to demands (it's learning project)
  - [ ] No private network available
  - [ ] Azure AD 
  - [ ] MFA for Admin/Management

# USER STORIES  
## Virtual Networks
  - [ ] I want to use three Vnets. One for the web-server, one for the management-server and one for the PostDeployment-Scripts.
  - [ ] All the V-Nets will be equiped with a NSG to control network traffic.
  - [ ] The V-nets with webserver and deployment scripts will be equiped with VNet-to-VNet VPN gateway connections.

## Web-server  
  - [ ] The installation needs to be done automated.
        https://learn.microsoft.com/en-us/training/modules/automate-virtual-machine-software-installation-configuration/
  - [ ] Webserver is for low density traffic with some times peakmoments. I use VM's for this, because they scale better. They are, however, a bit more costly and require some maintenance.  
        08-06-2023 After some research I am going to use Azure Appservices for this. Selecting the option Web App + Database.
        https://dzone.com/articles/microsoft-azure-app-service-cloud-services-or-vms
  - [ ] The VM's needs encryption. We can do this via the disk settings. The key for the encryption will be stored in the Key-Vault.
  - [x] Azure SQL database will be added to store data.
        https://www.sqlshack.com/azure-sql-database-vs-sql-server-on-azure-virtual-machines/  
        08-06-2023 Not needed. I use Appservices, option WebApps + Database
  - [ ] The server need a daily backup, what is stored for 7 days. We implement this with Azure Backup. This also needs a "Recovery Services Vault" to store the backup. No one needs access to this vault for security reasons.

## Management-server  
  - [ ] https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/azure-server-management/
  - [x] public ip address
  - [ ] The VM's needs encryption. We can do this via the disk settings. The key for the encryption will be stored in the Key-Vault.
  - [ ] Conditional Access (use Azure AD)
        https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/plan-conditional-access
  - [ ] Security (NSG of Firewall)
    
## PostDeployment Scripts
  - [ ] I am going to make a AppServices webserver en use pipeline for automatic deployment of the website.
  - [ ] Needs automated deployment to web-server. Use Azure Automation/Azure functions.

## Azure AD
  - [ ] Make overview of user roles (week 3)

## Security


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

### End of week review:
I have the basics thought out, and have created 2 v-nets, one for webappservices and one for management services. They are two different files at the moment, but the idea is to create one bicep code for the complete project. This will avoid issues about connecting different modules.
There are however two issues that needs to be solver before the end of next week:
- I have a child-parent connection that causes error in de appservice
- The appservice needs to be placed within the its own v-net.
When I can manage this I have a code of the backbone of the project. 
I also need to make an overview of the expected cost.  

I use the next two weeks to create the following:
- post-deployment storage and deployment
- app server backup
- security / firewalls / access control
- secret key-vault
- azure active directory
- tags
I have estimated two days per subject to tackle the above issues.  

## WEEK 2
Monday 12-06-2023
- Merged the managemet server with web server

