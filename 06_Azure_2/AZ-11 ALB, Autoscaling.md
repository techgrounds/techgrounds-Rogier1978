# AZ-11 ALB, Autoscaling
[Geef een korte beschrijving van het onderwerp]

## Key-terms  
**Autoscaling**  
Autoscaling is the process of dynamically allocating resources to match performance requirements. As the volume of work grows, an application may need additional resources to maintain the desired performance levels and satisfy service-level agreements (SLAs). As demand slackens and the additional resources are no longer needed, they can be de-allocated to minimize costs.  
**Vertical scaling**  
also called scaling up and down, means changing the capacity of a resource. For example, you could move an application to a larger VM size. Vertical scaling often requires making the system temporarily unavailable while it is being redeployed. Therefore, it's less common to automate vertical scaling.  
**Horizontal scaling**  
also called scaling out and in, means adding or removing instances of a resource. The application continues running without interruption as new resources are provisioned. When the provisioning process is complete, the solution is deployed on these additional resources. If demand drops, the additional resources can be shut down cleanly and deallocated.  

**Orchestration modes**  
Traditionally, scale sets allow you to create virtual machines using a VM configuration model provided at the time of scale set creation, and the scale set can only manage virtual machines that are implicitly created based on the configuration model.  
Scale set orchestration modes allow you to have greater control over how virtual machine instances are managed by the scale set.
- **Uniform orchestration** Virtual Machine Scale Sets with Uniform orchestration use a virtual machine profile or template to scale up to desired capacity. While there is some ability to manage or customize individual virtual machine instances, Uniform uses identical VM instances.  
- **Flexible orchestration** Achieve high availability at scale with identical or multiple virtual machine types. With Flexible orchestration, Azure provides a unified experience across the Azure VM ecosystem. Flexible orchestration offers high availability guarantees (up to 1000 VMs) by spreading VMs across fault domains in a region or within an Availability Zone. This enables you to scale out your application while maintaining fault domain isolation that is essential to run quorum-based or stateful workloads.  
**Azure Fault Domain** - Fault domains are a collection of VMs that share a common power source and network switch. By default, Azure will assign three fault domains and five update domains (which can be increased to a maximum of 20) to the Availability Set. 

**Autoscaling components**  
- Instrumentation and monitoring systems at the application, service, and infrastructure levels. These systems capture key metrics, such as response times, queue lengths, CPU utilization, and memory usage.  
- Decision-making logic that evaluates these metrics against predefined thresholds or schedules, and decides whether to scale.  
- Components that scale the system.  
- Testing, monitoring, and tuning of the autoscaling strategy to ensure that it functions as expected.  

**Azure Load Balancer**  
Load balancing refers to evenly distributing load (incoming network traffic) across a group of backend resources or servers.  
Azure Load Balancer operates at layer 4 of the Open Systems Interconnection (OSI) model. It's the single point of contact for clients. Load balancer distributes inbound flows that arrive at the load balancer's front end to backend pool instances. These flows are according to configured load-balancing rules and health probes. The backend pool instances can be Azure Virtual Machines or instances in a Virtual Machine Scale Set.
**Public load balancers** can provide outbound connections for virtual machines (VMs) inside your virtual network. These connections are accomplished by translating their private IP addresses to public IP addresses. Public Load Balancers are used to load balance internet traffic to your VMs.  
**Internal (or private) load balancers** is used where private IPs are needed at the frontend only. Internal load balancers are used to load balance traffic inside a virtual network. A load balancer frontend can be accessed from an on-premises network in a hybrid scenario.  

Load balancer supports both inbound and outbound scenarios. Load balancer provides low latency and high throughput, and scales up to millions of flows for all TCP and UDP applications.  


**Virtual Machine Scale Sets**  
Azure Virtual Machine Scale Sets let you create and manage a group of load balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule.  



## Opdracht  
1. Start with creating a VMSS with the suplied information. On the network page I created a new NIC:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_11%2001%20VMSS%20network%20interface.png)  

And I enabled the load balancer:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_11%2002%20VMSS%20lb.png)  

On the scaling page I set the scaling options. Here we have a minimum of 1 and a maximum of 4 VM instances. With a 75% CPU threshold measured every 5 minutes it adds a VM. When the threshold drops below 30% it will remove a VM.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_11%2003%20VMSS%20scaling%20settings.png)  

After creation these are the resources in the Resource group:  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_11%2004%20VMSS%20resources%20overview.png)  


2. Under the VMSS-ip resource you can find the assigned IP address of the loadbalancer (left). This is 51.142.113.20. You can reach the Apache Default page via this IP address (right):  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_11%2005%20apache%20default.png)  

This means that the endpoint of the loadbalancer reaches the VM at the backend.  

3. Now we use a load-test to increase the CPU load on the VMSS over 75%. We do this in Linux with the stress command. For this we log in on one of the VM of this scaler. Via the connect option in the settings pane we can find the ip address.  

We use the command "sudo stress --cpu 80 --timeout 360" to give the CPU a workload of 80% for 360 seconds.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_11%2008%20linux%20stress%20test.png)  

You can see the CPU load in graph form in the VMSS resources under "monitoring". Here we see the graph and it is at 100% average CPU load. This is during the load test.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_11%2007%20cpu%20graph.png)  

During the load test the CPU took a load of over 75% for over 5 minutes, so it had created additional VM's to handle the extra use. Here we see the resource panel and the VMSS has now 4 VM's, that is the maximum according to the settings I made in the start.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_11%2009%20VMSS%20added%20vms.png)  


### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes  
https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview  
https://learn.microsoft.com/en-us/azure/architecture/best-practices/auto-scaling?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=af218d73724044eaa4716a6da800ca96  
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-create-vmss  
https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-standard-virtual-machine-scale-sets  
https://www.tecmint.com/linux-cpu-load-stress-test-with-stress-ng-tool/  


### Ervaren problemen
Took some time to figure out were to open the ports for the virtual machines. The Azure load tester is not very efficient and expensive to use. I finally used Linux with the "stress" command.  

### Resultaat
On the final screen we can see the VMSS worked because it had added extra VM's.
