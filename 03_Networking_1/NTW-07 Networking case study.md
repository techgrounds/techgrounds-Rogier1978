# Networking case study
Maak en onderbouw een bedrijfsnetwerk.

## Key-terms  
  
**AD Server**  
AD = Active Directoy. Active Directory stores information about objects on the network and makes this information easy for administrators and users to find and use. Active Directory uses a structured data store as the basis for a logical, hierarchical organization of directory information.

**Firewall**  
Een firewall is een netwerk security apparaat dat inkomend en uitgaand netwerkverkeer bewaakt en bepaalt welk verkeer wordt toegestaan of geblokkeerd op basis van een gedefinieerde set security regels.  

**DMZ**  
DeMilitarized Zone. A DMZ or demilitarized zone is a perimeter network that protects and adds an extra layer of security to an organization's internal local-area network from untrusted traffic.

**ProxyServer**  
Een proxy (of proxyserver) is een computer die tussen een gebruiker en het internet in staat. De gebruiker van de proxy stuurt al zijn of haar internetverkeer naar de proxyserver. De server stuurt die data vervolgens door naar de uiteindelijke bestemming op het internet. Een proxy server verbergt de identiteit en locatie van de gebruiker (gedeeltelijk). 


## Opdracht
1. Eerst een office gemaakt met 5 PC, printer en de AD server. Dit alles aangesloten op een  switch.
2. Daarna een tweede netwerk gemaakt met webserver en database. Beide gelinkt aan een switch.  
3. Daarna de twee netwerken aangeslloten op een firewall en deze beide aangesloten op een router. Vraag: Is dit veilig genoeg. Te makkelijk toegang tot webserver én database beide.  

### Gebruikte bronnen   
https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc736627(v=ws.10)  
https://www.cisco.com/c/nl_nl/products/security/firewalls/what-is-a-firewall.html   
https://www.makeuseof.com/what-is-a-dmz-and-how-do-you-configure-one-on-your-network/  
https://www.vpngids.nl/privacy/anoniem-browsen/wat-is-een-proxy-server/  
https://www.quora.com/How-does-a-web-server-communicate-with-a-database-1


### Ervaren problemen
Lastig te bepalen hoe je de dataserver veilig in het systeem kan implementeren. Moet goede toegang zijn tot webserver, maar ik denk ook dat de office toegang moet krijgen voor als er onderhoud o.i.d. nodig is.

### Resultaat
Heb twee netwerken gecreëerd. Één office netwerk en een webserver netwerk (zie opdracht).  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/03_Networking/NTW-07%20-%20diagram.jpg)
