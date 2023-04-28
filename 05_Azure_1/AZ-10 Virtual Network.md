# AZ-10 Virtual Network
Create VNets with specific requirements, and add a VM in it that has a website installed on it.  

## Key-terms
**Azure Virtual Network**  
Azure Virtual Network (VNet) is the fundamental building block for your private network in Azure. VNet enables many types of Azure resources, such as Azure Virtual Machines (VM), to securely communicate with each other, the internet, and on-premises networks. VNet is similar to a traditional network that you'd operate in your own data center, but brings with it additional benefits of Azure's infrastructure such as scale, availability, and isolation.  

**Point-to-Site VPN**  
A Point-to-Site (P2S) VPN gateway connection lets you create a secure connection to your virtual network from an individual client computer. A P2S connection is established by starting it from the client computer. This solution is useful for telecommuters who want to connect to Azure VNets from a remote location, such as from home or a conference.  

**Site-to-Site VPN**  
A Site-to-Site VPN gateway connection is used to connect your on-premises network to an Azure virtual network over an IPsec/IKE (IKEv1 or IKEv2) VPN tunnel. This type of connection requires a VPN device located on-premises that has an externally facing public IP address assigned to it.  

**Azure ExpressRoute**  
ExpressRoute lets you extend your on-premises networks into the Microsoft cloud over a private connection with the help of a connectivity provider. With ExpressRoute, you can establish connections to Microsoft cloud services, such as Microsoft Azure and Microsoft 365.

**Azure NAT Gateway**  
Azure NAT Gateway is a fully managed and highly resilient Network Address Translation (NAT) service. Azure NAT Gateway simplifies outbound Internet connectivity for virtual networks. When configured on a subnet, all outbound connectivity uses the NAT gateway's static public IP addresses.

## Opdracht  
1. I started with creating a VNet by going to Virtual Networks in the Azure services menu and select create and used the info provided with the excercise.  
![]()  

2. Next I have built a VM according to the excercise. And I placed it in subnet 2.  
![]()  

3. Now we need a route to the internet from subgroup. At first I thought I needed a NAT gateway to access the internet. Or at least a tool to route the data. However a lot of these routes have already been made in the VM network interface. In the page "Effective routes", in the help? section of VM's NIC, you can find a list of network routes that are active in the Network interface of the VM. This interface is automatically created with the VM.
Here a partial overview of the routes.
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_10%20effective%20routes.png)  
Important here is the 0.0.0.0/0 route to the internet. This is the default route. Everything not matching in the routing table will send to this next hop, in this case the internet.  

4. We can adjust routes also via the "Route table" service. I created one to block internet traffic to subnet 1. I created a route with the name "nointernet" with address 0.0.0.0/0 and a next hop type of "none". This will block internet traffic.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_10%20route%20nointernet.png)  
If I place the Route tables on the subnet-1 subnet this will block the internet. 






### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview  
https://learn.microsoft.com/en-us/azure/virtual-network/nat-gateway/nat-overview  
https://learn.microsoft.com/en-us/azure/vpn-gateway/point-to-site-about
https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-site-to-site-classic-portal  
https://learn.microsoft.com/en-us/azure/expressroute/expressroute-introduction



### Ervaren problemen
I expected to create a route instead of blocking one. It was hard to find the effective routes table in the network interface. 

### Resultaat
I have also tried to place it on subnet-2 and this caused a failure by the loading of the webpage. Also placing the VM in subnet 1 when the route table was active there, also caused an error in my webbrowser.
