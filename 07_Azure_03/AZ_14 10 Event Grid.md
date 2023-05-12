# Azure week 6 - Event Grid
Study Event Grid  

## Key-terms
**Event Grid**  
is a highly scalable, serverless event broker that you can use to integrate applications using events. Events are delivered by Event Grid to subscriber destinations such as applications, Azure services, or any endpoint to which Event Grid has network access. The source of those events can be other applications, SaaS services and Azure services.  
You can select Sources and Endpoints to communicate (with events). Events can be all sorts of info (data, alerts, updates)

###Concepts
- **Events** - What happened.  
- **Event Source** - Where the event took place.  
- **Topics** - The endpoint where publishers send events.  
- **Event subscriptions** - The endpoint or built-in mechanism to route events, sometimes to more than one handler.  
- **Event handlers** - The app or service reacting to the event.  


## Opdracht
I am going to use Event Grid to send an event and display this in a web app. 
1. First I am goiing to activate the Event Grid by registering it in the Resource Provider list. I go to "Subscriptions" select "Cloud Student 3" and click on "Resource Providers" under settings in the left menu. In the list I look up Microsoft.EventGrid, select it and click register at the top.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2017%20eventgrid%20register.png)  


2. Next I create an Event Grid Topic. I lookup event grid topic in the search bar, go to the service and create one. I create a resource group and name it "rogiertopic". In this topic I create a subscription called "rogiersubscr" with a Webhook Endpoint type "https://rogierwebsite.azurewebsites.net/api/updates".

3. Now I am going to create a webapp to function as an endpoint. On the learn.microsoft webpage you can find a prebuilt web app so we use this. On the custom deployment page we fill in the Resource group, the sitename "rogierwebsite", a Hosting plan name "rogierplan" for the app service plan and finally we click create. The resourcegroup now looks like this:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2018%20resource%20group.png)    
  
4. On the App Service "rogierwebsite" int the Azure portal you can lookup the webaddress for the endpoint (Default domain).  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2019%20rogierwebsite.png)  

When you go to the website you see this:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2020%20event%20grid%20webpage%201.png)  

5. Now we need to trigger an event. The goal is to see some data appear in the endpoint. I used the CLI to do this. First I entered:  
  
- endpoint=$(az eventgrid topic show --name rogiertopic -g AZ_14 --query "endpoint" --output tsv)
  
to assign an endpoint (rogiertopic) for the event and the resourcegroup we used. (AZ_14).
Next:  
  
- key=$(az eventgrid topic key list --name rogiertopic -g AZ_14 --query "key1" --output tsv)  
  
To create a key. Access keys are used to authenticate an application publishing events to the Azure Event Grid Topic. Now we can fdefine the event to trigger:  

- event='[ {"id": "'"$RANDOM"'", "eventType": "recordInserted", "subject": "myapp/vehicles/motorcycles", "eventTime": "'`date +%Y-%m-%dT%H:%M:%S%z`'", "data":{ "make": "Ducati", "model": "Monster"},"dataVersion": "1.0"} ]'  
  
I am going to insert a record myapp/vehicles/motorcycles (this is an example). Finally I need to send the event:  

curl -X POST -H "aeg-sas-key: $key" -d "$event" $endpoint  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2021%20bash.png)  
  
On the website we see that the event has arrived:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2022%20web%20finally.png)  





### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/event-grid/overview#what-can-i-do-with-event-grid  
https://learn.microsoft.com/en-us/azure/event-grid/custom-event-quickstart-portal  



### Ervaren problemen


### Resultaat
When running some scipt on the CLI (first we create an endpoint for destination, then a key for authentication and finally the event itself), we can trigger an event to send something in the network. We see the data has arrived on the website I found on learn.microsoft.com.
