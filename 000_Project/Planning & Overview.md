# PLANNING

Week 1 - 
  - Study BICEPS & IAC, ENCRYPTION, BOOTSTRAP-SCRIPTS.
  - Demands / Assumptions
  - Overview of services with costs
  - Cost overview
  - Basic script ready with all modules
  - Deployment scripts documentation  
    https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-script-template
  - 

Week 2 - 
  - IP-address planning (10.10.10.0/24 and 10.20.20.0/24)


# DEMANDS
  - Every VM disk is encrypted
  - All data traffic is encrypted
  - Daily backups (stored for 7 days)
  - Each subnet include firewall
  - Webserver installed automatically with public ip.
  - Admin/Management server from trusted locations (Conditional Access, Azure AD Premium P2)
  - Webserver connection via SSH/RDP only via Admin server
  - Storage location for BOOTSTRAP-SCRIPTS, accessible via Admin/Management server.
  - Webserver is scalable (Q&A 6-6-2023)
  
# ASSUMPTIONS
  - DDOS protection for Web server
  - Everything is Billed to one client
  - Use cheapest available options possible, according to demands (it's learning project)
  - No private network available
  - Azure AD network monitoring
  - MFA for Admin/Management

# USER STORIES  
## Web-server  
  - Webserver is for low density tracking with some times peakmoments. I use VM's for this, because they scale           better. They are, however, a bit more costly and require some maintenance.
  - https://dzone.com/articles/microsoft-azure-app-service-cloud-services-or-vms
  - Azure SQL database will be added to store data.
  - https://www.sqlshack.com/azure-sql-database-vs-sql-server-on-azure-virtual-machines/


## Management-server  
  - https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/azure-server-management/
  - public ip address
  - Conditional Access (use Azure AD)
    https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/plan-conditional-access

Monday 05-06-2023
- Demands & Assumptions list
- Bicep intro

Tuesday - 06-06-2023
- Bicep
- Overview diagram
