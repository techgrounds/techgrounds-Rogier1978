# Azure-6 - Containers
Study containers

## Key-terms
**Containers**  
Containers are becoming a preferred way to package, deploy, and manage cloud applications. Azure Container Instances offers the fastest and simplest way to run a container in Azure, without having to manage any virtual machines and without having to adopt a higher-level service.

Azure Container Instances is a great solution for any scenario that can operate in isolated containers, including simple applications, task automation, and build jobs. For scenarios where you need full container orchestration, including service discovery across multiple containers, automatic scaling, and coordinated application upgrades, you can use Azure Kubernetes Service (AKS).  

Azure offers several services for working with containers:
- **Azure Container Instances (ACI)** ACI allows you to run containers without the need to manage the underlying infrastructure. It is suitable for scenarios where you need to quickly deploy containers and don't require advanced orchestration capabilities.
- **Azure Kubernetes Service (AKS)** AKS is a managed Kubernetes service that simplifies the deployment, scaling, and management of containerized applications. It provides a highly available and scalable platform for running containers using Kubernetes orchestration.
- **Azure Container Registry (ACR)** ACR is a private container registry service in Azure that enables you to store and manage container images. It provides a secure and scalable way to store and distribute your container images to different Azure services and deployments.
- **Azure Container Instances for Web Apps** This service allows you to deploy containers directly to Azure App Service, which is a platform for hosting web applications. It combines the flexibility of containers with the simplicity of App Service deployment.

By leveraging Azure Containers, you can achieve better resource utilization, scalability, and agility in deploying and managing your applications. Containers provide a consistent runtime environment, making it easier to develop, test, and deploy applications across different platforms and environments. Azure's container services help streamline the containerization process and provide a robust infrastructure for running and managing containerized applications in the cloud.  

**Containers vs VMs**  
**Container architecture** A container is an isolated, lightweight silo for running an application on the host operating system. Containers build on top of the host operating system's kernel (which can be thought of as the buried plumbing of the operating system), and contain only apps and some lightweight operating system APIs and services that run in user mode.  
**Virtual machine architecture** In contrast to containers, VMs run a complete operating system–including its own kernel–as shown in this diagram.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/07_Azure_03/AZ_14%20-%2001%20containers%20vs%20VM.png)  


**Docker Hub**  
Docker Hub is the world’s largest repository of container images with an array of content sources.


## Opdracht
### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/container-instances/container-instances-overview  
https://www.docker.com/products/docker-hub/  


### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
