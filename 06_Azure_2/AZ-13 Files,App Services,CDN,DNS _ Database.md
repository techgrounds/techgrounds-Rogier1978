# AWS_AZ-13 Files,App Services,CDN,DNS _ Database
Study App Service, CDN, Azure DNS, Azure files, Azure Database (+ managed instances).  

## App Service  
Azure App Service is an HTTP-based service for hosting web applications, REST APIs, and mobile back ends. You can develop in your favorite language, be it .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python. Applications run and scale with ease on both Windows and Linux-based environments.  
An App Service Environment is an Azure App Service feature that provides a fully isolated and dedicated environment for running App Service apps securely at high scale. An App Service Environment can host your Windows web apps, Linux web apps, Docker containers (Windows and Linux), Functions, Logic apps (Standard).
  
**Mobile Back End** 
A backend for a mobile application is the part of the app that runs on a server, rather than on the device itself. The backend provides the functionalities that the app needs to store and manage data, authenticate users, process and analyze data, and communicate with other systems or services.  

**RESTful APIs**
RESTful API is an interface that two computer systems use to exchange information securely over the internet. 
An application programming interface (API) defines the rules that you must follow to communicate with other software systems. Developers expose or create APIs so that other applications can communicate with their applications programmatically. For example, the timesheet application exposes an API that asks for an employee's full name and a range of dates. When it receives this information, it internally processes the employee's timesheet and returns the number of hours worked in that date range.  
  

## CDN (Content Delivery Network)  
A content delivery network (CDN) is a distributed network of servers that can efficiently deliver web content to users. A CDN store cached content on edge servers in point-of-presence locations that are close to end users, to minimize latency.  
  
**CDN edge server**
A CDN edge server is a computer that exists at the logical extreme or “edge” of a network. An edge server often serves as the connection between separate networks. A primary purpose of a CDN edge server is to store content as close as possible to a requesting client machine, thereby reducing latency and improving page load times.  
  
**POP (point-of-presence)** 
Where two or more networks or communication devices share a connection

## Azure DNS  
Azure DNS is a hosting service for DNS domains that provides name resolution by using Microsoft Azure infrastructure. By hosting your domains in Azure, you can manage your DNS records by using the same credentials, APIs, tools, and billing as your other Azure services. A DNS record is simply a database that maps human-friendly URLs to IP addresses.  

Instead of a DNS server, you can use Azure to host your owned domains. At the registrar (where you have registered your domain) you can configure an Azure name server to link to this domain. In Azure you can then manage your records.

**DNS zone** A domain is a unique name in the Domain Name System, for example 'contoso.com'. A DNS zone is used to host the DNS records for a particular domain. For example, the domain 'contoso.com' may contain several DNS records such as 'mail.contoso.com' (for a mail server) and 'www.contoso.com' (for a website).  


## Azure Files  
Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and Azure Files REST API. Azure file shares can be mounted concurrently by cloud or on-premises deployments. SMB Azure file shares are accessible from Windows, Linux, and macOS clients.  
It uses Server Message Block (SMB) to function and this requires an open port 445.

#### Opdracht Azure Files  
I created a File Share storage account and accessed this in my Linux via a VM.
1. I create a Storage account by selecting it in the Azure services menu and clicking +create. The I create new resource group "AZ_13" and name the Storage account "fsstorage". I also select LRS (Locally redundant Storage) for the lowest cost. Below is a screenshot of the overview page.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_13%2001%20fsstorage.png)  


2. On the left under "Data storage" you can click on "File shares" to access the file share settings. Click on "+File share" and create a new "File share" service. In this service I created a directory "+Add directory" called "mydirectory". In this directory I uploaded a jpg-file from my local harddrive (photo-savanna.jpg).  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_13%2001%20fsstorage.png)  

When I am in my fileshare overview windows I can click on "connect". Here we find info about connecting to the Fileshare from various sources. We select Linux because we want to use Linux to access the File share. On script we find the script we need late in Linux.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_13%2003%20script.png)  

3. I created a simple VM that I can access via SSH. When logged in I updated (sudo apt update), installed the firewall (sudo install ufw) and allowed port 22 and 445 (sudo ufw allow 22 and sudo ufw allow 445).  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_13%2004%20linux%20firwall.png)  

4. I copied the script for the fileshare I mentioned in step 2 in a script file in linux and changed permissions to executable. After running the script it created the directory /mnt/fileshare/mydirectory and in this directory it has stored the file I uploaded.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_13%2006%20fs%20directory%20linux.png)  
  
  
## Azure Database (+ managed instance)

Azure SQL is a family of managed, secure, and intelligent products that use the SQL Server database engine in the Azure cloud.
- Azure SQL Database: Support modern cloud applications on an intelligent, managed database service, that includes serverless compute.  
- Azure SQL Managed Instance: Modernize your existing SQL Server applications at scale with an intelligent fully managed instance as a service, with almost 100% feature parity with the SQL Server database engine. Best for most migrations to the cloud.  
- SQL Server on Azure VMs: Lift-and-shift your SQL Server workloads with ease and maintain 100% SQL Server compatibility and operating system-level access.  

**SQL (Structured Query Language)** - is a domain-specific language used in programming and designed for managing data held in a relational database management system (RDBMS), or for stream processing in a relational data stream management system (RDSMS). 

**Relational database** - A relational database is a (most commonly digital) database based on the relational model of data, as proposed by E. F. Codd in 1970. A system used to maintain relational databases is a relational database management system (RDBMS). Many relational database systems are equipped with the option of using SQL (Structured Query Language) for querying and updating the database.  

One well-known definition of what constitutes a relational database system is composed of Codd's 12 rules. However, no commercial implementations of the relational model conform to all of Codd's rules, so the term has gradually come to describe a broader class of database systems, which at a minimum:  
- Present the data to the user as relations (a presentation in tabular form, i.e. as a collection of tables with each table consisting of a set of rows and columns);
- Provide relational operators to manipulate the data in tabular form.  

**non-relational database**  
A non-relational database is a database that does not use the tabular schema of rows and columns found in most traditional database systems. Instead, non-relational databases use a storage model that is optimized for the specific requirements of the type of data being stored. For example, data may be stored as simple key/value pairs, as JSON (JavaScript Object Notation) documents, or as a graph consisting of edges and vertices.  

#### Opdracht Azure database  
1. I created an Azure SQL database by cliking "SQL databases" in the service menu and clik "+create". Here we can make settings to creata a new database. After the usual sttings for resourcegroup I selected "new server" and created a server with the setting below:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_13%2010%20serversettings.png)  

Under "Compute + storage"  we can setup the hardware configurations for the database (max vCores, max memory max storage). I lift it at General Purpose (most budget friendly). We put the "Connectivity endpoint" to public endpoint. So this database can be accessed from outside the network. I also set "Add current client IP address" to firewall to yes, so my local PC will pass the clouds firewall. This is of no real importance for the excercise, because we are not going to access the database from outside. I have left the "Connection policy" and "Encryption connections" at the default settings.  
On the next tab I left the security settings to the default settings as well. And on the "Additional settings" tab I can select Sample at the Data source to create a example database and I click Review+create and create to make a new database.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_13%2010%20database%20overview.png)  

2. At the left of the overview screen you can click on "Query editor (preview)". Here you can lookup queries with some commands. I use the following script:  
-  SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName  
FROM SalesLT.ProductCategory pc  
JOIN SalesLT.Product p  
ON pc.productcategoryid = p.productcategoryid;  

After clicking "Run" it looked up the data and made 2 colums with Categoryname and Productname with 20 items. This is a little example to show what you can do with a SQL database.
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_13%2012%20query.png)  


### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/app-service/overview  
https://aws.amazon.com/what-is/restful-api/  
https://www.cloudflare.com/learning/cdn/glossary/edge-server/  
https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction  
https://learn.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-portal?tabs=azure-portal  
https://learn.microsoft.com/en-us/azure/azure-sql/azure-sql-iaas-vs-paas-what-is-overview?view=azuresql  
https://en.wikipedia.org/wiki/SQL  
https://www.freecodecamp.org/news/basic-sql-commands/  


### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
