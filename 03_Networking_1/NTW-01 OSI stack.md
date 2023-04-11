# NTW-01 OSI stack
Onderzoek OSI model en TCP/IP model.

## Key-terms
**Application**  
The application layer is used by end-user software such as web browsers and email clients. It provides protocols that allow software to send and receive information and present meaningful data to users.  (HTTP, FTP, POP SMTP)  

**Presentation**  
The presentation layer prepares data for the application layer. It defines how two devices should encode, encrypt, and compress data so it is received correctly on the other end. The presentation layer takes any data transmitted by the application layer and prepares it for transmission over the session layer.

**Session**  
The session layer creates communication channels, called sessions, between devices. It is responsible for opening sessions, ensuring they remain open and functional while data is being transferred, and closing them when communication ends. 

**Transport**  
The transport layer takes data transferred in the session layer and breaks it into “segments” on the transmitting end. It is responsible for reassembling the segments on the receiving end, turning it back into data that can be used by the session layer. The transport layer carries out flow control, sending data at a rate that matches the connection speed of the receiving device, and error control, checking if data was received incorrectly and if not, requesting it again. (TCP/UDP)  

**Network**  
The network layer has two main functions. One is breaking up segments into network packets, and reassembling the packets on the receiving end. The other is routing packets by discovering the best path across a physical network. (IP-addresses, routers)

**Data Link**  
The data link layer establishes and terminates a connection between two physically-connected nodes on a network. (MAC addresses)

**Physical**  
The physical layer is responsible for the physical cable or wireless connection between network nodes.

## Opdracht
### Gebruikte bronnen
https://www.imperva.com/learn/application-security/osi-model/  
https://int0x33.medium.com/day-51-understanding-the-osi-model-f22d5f3df756


### Resultaat
Het OSI (Open Systems Interconnection) model knipt het netwerk in 7 kleinere onderdelen om het gebruik van een netwerk overzichtelijker te maken. TCP/IP layer was in gebruik voor de  OSI model. Het verschil is dat eerst de application, presentation en session layer samen de application layer waren en de dat link en physical layer de network access layer zijn geworden.  

TCP/IP word vaker gebruikt voor specifieke communicatie problemen bij standaard protocollen, terwijl het OSI model wat onafhankelijker werkt en geschikt is voor een breder scala aan network communicatie.
