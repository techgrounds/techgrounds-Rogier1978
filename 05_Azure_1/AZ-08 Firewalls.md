# AZ-08 Firewalls
[Geef een korte beschrijving van het onderwerp]

## Key-terms  
**Azure Firewall Basic**  
Azure Firewall Basic is intended for small and medium size (SMB, Small and Medium-sized Business)  customers to secure their Azure cloud environments. 
It supports Threat Intel alert mode only and fixed scale unit to run the service on two virtual machine backend instances. It is recommended for environments with an estimated throughput of 250 Mbps.


**Azure Firewall Premium**  
Azure Firewall Premium provides advanced capabilities include signature-based IDPS (Intrusion Detection and Prevention System) to allow rapid detection of attacks by looking for specific patterns. These patterns can include byte sequences in network traffic, or known malicious instruction sequences used by malware.  

**East-west and north-south traffic**  
North-south refers to the traffic that flows in and out of a datacenter. This type of traffic is a typical target for attack vectors because it flows over the public internet.  
East-west traffic refers to traffic between or within data centers. Security of east-west traffic can get overlooked even though it makes up a large portion of the workload traffic. It's assumed that the infrastructure firewalls are sufficient to block attacks. Make sure there are proper controls between network resources.

**Azure Firewall Policy**  
Firewall Policy is a top-level resource that contains security and operational settings for Azure Firewall. You can use Firewall Policy to manage rule sets that the Azure Firewall uses to filter traffic. Firewall policy organizes, prioritizes, and processes the rule sets based on a hierarchy with the following components: rule collection groups, rule collections, and rules.  

**Rules Based vs. Policy Based Firewalls**  
Rules based firewall systems use rules to control communication between hosts inside and outside the firewall. Policy-based systems are more flexible than rules based systems. They allow the administrator to define conditions under which general types of communication are permitted, as well as specifying what functions and services will be performed to provide that communication. A policy-based system can dynamically set up permitted communication to random IP addresses. Any system that supports IPsec Authentication Header and Encapsulating Security Payload is considered a policy based system.  

**Azure Firewall vs NSG**  
Azure Firewall is a fully managed network, stateful, security service. It is used to secure the incoming and outgoing traffic of content within it. Azure Network Security Groups is a fully managed offering from Microsoft that helps refine traffic from and to Azure VNet. The Azure NSG consists of certain security rules that users can allow or deny at their convenience.  
In real world cases, enterprises typically use Azure Firewall when they need to filter traffic to a VNet with its threat intelligence-based filtering capabilities. NSGs are typically used to protect traffic flowing in and out of a subnet.

## Opdracht
1. First I created a virtual network with the basic ip settings provided in Azure.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_08%20virtual%20network%20ipadr.png)  
I also opened port 22 (SSH) and port 80 (HTTP).  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_08%20vm%20inbound.png)  

Within this network I also created a VM with an apache2 script from excercise AZ_06:  
-    #!/bin/bash  
-    sudo su  
-    apt update  
-    apt install apache2 -y  
-    ufw allow 'Apache'  
-    systemctl enable apache2  
-    systemctl restart apache2   

This updates and installs Apache2 on the VM. After loading the VM I could enter the VM via the SSH in Linux and I could see the Apache default page on my webbrowser.  

2. Now I installed the NSG (Network Security Group). At the NSG overview page I saw that port 22 and port 80 are opened. This was because I selected this when I created the VM. When I close port 22, I had disabled my SSH connection in Linux.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_08%20vm%20inbound.png)  
For double check I also closed port 80, and this resulted in a connection time after reloading the Ubuntu website on my browser.



### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/firewall/overview  
https://learn.microsoft.com/en-us/azure/well-architected/security/design-network-flow#east-west-and-north-south-traffic  
https://learn.microsoft.com/en-us/azure/firewall/policy-rule-sets  
https://www.techtarget.com/searchcloudcomputing/answer/Compare-Azure-Firewall-vs-NSGs-for-network-security  
https://www.inetdaemon.com/tutorials/information_security/devices/firewalls/rules_based_vs_policy_based_firewalls.shtml  
https://learn.microsoft.com/en-us/training/modules/intro-to-azure-virtual-machines/1-introduction



### Ervaren problemen
Again it takes some time before adjustments take effect.

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
