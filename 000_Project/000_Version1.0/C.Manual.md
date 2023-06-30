Below are the steps you must take to deploy the bicep file. You need an Azure subscription in advance to deploy it into. Also needed is Powershell and a map on your computer with the .bicep files copied there. Finally you need a Windows Remote Desktop App.

## DEPLOYING 
Follow the instructions below to deploy the files:
- Copy the contents of the github map 000-project/000_Version1.0 in a map on your desktop  
- Go to powershell ([WIN]+x and then select powershell)
- In powershell go to the map where you stored you bicep files. (cd desktop\"name of folder")
- Type "az login" and press enter. A screen in your webbrowser will open and you login to your azure account.
- Type "az deployment sub create --location westeurope --template-file main.bicep"
- Now enter usernames and passwords for management server, web server and database. Usernames can be a maximum of 20 characters in length and cannot end in a period ("."). Passwords must also meet 3 out of the following 4 complexity requirements: Have lower characters, have upper characters, have a digit and have a special character.
Remember these, you will need them later on.

The deployment begins and you have to wait till it is finished. This will take a few minutes.

## ACCESSING MANAGEMENT SERVER AND WEB SERVER
Now we want to access the management server, and web server. First we need to retrieve the ip addresses.
- Go into the Azure portal of the subscription where you have dployed the bicep files into.
- Go to "resource groups" in the search bar and click "Resource group" in the results. Click on "000-project" resource group.
- You will see a list of services. Click on type and all the services are ordered by type. Look for the two "Network Interface" items (click on "type" to sort them by type). There is one named "management-prd-vnet-nic". Here you can find private and public ip-addresses of the management-server (this will be different everytime you deploy this infrastructure). The other one is called "app-prd-vnet-nic". This is the webserver. 
If you open the public ip-address in your webbrowser it will open the "Apache2 Ubuntu Default Page"
Later you need the PUBLIC addres of the management server, and the PRIVATE address of the webserver. It is wise to make a note of these two addresses.  

- To enter the management server, open the Remote Desktop App. 
- Click "+ Add" and then PC.
- You need to fill in some of the retrieved info. First the Public IP-address of the managment server. Then click on the "+" near account and fill in the username and password you choose when deploying the bicep files. Save the configuration.
Now click on the new stored pc and a new window will open with a Windows Server 2022 Datacenter Azure Edition running.

- To access the webserver via SSH you open the start menu, select "Windows Powershell" and click on "Powershell" (without (x86)).
- When the powershell windows opens type the command "ssh 'username'@10.10.10.10" where username is the username for the webserver you choose at the start of the deployment. Type "yes" to continue. And finally the matching password with the username is asked to login.
