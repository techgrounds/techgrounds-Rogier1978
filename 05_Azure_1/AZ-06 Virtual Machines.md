# AZ-06 Virtual Machines
Create a virtual machine.

## Key-terms
**Azure Virtual Machines**  
Azure Virtual Machines are image service instances that provide on-demand and scalable computing resources with usage-based pricing.

## Opdracht
### Gebruikte bronnen
1. After the previous excercise, I now knew how to create a new service. I started creating a virtual machine by clicking on the virtual machine icon on the Azure home page. Next I could fill in the supplied information to create this machine. Below a screen with some settings:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_06%20vm%20settings.png) 

2. After clicking create Azure starts making my machine and aftfe a while he notified me about the succes. He also cretates a public/private key pair and stored the public key on my local hard drive.   
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_06%20vm%20notification.png)  

3. On the home page we can see the resources that were created. That is the Virtual Machine (rogiervm), A public IP address (rogiervm-ip, in this case it was 20.77.87.99) and a networkinterface (rogiervm283).  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_06%20resources.png)  

4. Now I have to check if the VM is working. I went to the Windows Powershell and started to enter "ssh -p 22 -i desktop/rogiervm_key.pem rogiervm@20.77.87.99" First this username was incorrect. On the connect page on azure Virtual Machine page, I can find all the info I needed to access the VM.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_06%20connect.png)  

5. The next problem was a notification about the wrong permission settings on the public-key file on my harddrive. After some struggles me and my team could create the correct settings (right click > properties > security > advanced). Now the settings were read-only for the selected user, and with the command "ssh -i dektop\rogiervm_key.pem azureuser@20.77.87.99" I could login to my VM.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_06%20vm%20inlog.png)  

### Ervaren problemen
Hardest part was the permission for the public key. Maybe use the WSL on Windows next time. The rest of the excersice was almost written step by step in the documentation.

### Resultaat  
The login was a succes
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
