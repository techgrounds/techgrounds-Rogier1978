# AZ-05 Storage Account
Create Azure Storage Account and store some data. Also create a container and store a website.  

## Key-terms
**Azure Storage Account**  
An Azure storage account contains all of your Azure Storage data objects, including blobs, file shares, queues, tables, and disks. The storage account provides a unique namespace for your Azure Storage data that's accessible from anywhere in the world over HTTP or HTTPS. They use the Azure Resource Manager.  

**Blob Storage**  
Azure Blob Storage is Microsoft's object storage solution for the cloud. 



## Opdracht  
1. On the home screen, there is a service called "Storage accounts". After clicking it shows an overview of mine sorage accounts. I have none so I click "+ Create". I entered a form and I filled it in and clicked "Next Advanced":  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_05%20storage%20account%2001.png)  

I have filled in all pages seen in the top menu of the page, and created a storage account with details below:
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_05%20storage%20account%20overview.png)  

2. In the storage browser I have created two containers. One called "tijger" for the picture and one called "awswebsite" for the supplied website I uploaded a picture in the first and the files for the website in the second. Because the picture needs private access I have clicked on the link for the container were I could adjust the Public access level to Private. This will result that everybody can access the weblink but only I can see the picture.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_05%20storage%20containers.png)  

3. On my computer I installed Azure Storage Explorer. After the login I was able to show the contents of my Storage Containers. Below you can see the picture in the Explorer app in my pc. 
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_05%20Azure%20storage%20explorer.png)  

Afterwards I deleted the Storage account to save costs.

### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction  
https://www.youtube.com/watch?v=AhuNgBafmUo  

### Ervaren problemen
First real exploration in Azure. I need to learn how things are structured. Lost some of my use sources, and weren't able to find them anymore.

### Resultaat
I shared the link of the picture and the website on Slack. My study group could see my website, but not my picture. The picture appeared also in my Storage Explorer app on my PC.
