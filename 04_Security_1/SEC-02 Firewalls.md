# SEC-02 Firewalls
Bestudeer firewalls, installeer webserver en firewall op linux machine en controleer of het werkt.

## Key-terms
**stateful firewall**  
A stateful firewall is a firewall that monitors the full state of active network connections. They check data in the context of a network. CPU heavy.

**stateless firewall**  
Stateless firewalls are designed to protect networks based on static information. They us packetfiltering rules were individual packets have to apply to. Not CPU heavy.

**hardware firewall**  
Firewall in a metal case. You have to connect this in a network with cables.  

**software firewall**  
Firewall as a computerprogram for example. You can install the software to add firewall functionality to a computer.  

**webserver**  
A web server is software and hardware that uses HTTP (Hypertext Transfer Protocol) and other protocols to respond to client requests made over the World Wide Web.  

**RHEL**  
Red Hat Enterprise Linux is een Linuxdistributie voor professioneel gebruik. 


## Opdracht  
1. Eerst moest ik even mijn geheugen opfrissen, maar na een half uurtje wist ik weer aardig de weg. Met commando "sudo systemctl status apache2" kom ik de status van apache2 controleren. Deze had ik al geïnstalleerd in week 1. Het command liet zien dat deze nog actief was.  

2. In mijn webbrowser het publieke ip-adres ingevoerde gevolgd door mijn eigen poortnummer. "18.157.179.30:58007". Dit laat mijn Apache 2 Ubuntu default page zien.  

3. UFW geïnstalleer met "sudo apt-get install ufw" 

4. Met command "ufw allow #" en "ufw deny #", waarbij # poortnummer is, kan je poorten openen en sluiten. Ingevoerd "ufw allow 22" om SSH poort te openen en "ufw deny 80" om HTTP poort te sluiten.

5. "ufw enable" zet de firewall aan. "ufw status" laat overzicht van poorten zien die geopend of gesloten zijn. In mijn webbrowser is de default pagina niet meer te zien na sluiten van poort 80.


### Gebruikte bronnen  
https://www.n-able.com/blog/stateful-vs-stateless-firewall-differences  
https://serverfault.com/questions/324065/how-to-open-port-on-apache-server
https://www.configserverfirewall.com/ufw-ubuntu-firewall/ufw-block-ports/  

### Ervaren problemen


### Resultaat

