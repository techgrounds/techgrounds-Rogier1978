# SEC-01 Network Detection
Scan the network with Nmap en Wireshark.

## Key-terms
**Nmap**  
Nmap (“Network Mapper”) is an open source tool for network exploration and security auditing. 

## Opdracht
1. Nmap geïnstalleerd op mijn Linux machine.  (sudo snap install nmap). Linux geeft aan dat nmap 7.93 is geïnstalleerd.

2. Via Nmap command krijg je overzicht van de toevoegingen die je kan gebruiken. Bij scanoptie staat -sT. Deze optie is voor het herkennen van TCP 3way handshakes. Ook mogelijk is de opie -sS. Deze doet alleen de eerste 2 stappen van de handshake. Hiermee kan je zien welke poorten er open staan die TCP handshake gebruiken. 

3. Bij gebruik van het door Techgrounds geleverde IP adres 18.157.179.30 krijg ik de melding "Host seems down". Twijfel of ip adres juist is. Na onderzoek het commando "ip addr" gevonden om ip addres te achterhalen. Later vernomen uit mijn team dat "ifconfig" een betere optie is, maar resultaat is hetzelfde. Het ip adres dat deze commandos aangaven was 10.171.154.111. Een private adress. Mijn conclusie hiervan is dat mijn linux machine een publiek adres heeft van 18.157.179.30 en een privaat adres van 10.171.154.111.  
  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/04_Security/SEC_01%20ip.jpg)  

4. Nu het commando "sudo nmap -sT 10.171.154.111" ingevoerd en als uitkomst kwam dat port 22(SSH) en port 80 (HTTP) open staan.  
  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/04_Security/SEC_01%20nmap.jpg)  


1. In de tweede opdracht eerst de zoom geïdentificeerd in wireshark. Mijn verwachting is dat Zoom veel UDP frames genereert vanwege de video (UDP is snel maar minder veilig dan TCP, een frame in een videoverbinding missen is te overzien, een frame uit bv. een website is een groter probleem). Er verschijnt inderdaad een grote hoeveelheid UDP met hetzelfde IP adres (159.124.3.44). Op de Zoom website staat dit ip adres op een lijst van ip-adressen die Zoom gebruikt.  

2. In mijn wireshark ip adressen geblokkeerd die op dit moment veel gebruikt zijn. Heb mijn Zoom hiervoor afgesloten en filter "ip.addr!=192.168.1.47" ingevoerd. Dit was ip verbinding met mijn telefoon.

3. De wireshark liet data zien in 192.168.1.0/24 domein (mijn prive netwerk), iets in het 170.114.15.96 domein dat werd aangeduid als Application Data in de info kolom. En een aantal adressen in de 200 en hoger range (oa 239.255.255.250). Dit is waarschijnlijk een multicast adres. Dat is een adres dat word gebruikt om een bepaalde groep apparaten te bereiken binnen een netwerk.

4. Na openen browser zie ik HTTP en DNS captures verschijnen. Ook de IP adressen komen uit het WWW.  
  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/04_Security/SEC_01%20wireshark.jpg)


### Gebruikte bronnen
https://nmap.org/  
https://www.howtogeek.com/423709/how-to-see-all-devices-on-your-network-with-nmap-on-linux/  
Network Chuck nmap tuorial: https://www.youtube.com/watch?v=4t4kBkMsDbQ  
https://support.zoom.us/hc/en-us/articles/201362683-Zoom-network-firewall-or-proxy-server-settings  
https://gathering.tweakers.net/forum/list_messages/1519553


### Ervaren problemen
Verkeer filteren in wireshark. Er is veel verkeer actief, kunst om te herkennen wat wat precies is blijt een flinke taak.

### Resultaat

