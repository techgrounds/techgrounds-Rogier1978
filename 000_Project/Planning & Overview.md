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
  - Webserver is for low density tracking with some times peakmoments. I use VM's for this, because they scale better.


Monday 05-06-2023
- Demands & Assumptions list
- Bicep intro

Tuesday - 06-06-2023
- Bicep
- Overview diagram
