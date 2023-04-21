# SEC-08 Detection, response and analysis
Onderzoek detection, response en analysis. Wat moet je doen bij een attack?

## Key-terms
**social engineering**  
Social engineering is a manipulation technique that exploits human error to gain private information, access, or valuables. In cybercrime, these “human hacking” scams tend to lure unsuspecting users into exposing data, spreading malware infections, or giving access to restricted systems.  

**IDS (Intrusion detection systems)**  
a device or software application that monitors a network or systems for malicious activity or policy violations.  
The most well-known variants are signature-based detection (recognizing bad patterns, such as malware) and anomaly-based detection (detecting deviations from a model of "good" traffic, which often relies on machine learning).  
IDS differs from a firewall in that a traditional network firewall (distinct from a Next-Generation Firewall) uses a static set of rules to permit or deny network connections. Firewalls can not signal an attack from inside the network.

**IPS (intrusion prevention systems)**  
organizations use IDPS (Intrusion Detection and Preventions Systems) for other purposes, such as identifying problems with security policies, documenting existing threats and deterring individuals from violating security policies. 

**systems hardening**  
Systems hardening is a collection of tools, techniques, and best practices to reduce vulnerability in technology applications, systems, infrastructure, firmware, and other areas.  

**Hack respond strategies**  
Always have an IR (Incident Response) plan to respond to cyberattacks. The gold standard specifies four areas that should be addressed:  
1. **Preparation** plan how to handle and prevent security incidents. Learn from the past.
2. **Detection and analysis** Encompasses everything from monitoring potential attack vectors to looking for signs of an incident, to prioritization
3. **Containment, eradication, and recovery**  Developing a containment strategy, identifying the hosts and systems under attack, mitigating the effects, and having a plan for recovery  
4. **Post-incident activity** Reviewing lessons learned and having a plan for evidence retention.  

Always keep your soft and hardware up to date. Give employees only the necessities to do their jobs to prevent big incidents to happen. Be prepared sooner or later they will happen.

**types of disaster recovery options**  
- **Data Back-up Disaster Recovery Plans** Using the 3-2-1 backup rule (keep 3 copies of your data, keep 2 copies on different backup mediums, keep 1 copy offsite)  
- **Virtual Disaster Recovery Plans**  The virtual disaster recovery plan takes data back-ups a step further. Instead of only backing up your data, your entire IT infrastructure is backed up on cloud servers.  
- **Disaster Recovery as a Service (DRaaS)** DRaaS is somewhat like a virtual disaster recovery plan, but in this case, everything is packaged and taken care of for you. You do not have to separately source backup applications or mitigation solutions, it’s all taken care of by the disaster recovery as a service provider.
- **Hot Site Disaster Recovery** Hot site disaster recovery is a form of DRaaS that includes setting up a second physical facility filled with identical IT infrastructure. 
- **Cold Site Disaster Recovery** The cold site takes a little longer to get up and running with your processes and data but offers an important alternate location to use if something happens to your physical location.

**Recovery Point Objective (RPO)**  
is the maximum acceptable interval during which transactional data is lost from an IT service. i.e. Describes the amount of data that the organisation could afford to lose in the event of a disaster.  

**Recovery Time Objective (RTO)**  
is the targeted duration of time and a service level within which a business process must be restored after a disruption in order to avoid a break in business continuity. i.e. The target amount of time that it should take for systems to be restored.  



## Opdracht  
- The RPO is the data a company losses between an incident and the last backup. In this case the company losses all data from the last backup untill the incident. 


- The RTO is the time of recovery from the incident untill it back online. It will take 8 minutes to power up and update the website. These 8 minutes will be the same as the RTO.
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/04_Security/SEC_08%20rpo_rto.png)  

### Gebruikte bronnen  
https://www.kaspersky.com/resource-center/definitions/what-is-social-engineering  
https://en.wikipedia.org/wiki/Intrusion_detection_system  
https://www.beyondtrust.com/resources/glossary/systems-hardening  
https://en.wikipedia.org/wiki/Backup  
https://www.techtarget.com/searchdisasterrecovery/definition/disaster-recovery  
https://dynamixsolutions.com/types-disaster-recovery-plans/  
https://en.wikipedia.org/wiki/Disaster_recovery#Recovery_Point_Objective
https://web.archive.org/web/20160303224604/http://www.virtualdcs.co.uk/blog/business-continuity-planning-rpo-and-rto.html  
https://www.veritas.com/information-center/data-backup-and-recovery  


### Ervaren problemen
Veel opgezocht belangrijk topic.  
De eerste opdracht is nog steeds een beetje onzeker over wat er gebeurd met backups tijdens de recovery. De website https://www.veritas.com/information-center/data-backup-and-recovery  (Kopje "The Importance of Disaster Recovery (DR)" geeft wel antwoord op de vraag. Als je een RPO van 5 uur wil moet je elke 5 uur backup maken.
