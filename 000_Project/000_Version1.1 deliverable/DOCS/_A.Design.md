## Introduction  
Here in front of you, you have the first document for the cloud endproject of Rogier van Vliet. The complete project consist of three documents (A to C) and a set of .bicep and .sh files for deployment of the infrastructure.
Document A (this document) introduces you to the project and it gives an overview of the design and decisions of v1.0.
Document B is an timelog of the first 4 weeks of the project.
Document C is a manual to get you started.

## The infrastructure  
I see this infrastructure concisting of 2 main parts. Both parts housed in a virtual network containing subnets. These two Vnets are connected via a peering connection for internal traffic. Furthermore there are some additiional resources to cover general tasks like fileshare for datastorage, recovery vault for backup and a keyvault to store diskencryption keys.

## The managementserver
The first part (the management server) is the core of the infrastructure. In here we find a virtual machine (VM) with Standard D2ds v4 (2 vcpus, 8 GiB memory) and Windows Server 2022 Datacenter Azure Edition running. I think this is sufficient to perform the tasks to be done here. 
It has a dynamic public IP adres to get access to this environment. Only one IP address is allowed to secure access to this part of the infrastructure. This is done by the NSG (Network Security Group). Here a NSG is sufficient because we want to route traffic according to certain rules. Intrusion detection and more advanced capabilities are not so much needed here.
Also connections to the postdeployment storage, the database and the webservers backend will be available here.  

## The webserver
The second part (the web server) is a VM with scaleset. The specs for this VM are Standard B2s (2 vcpus, 4 GiB memory) and it runs Linux (ubuntu 20.04). Because Linux is a less demanding program, we can do with lower specs. On the Linux machines there are Apache modules installed to deploy websites.  
Also this VM is nested in a subnet with a NSG. This NSG will allow only traffic on port 80 and 443 (HTTP and HTTPS) via public addres to enter the webserver and opens port 22 and 3389 for private address. This final route allows a connection between our management server and the webserver via SSH or RDP. Als no firewall is supplied here because the productowner wants to apply it's own protection against DDOS attacks and other threads.  
The scale sets can scale up to three instances, and should be enough to accomodate the busiest traffic moments. They scale up after 5 minutes with more than 70% CPU load and scale down when the CPU load drops below 30% for 5 minutes. The upscaling will be fast enough to intercept the busy moments.  
The scale set is also equiped with health probes extension. Whe a VM instance fails it will be replaced with a new identical one.

## The webservers gateway
The webserver is connected through an Application Gateway. The gateway is connected with an Public IP-address to the WWW. The access is limited to port 80 and 443 (HTTP and HTTPS) only. All traffic routed to the website will be roued to port 433. Here it issues self signed certificates that makes TLS1.2 encryption possible.  
The gateway also acts as loadbalancer to distribute incoming traffic over the VM machines available at the scale set.


## Storage  
The webserver will be equiped with a MySQL single server database for storing received data from the website. This sort of  database offers a wide range of features like indexing, data replication, backup and recovery mechanism and user access control. These databases are relatively easy to manage and cost effective. They are also equiped with backup functions.
For the postdeploymentscripts there will be a file share sollution. This is a convenient solution that uses SMB and allows compatibility access across multiple applications. 
Both the database and postsployment-storage will be accessible from the management server. There is also a possibility to access this blob storage via Azure Storage Explorer if you have the correct login credentials.

## Keyvault
Finally there will be a keyvault to store sensitive information. This is the place where we keep keys for the diskencryption of the VM drives.  

After deploying the infrastructure looks like this. You can find this overview if you login to the azureportal, go to the resourcegroup 000-project and click on 'Resource visualizer' on the left panel underneath overview:

IMG IMG IMG IMG IMG IMG

# USER STORIES  
## Virtual Networks
  - [x] I want to use two Vnets. One for the web-server, one for the management-server.
  - [x] All the V-Nets will have subnets equiped with a NSG to control network traffic.
  - [x] There is peering link between management server and web server via SSH.

## Web-server  
  - [x] The installation needs to be done automated.
  - [x] Webserver use a scaleset for 1-3 instances.
  - [x] The VM's needs encryption. We can do this via the disk settings. The key for the encryption will be stored in the Key-Vault.
  - [x] Azure mySQL database will be added to store data.  
  - [x] Need access via proxy server.
  - [x] HTTPS and TLS1.2 with self signed certificate  

## Management-server  
  - [x] Access from one public ip address
  - [x] The VM's needs encryption. We can do this via the disk settings. The key for the encryption will be stored in the Key-Vault.
  - [x] Security (NSG)  
  - [x] Via managemnet-server we need to cennect to web-servers,
  - [x] post-deploymentscripts. Accessible via the powershell with a script provided after deployment in Azure portal
    
## PostDeployment Scripts
  - [x] This is a Fileshare. 
  - [x] Needs a connection to the management server for posting updated script.

## Key Vault
  - [x] To store all the secret info. (encryption, passwords etc.)
  - [ ] Possibility for redeployment

## Security
  - [x] Firewall on each subnet (security group)
  - [x] Conditional access to management server (via single IP address)
  - [x] Public webaccess via port 80 aand 443
  - [x] Encryption of all VM harddrives  
  - [ ] Traffic encrypted
  - [x] key-vault to store sensitive data

## Version 1.1
 - [x] Scaleset with application gateway
 - [x] Certificate TLS 1.2
 - [x] Health check via VM scaleset




