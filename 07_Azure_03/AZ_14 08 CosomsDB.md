# Azure Week 6 - CosmosDB 
Study CosmosDB

## Key-terms
**Azure CosmosDB**  
Azure Cosmos DB is a globally distributed database system that allows you to read and write data from the local replicas of your database and it transparently replicates the data to all the regions associated with your Cosmos account.  
It is a fully managed NoSQL database designed to provide low latency, elastic scalability of throughput, well-defined semantics for data consistency, and high availability.  

You can select regions in the setup to copy  the database somewhere close to the user for low latency.  
It's schemaless, so various type of DB's are supported (e.g. SQL, Cassandra, Gremlin).

**provisioned throughput**  
Set a threshold for RU's (Request Units) as a guaranteed throughput. Billing is according the provisioned RU's.
**serverless**  
Don't need to set provisions. The billing is per RU's consumed.  


## Opdracht 
1. I have created an Azure Cosmos DB for NoSQL with the following settings:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2005%20cosmosdb%20settings.png)  
  

2. After the deployment is finished, I want to create some data. In the left panel I click on Data Explorer. I click new container and I fill in some ID's for the new container were I will store some data.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2006%20new%20container.png)  


3. I found this script on the Microsoft learn page:  
    {  
     "id": "1",  
     "category": "personal",  
     "name": "groceries",  
     "description": "Pick up apples and strawberries.",  
     "isComplete": false  
    }    

And I pasted it on the right panel in the "Items" panel:  


I did this a second time and a tabel grows with anothe item.  



### Gebruikte bronnen
https://learn.microsoft.com/en-us/training/modules/explore-azure-cosmos-db/  


### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
