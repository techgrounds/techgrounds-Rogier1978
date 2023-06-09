# Azure - week 6 - Azure Functions
Study Azure Functions  

## Key-terms
**Azure Functions**  
Azure Functions is a serverless solution that allows you to write less code, maintain less infrastructure, and save on costs. Instead of worrying about deploying and maintaining servers, the cloud infrastructure provides all the up-to-date resources needed to keep your applications running.  

**serverless computing**  
Serverless computing enables developers to build applications faster by eliminating the need for them to manage infrastructure. With serverless applications, the cloud service provider automatically provisions, scales, and manages the infrastructure required to run the code.  

## Opdracht  
1. I have installed Microsoft Visual Studio with the Azure pack. Created a project with an Azure Function Template. I gave it the "rogierfunction1". In the "Additional Information"panel I selected "HTTP Trigger" as function and Authorization level to "Anonymous":  
2. ![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2009%20azure%20function%20add%20info.png)  


2. Visual Studio has now created a boilerplate code (kind of template) which by default is named "Function1". So I changed this in the code and also the filename to "HttpExample(.cs)".  
The code looks now like this:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2010%20function%20code.png)  

When pressing [F5] I can run the code locally. And this was the result:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2011%20function%20local%20run.png)  

I copied the http-address in my browser and added "?name=Rogier" this was the result:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2012%20local%20browser.png)  
I created a script for a very simple webpage.


3. Now I want to copy this to a function in my Azure portal. I right-click  on the name of the project in the "Solution Explorer" (right panel) and click "Publish". I must be logged-in on my Azure portal in MS Visual Studio, and I had already created an Resource group and Storage account (this is actually not necessary, but was already created in the study process). After applying some info about my Azure account I checked the box "run from package file" on the final page and click Finish. This brings me to the Publish tab.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2013%20solution%20explorer.png)  

  
And after clicking Publish, the function is deplyed in Azure  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2014%20publish%20tab.png)  
  
And this is the function in the Azure portal.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2015%20function%20in%20portal.png)    

4. After I click on the URL "https://rogierfunction120230510101258.azurewebsites.net" in the above screenshot it opens the following webpage:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2016%20azure%20function%20webpage.png)  
This is the default page of Azure functions.

And after adding "/api/HttpExample?name=Rogier" we get the same result as we did earlier in Visual Studio locally.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2016%20website%20succes.png)  



### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/azure-functions/  
https://learn.microsoft.com/en-us/azure/azure-functions/functions-create-your-first-function-visual-studio?tabs=in-process  
https://learn.microsoft.com/en-us/azure/app-service/overview-hosting-plans  


### Ervaren problemen
Needed a few tries to make this work. However after I created the resourc group in Azure this worked flawless. I think this has to do with timing of the login of the Azure portal in MS Visual Studio. Was wondering about an app service plan in Australia Central? Didn't expect this.

### Resultaat
I have found a script for a basic webpage, and published this from Visual Studio into the Azure Portal. This is only a script you can remotely trigger via the website "https://rogierfunction120230510101258.azurewebsites.net/api/HttpExample?name=Rogier". In the websitename you will find the name of the script (HTTP example) and my name (Rogier). In the final screenshot of the result, you see the script has run the script and filled in my name. This without the creation of a server in the Azureportal.
