## Introduction  
Here in front of you, you have the first document for the cloud endproject of Rogier van Vliet. The complete project consist of four documents (A to D) and a set of .bicep and .sh files for deployment of the infrastructure.
Document A (this document) introduces you to the project and it gives an overview of the endresults of v1.0.
Document B is an overview of desicions I made to get to the endresult.
Document C is an overview of the timelog of the 4 weeks and how progress is made.

## The infrastructure  
I see this infrastructure concisting of 2 main parts. Both parts housed in a virtual network containing subnets. Furthermore there are some additiional resources to cover general tasks like datastorage, backup and a keyvault to store sensitive data.

The first part (the management server) is the core of the infrastructure. In here we find a virtual machine (VM) with Standard D2ds v4 (2 vcpus, 8 GiB memory) and Windows Server 2022 Datacenter Azure Edition running. I think this is sufficient to perform the tasks to be done here. 
At the moment it has a dynamic public IP adres to get access to this environment. Only one IP address is allowed to secure access to this part of the infrastructure. This is done by the NSG (Network Security Group).
Also connections to the postdeployment storage, the database and the recoverysystem will be available here.  

The second part (the web server) is also a VM. The specs for this VM are Standard B2s (2 vcpus, 4 GiB memory) and it runs Linux (ubuntu 20.04). Because Linux is a less demanding program, we can do with lower specs. On the Linux machine there is an Apache module installed to deploy websites. Also 
