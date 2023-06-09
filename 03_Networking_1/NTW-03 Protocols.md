# NTW-03 Protocols
Onderzoek de verschillende protocollen in verschillende layers.

## Key-terms
**PROTOCOLS**  
Network protocols are a set of rules outlining how connected devices communicate across a network to exchange information easily and safely. Protocols serve as a common language for devices to enable communication irrespective of differences in software, hardware, or internal processes.  

**10BASE-T**  
Layer 1 protocol: 10 Mbit verbinding

**ARP**  
Layer 2: address resolution protocol. Protocol om MAC adressen te ontdekken in een netwerk via een IP adres.

**OSPF**  
Layer 3: Open Shortest Path First. Protocol voor routers om routes naar netwerken te ontdekken.

**TCP**  
Layer 4: Transmission Control Protocol. Main protocol in de IP suite. Hiermee worden gegevens overgedragen op het internet via netwerkverbindingen, maar ook op computernetwerken. TCP kan gegevens in een datastroom versturen, wat betekent dat deze gegevens gegarandeerd aankomen op hun bestemming.

**SMB**  
Layer 5: Server Message Block. Communicatie protocol voor gedeelde toegang naar files en printers over een netwerk.

**SSL**  
Layer 6: Secure Socket Tunneling. Een protocol gebruikt in VPN. Kan een point-to-point verbinding maken via een HTTPS protocol.

**HTTP**  
Layer 7: Hypertext Transfer Protocol. Protocol om samenwerkende hypermedia informatie systemen te laten communiceren.



## Opdracht
### Gebruikte bronnen
https://en.wikipedia.org/wiki/List_of_network_protocols_(OSI_model)  

Who decides Internet protocols?  
The Internet Engineering Task Force (IETF) and the Internet Society that oversees the IETF oversee the Internet protocols, and the Internet Consortium for Assigned Names and Numbers (ICANN) controls the DNS hierarchy and the allocation of IP addresses.  
https://bjc.edc.org/June2017/bjc-r/cur/programming/4-internet/3-communication-protocols/4-who-is-in-charge.html?topic=nyc_bjc%2F4-internet.topic&course=bjc4nyc.html&novideo&noassignment  

Om een internet protocol te maken moet je een RFC (Request For Comments) opstellen. Dit is een document dat het protocol omschrijft en wat de vereisten zijn. Als dit goed in elkaar zit kan je protocol indienen bij de IETF.

  
  

Hieronder een voorbeeld van een TCP protocol in wireshark. De eerste is een farme van mijn computer naar ip-adres 34.213.147.188. Bij de info kolom op het eind staat SYNC. Dit staat voor SYNChronise en betekent dat mijn computer contact wil met 34.213.147.188. Dit IP adres reageert en dit is de tweede regel. Deze zegt SYN,ACK. Dit is een vraag voor synchronisatie van mijn PC en een ACKnowledgement van mijn request tot sysnchronisatie. Tot slot reageert mijn computer met een ACK packlet op de derde regel en bevestigt zijn acknowledgement, en de verbinding is tot stand gekomen.
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/NTW-03%20-%20TCP.png)  
In de screenshot hieronder zie je een onderdeel van frame 35. Dit is het eerste frame wat is verstuurd (het SYNC request). Hier staat een source poort (14402) dit port nummer is willekeurig toegewezen aan mijn PC. De destination port is 443. Dit berekent dat dit verzoek is om een HTTPS verbinding. Voor de verdere communicatie worden deze port nummers icm IP adres gebruikt tot de verbinding gesloten wordt.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/NTW-03%20-%20frame.png)  
(Bron CCNA certified guide)

### Ervaren problemen

### Resultaat

