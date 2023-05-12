# Azure week 6 - Queue Storage & Service Bus
Study Queue Storage and Service Bus
  
While both queuing technologies exist concurrently, Azure Queues were introduced first, as a dedicated queue storage mechanism built on top of the Azure storage services. Service Bus queues are built on top of the broader "brokered messaging" infrastructure designed to integrate applications or application components that may span multiple communication protocols, data contracts, trust domains, and/or network environments.  
  
## Key-terms
**Azure Queue Storage** - is a service for storing large numbers of messages. You access messages from anywhere in the world via authenticated calls using HTTP or HTTPS. A queue message can be up to 64 KB in size. A queue may contain millions of messages, up to the total capacity limit of a storage account.  

**URL format** - Queues are addressable using the following URL format:  
   - https://<storage account>.queue.core.windows.net/<queue>  

**Storage account** - All access to Azure Storage is done through a storage account.  

**Queue** - A queue contains a set of messages.  


**Service Bus** - Data is transferred between different applications and services using messages. A message is a container decorated with metadata, and contains data. The data can be any kind of information, including structured data encoded with the common formats such as the following ones: JSON, XML, Apache Avro, Plain Text.  



## Opdracht
### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/storage/queues/storage-queues-introduction  
https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview  
https://learn.microsoft.com/en-us/archive/msdn-magazine/2012/june/microsoft-azure-comparing-microsoft-azure-queues-and-service-bus-queues  
https://github.com/Huachao/azure-content/blob/master/articles/service-bus/service-bus-azure-and-service-bus-queues-compared-contrasted.md  

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
