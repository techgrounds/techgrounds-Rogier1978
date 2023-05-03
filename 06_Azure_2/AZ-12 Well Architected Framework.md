# AZ-12 Well Architected Framework  
Study the Well Architected Framework and how to implement these in cloud services.  

**Well-Architected Framework**  
The Azure Well-Architected Framework is a set of guiding tenets that you can use to improve the quality of a workload. The framework consists of five pillars of architectural excellence:  
  
  
  
**Reliability** A reliable workload is both resilient and available. Resiliency is the ability of the system to recover from failures and continue to function. The goal of resiliency is to return the application to a fully functioning state after a failure occurs. Availability is whether your users can access your workload when they need to.  
You can accomplish this by taking care of the following:
- Design for bussines requirements. Mission-critical apps with a high SLA needs an environment with other a high SLA apps to function properly. (A chain is as good as it's weakest link)  
- Design for failure. When designing a cloud environment take into account that things will go wrong. Build in redundancy to avoid big continuity issues.
- Observe application health. Monitor the apps in the cloud environment for health issues. So you can predict and avoid future problems.
- Drive automation. The biggest application downtime errors are human errors. Automate various functions (like monitoring, testing, updating) to minimize these human errors.  
- Design for self-healing. Create a systems ability to deal with failures automatically. Handling failures happens through pre-defined remediation protocols.  
- Design for scale out. This is the ability of the system to adapt to demand issues. By horizontal scaling (adding (or removing) resources) you can automatically react to increased data traffic.  


**Security** This one is very obvious these days. Think about security throughout the entire lifecycle of an application, from design and implementation to deployment and operations. Consider the following broad security areas:  
- **Identity Management** Be aware of users accessing your data and services. Consider using Azure Active Directory (Azure AD) to authenticate and authorize users. Azure AD is a fully managed identity and access management service.  
- **Protect your infrastructure** Control access to the Azure resources that you deploy. Use Azure role-based access control (Azure RBAC role) to grant users within your organization the correct permissions to Azure resources. Grant access by assigning Azure roles to users or groups at a certain scope. The scope can be a subscription, resource group or single resource.
- **Application security** In general, the security best practices for application development still apply in the cloud. Best practices include encrypt data in-transit with the latest supported TLS versions, protect against CSRF and XSS attacks and Prevent SQL injection attacks.
Cloud applications often use managed services that have access keys. Never check these keys into source control. Consider storing application secrets in Azure Key Vault.  
- **Data sovereignty and encryption** Make sure your data rremains in the correct geopolitical zone when using Azure data services. Use Key Vault to safeguard cryptographic keys and secrets. By using Key Vault, you can encrypt keys and secrets by using keys that are protected by hardware security modules (HSMs). Many Azure storage and DB services support data encryption at rest.  
  
  
**Cost optimization** When designing a cloud system, think about added services and their values. Apply the principles of Build-Measure-Learn to accelerate your time to market while avoiding capital-intensive solutions (balancing business goals with budget justification). The build-measure-learn feedback loop is a description of the process for building empathy with your customers, measuring their reactions, and learning what adjustments to make that improve customer interactions.  
- **Capture cost requirements** Start planning the need and requirements of the cloud services. Make sure the needs of the stakeholders are addressed. For strong alignment with business goals, the stakeholders must define the needs not the vendors.  
- **Cost of resources in Azure regions** Cost of Azure services can vary between different regions.  
- **Governance** Understand how governance can assist with cost management.  
- **Estimate the initial cost** It's difficult to know your costs before deploying a workload to the cloud. If you compare the cost of on-premises compared to cloud it may be inaccurate. The cost of cooling, electricity, IT and facilities labor, security, and disaster recovery etc. are often not atken into account.  
- **PaaS** Look for areas in the architecture where it might be natural to incorporate platform-as-a-service (PaaS) options. These options include caching, queues, and data storage. PaaS reduces time and cost of managing servers, storage, networking, and other application infrastructure.  
- **Consumption** Considering cost according to high workloads may give an inaccurate pricing. Because of auto scaling for example the pricing may differ between various workloads.  
- **Provision cloud resources** Deployment of workload cloud resources can optimize cost.  
- **Monitor cost** Azure cost managment has an alert function to alert when a cost threshold has been reached.  
- **Optimize cost** Use the right resources and sizes for efficiency.  
- **Tradeoffs for costs** As you design the workload, consider tradeoffs between cost optimization and other aspects of the design, such as security, scalability, resilience, and operability.  
  
  
**Operational excellence** Operational excellence covers the operations and processes that keep an application running in production. Deployments must be reliable and predictable. Automate deployments to reduce the chance of human error.  
- **Ambassador** Create helper services that send network requests on behalf of a consumer service or application.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/06_Azure-2/AZ_12%2001%20ambassador.png)  
- **Anti-corruption Layer pattern** Use an adpater layer to seperate models from other models. Use this to prevent corruption from for example legacy models that needs to de integrated by other models.  
- **External Configuration Store** Move configuration data externally and away from application deployments (e.g. cloud-based storage service or dedicated configuration service). This provides easier management if adjustments needs to be made.
- **Gateway Aggregation pattern** Use a gateway to aggregate multiple individual requests into a single request. An application that needs many services for a task may need a gateway to combine the services to create a single task for the app.  
- **Gateway Offloading** Offload shared or specialized service functionality to a gateway proxy.  
- **Gateway Routing** Route requests to multiple services using a single endpoint. If a user needs multiple services it can use one gateway.   
- **Health Endpoint Monitoring** Implement functional checks in an application that external tools can access through exposed endpoints at regular intervals.  
- **Sidecar** Deploy components of an application into a separate process or container to provide isolation and encapsulation.  
- **Strangler Fig** Incrementally migrate a legacy system by gradually replacing specific pieces of functionality with new applications and services.  
  
  
**Performance efficiency** Performance efficiency is the ability of your workload to scale to meet the demands placed on it by users in an efficient manner. The main ways to achieve performance efficiency include using scaling appropriately and implementing PaaS offerings that have scaling built in.  
- **Cache-Aside** Load data on demand into a cache from a data store.
- **Choreography** Have each component of the system participate in the decision-making process about the workflow. If you expect that for example services need updating frequently, you want those services spread over different resources so you can make adjustments without big disruptions in the services.  
- **CQRS (Command and Query Responsibility Segregation)** A model that seperates reading and updating processes. This causes the workflow to improve because the resources for these processes are divided over different models (read and write mdoel).  
-  **Event Sourcing pattern** Instead of storing just the current state of the data in a domain, use an append-only store to record the full series of actions taken on that data. So you only store a chain of changes not only the final result.  
-  **Deployment Stamps** Deploy multiple independent copies of application components, including data stores. You link a set of users to a set of multiple resources with identical tasks.  
-  **Geodes** Deploy backend services into a set of geographical nodes, each of which can service any client request in any region.
- **Index Table** Creat an indexes in data stores the are frequently referenced.  
- **Materialized View** Generate prepopulated views over the data in one or more data stores when the data isn't ideally formatted for required query operations.  
- **Priority Queue** Prioritize requests sent to services so that requests with a higher priority are received and processed more quickly than those with a lower priority.  
- **Queue-Based Load Leveling** Use a queue that acts as a buffer between a task and a service that it invokes in order to smooth intermittent heavy loads.  
- **Sharding** Divide a data store into a set of horizontal partitions or shards.  
- **Static Content Hosting** Deploy static content to a cloud-based storage service that can deliver them directly to the client.  
- **Throttling** Control the consumption of resources used by an instance of an application, an individual tenant, or an entire service. So limit the users access after a certain threshold.


### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/well-architected/)](https://learn.microsoft.com/en-us/azure/well-architected/
