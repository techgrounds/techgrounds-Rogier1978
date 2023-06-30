## Introduction  
Here in front of you, you have the first document for the cloud endproject of Rogier van Vliet. The complete project consist of four documents (A to D) and a set of .bicep and .sh files for deployment of the infrastructure.
Document A (this document) introduces you to the project and it gives an overview of the endresults of v1.0.
Document B is an overview of desicions I made to get to the endresult.
Document C is an overview of the timelog of the 4 weeks and how progress is made.

## The infrastructure  
I see this infrastructure concisting of 2 main parts. Both parts housed in a virtual network containing subnets and these are connected via a peering connection for internal traffic. Furthermore there are some additiional resources to cover general tasks like datastorage, backup and a keyvault to store sensitive data.

The first part (the management server) is the core of the infrastructure. In here we find a virtual machine (VM) with Standard D2ds v4 (2 vcpus, 8 GiB memory) and Windows Server 2022 Datacenter Azure Edition running. I think this is sufficient to perform the tasks to be done here. 
At the moment it has a dynamic public IP adres to get access to this environment. Only one IP address is allowed to secure access to this part of the infrastructure. This is done by the NSG (Network Security Group).
Also connections to the postdeployment storage, the database and the recoverysystem will be available here.  

The second part (the web server) is also a VM. The specs for this VM are Standard B2s (2 vcpus, 4 GiB memory) and it runs Linux (ubuntu 20.04). Because Linux is a less demanding program, we can do with lower specs. On the Linux machine there is an Apache module installed to deploy websites. Also this VM is nested in a subnet with a NSG. This NSG will allow only traffic on port 80 via public addres to enter the webserver and opens port 22 and 3389 for private address. This final route allows a connection between our management server and the webserver via SSH or RDP.  

## Storage  
The webserver will be equiped with a MySQL single server database for storing received data from the website. This sort of  databaseoffers a wide range of features like indexing, data replication, backup and recovery mechanism and user access control.  For the postdeploymentscripts there will be a blob storage. This is a convenient solution that is costeffective, secure and scaleable. Both the database and postsployment-storage will be accessible from the management server.



