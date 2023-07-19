Below are the steps you must take to deploy the bicep file. You need an Azure subscription in advance to deploy it into. Also needed is Powershell and a map on your computer with the .bicep files copied there. 
Finally you need the Windows Remote Desktop App and Microsoft Azure Storage Explorer installed on yur PC.

## DEPLOYING 
Follow the instructions below to deploy the files:
- Copy the contents of the github map 000-project/000_Version1.0 in a map on your desktop  
- Go to powershell ([WIN]+x and then select powershell)
- In powershell go to the map where you stored you bicep files.
- Type "az login" and press enter. A screen in your webbrowser will open and you login to your azure account.
- Type "az deployment sub create --location westeurope --template-file main.bicep"
- Now enter username and password. Usernames can be a maximum of 20 characters in length and cannot end in a period ("."). Passwords must also meet 3 out of the following 4 complexity requirements: Have lower characters, have upper characters, have a digit and have a special character.
Remember these, you will need them later on.
- Finally enter the IP address from were you want to reach your management server. Use the form "xxx.xxx.xxx.xxx"

The deployment begins and you have to wait till it is finished. This will take a few minutes.

## FINDING IP ADDRESSES   
If you want to access the management server, and web server you first need to retrieve the ip addresses from the Azure portal.  
- Log into the Azure portal and go to the subscription where you have deployed the bicep files into.
- Type "resource groups" in the search bar and click "Resource group" in the results. Click on "000-project" resource group.
- You will see a list of services. Click on type and all the services are ordered by type. Look for the two "Public IP address" items (click on "type" to sort them by type).  
## FINDING MANAGEMENTSERVER PUBLIC IP  
- There is one named "managementVmPublicIp". Here you can find the private ip-address of the management-server (this will be different everytime you deploy this infrastructure). You need this to access the management server.  
## FINDING WEBSERVER PUBLIC IP  
- The other one is called "webserverVmssPublicIp". Here you can find ip-address of the public webserver. 
If you open this last public ip-address in your webbrowser, you have to click "Advance..." and "Accept the Risj and Continue" to trust the site with the selfsigned certificate and reach the "Apache2 Ubuntu Default Page". This will be your website when you have deployed it on the server.

## FINDING WEBSERVER PRIVATE IP (FOR ACCESSING FROM MANAGEMENT SERVER)
- For this private ip address you need to find the VM scaleset in the Azure "Resource groups" of "000-project" list. This resource is called "webserverVmss". Find it and click on it.
- On the left panel find under "settings" the "instances" item and click on this as well.  
- Here you will find a list of alle the VMs created by the scale set. It's probably one right after the deployment. Click it.  
- On the right side you find the private ip address of the selected vm in the scaleset. It is in the 10.10.10.128 - 10.10.10.255 range.  


## ACCESSING THE MANAGEMENT SERVER
- To enter the management server, open the Remote Desktop App.  
- Click "+ Add" and then PC.  
- You need to fill in some of the retrieved info. First the Public IP-address of the managment server you found in the '"managementVmnic""-resource. Then click on the "+" near account and fill in the username and password you choose when deploying the bicep files. Save the configuration.  
- Now click on the pc item and click "Toch verbinding maken" a new window will open with a Windows Server 2022 Datacenter Edition running.  

## ACCESSING THE WEBSERVER VIA SSH FROM THE MANAGEMENT
- To access the webserver via SSH you open the start menu, select "Windows Powershell" and click on "Powershell" (without (x86)).
- When the powershell windows opens type the command "ssh 'username'@'ip-address' where username is the username you choose at the start of the deployment and the ip-address the private ip-address you looked up in the VM scale set. Type "yes" to continue. And finally enter the matching password of the username, also choosen with the deployment.  
- You are now in the Linux Ubuntu 20.04 of the webserver.  

## ACCESSING THE MY SQL DATABASE
- When you are in the webserver you can access the mySQL database by using the command "mysql -h sqldbserver000proj.mysql.database.azure.com -u 'username'@sqldbserver000proj -p" were 'username' is the username chosen at the start of the deployment followed with enter. Now use the matching password to enter the mySQL database.  

## ACCESSING FILESSHARE FROM WINDOWS POWERSHELL
- In the Azure portal resources list go to "storageacc000project" and click on "file shares" in the left panel. Select "deployments".  
- On the top of the page select "connect". In the Connect windoW select a Drive letter and click "Show script". Copy the complete script to the clipboard.
- When in the powershell of th managment server you can paste the script there on the commandline. This script creates a Z: drive and gives you access to the fileshare in the storage account.
- If you run "Azure storage explorer" on you desktop PC and login to your Azure account, the storage account will appear underneath "Opslagaccounts" it's called "storageacc000project". Select "File Shares" the "deployments". You can store your postdeployment scripts here.
- The scripts will now appear in the Z: drive on the powershell.