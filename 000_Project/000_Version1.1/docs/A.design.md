## Introduction  
Here in front of you, you have the first document for the cloud endproject of Rogier van Vliet. The complete project consist of three documents (A to C) and a set of .bicep and .sh files for deployment of the infrastructure.
Document A (this document) introduces you to the project and it gives an overview of the design and decisions of v1.0.
Document B is an timelog of the first 4 weeks of the project.
Document C is a manual to get you started.

## The infrastructure  
I see this infrastructure concisting of 2 main parts. Both parts housed in a virtual network containing subnets and these are connected via a peering connection for internal traffic. Furthermore there are some additiional resources to cover general tasks like datastorage, backup and a keyvault to store sensitive data.

The first part (the management server) is the core of the infrastructure. In here we find a virtual machine (VM) with Standard D2ds v4 (2 vcpus, 8 GiB memory) and Windows Server 2022 Datacenter Azure Edition running. I think this is sufficient to perform the tasks to be done here. 
At the moment it has a dynamic public IP adres to get access to this environment. Only one IP address is allowed to secure access to this part of the infrastructure. This is done by the NSG (Network Security Group).
Also connections to the postdeployment storage, the database and the recoverysystem will be available here.  

The second part (the web server) is also a VM. The specs for this VM are Standard B2s (2 vcpus, 4 GiB memory) and it runs Linux (ubuntu 20.04). Because Linux is a less demanding program, we can do with lower specs. On the Linux machine there is an Apache module installed to deploy websites. Also this VM is nested in a subnet with a NSG. This NSG will allow only traffic on port 80 via public addres to enter the webserver and opens port 22 and 3389 for private address. This final route allows a connection between our management server and the webserver via SSH or RDP.  

## Storage  
The webserver will be equiped with a MySQL single server database for storing received data from the website. This sort of  databaseoffers a wide range of features like indexing, data replication, backup and recovery mechanism and user access control.  
For the postdeploymentscripts there will be a blob storage. This is a convenient solution that is costeffective, secure and scaleable. Both the database and postsployment-storage will be accessible from the management server. There is also a possibility to access this blob storage via Azure Storage Explorer if you have the correct login credentials.

## Security
The security will be handled by limiting access to sensitive parts of the infrastructure. At the moment is the management server only available via my own ip address. The webserver is only available via TCP port 80. This is the port used for visiting http-websites. This limits access to these parts of the network to only required traffic. Via the management server you can access different parts of the infrastructure via the windows environment.
Finally there will be a keyvault to store sensitive information. This is the place where we keep passwords. Also keys for the encryption of the storageaccounts, VMs, database and recovery will be stored safely in the key-vault. Access will be prohibited here. Only services requiring these secret data will gain access via so called managed identities. These allow services to access the key-vault without human interaction.  

After deploying the infrastructure looks like this. You can find this overview if you login to the azureportal, go to the resourcegroup 000-project and click on 'Resource visualizer' on the left panel underneath overview:

IMG IMG IMG IMG IMG IMG

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
  - [x] public ip address (At the moment my own public IP adres)
  - [x] The VM's needs encryption. We can do this via the disk settings. The key for the encryption will be stored in the Key-Vault.
  - [x] Conditional Access. You can only access this via one ip address.
        https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/plan-conditional-access
  - [x] Security (NSG)  
  - [x] Via managemnet-server we need to cennect to web-servers,
  - [ ] post-deploymentscripts.
    
## PostDeployment Scripts
  - [x] This is a blobstorage. 
  - [ ] Needs a connection from the management server for posting updated script, and to the webserver vmss to deploy these scripts.

## Azure AD
  - [x] Make overview of user roles (week 3). This will not be used. Using access policies in key vault.

## Key Vault
  - [x] To store all the secret info. (encryption, passwords etc.)
  - [ ] Possibility for redeployment

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





