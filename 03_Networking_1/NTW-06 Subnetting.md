# NTW-06 Subnetting  

Een netwerk maken en hier subnetting op toe passen.

## Key-terms
**LAN**  
Lokaal netwerk zoals thuisnetwerk of klein kantoor netwerk.

**Subnetting**  
Verdelen van een netwerkadres in kleine onderdelen om meerder kleine subnetwerkjes te creëeren. Dit doe je door het adres te delen in een netwerkdeel en een hostdeel. Dit wordt aangegeven met een /n aan het eind van het ip adres waar de n  Dit word Elk netwerk moet een Netwerk-ID en een broadcast adres bevatten. 

**Private (Sub)Network**  
(Sub)Network zonder een adres in de routing table dat verwijst naar het internet (geen internet gateway).

**Public (Sub)Network**  
(Sub)Network dat een adres in de routing table met een verwijzing naar het internet.

Subnets without internet gateway is called private subnet on AWS as they are not connected with the Internet.  
Private and Public subnet can communicate without NAT server with “local” route in your route tables which is default.  
To access the internet from an instance it needs to have a public IP and Internet gateway attached to it.

**NAT**  
Network Address Translation. Onderdeel in het netwerk dat private addresses kan omzetten naar public addresses om zo met het internet te communiceren.  

**NAT Gateway**  
Netwerk onderdeel dat ervoor zorgt dat 

**Subnetmask**  
Mask dat bepaald welk deel van het ip adres het netwerk aangeeft en welk deel de hosts aangeeft. Het netwerkdeel is heet eerste (linker) deel van het adres en bestaat uit 1-en. Het achterste deel (rechter) deel bestaat uit 0-en en is het host deel (bv. 11111111.11111111.11111111.10000000 is 255.255.255.128, of een /25 ip-adres). 
In dit voorbeeld zijn de bits die overeenkomen met de plaats van een 1 in het binair geschreven ip adres het netwerkdeel. De nullen zijn dan het hostdeel het hostdeel. Hieronder een voorbeeld met 192.168.1.0/26  
1 1 1 1 1 1 1 1 . 1 1 1 1 1 1 1 1 . 1 1 1 1 1 1 1 1 . 1 1|0 0 0 0 0 0  = subnetmask  
1 1 0 0 0 0 0 0 . 1 0 1 0 0 1 0 0 . 0 0 0 0 0 0 0 1 . 0 0|0 0 0 0 0 0  = ip adres  
..................................netwerk deel.............................|.......hostdeel.......|  


## Opdracht  
De opdracht is om een netwerk te maken met drie subnets. Het eerste wat ik heb gedaan is uitvinden hoeveel hosts er in een subnet nodig zijn.  
- Het eerste subnet is een private subnet en heeft 15 hosts nodig. Een subnet heeft altijd een netwerk-ID en broadcastadres nodig, dus dat is plus twee. Het totaal komt dan uit op 17 adressen.
- Het tweede subnet is een private subnet met 30 hosts. Hier komt weer bij een network-ID en broadcast adres, maar ook een NAT-gateway. Dat is 3 extra adressen, dus dat komt op 33 adressen.
- Het derde subnet heeft 5 hosts nodig. Wederom komt hier een netwerk-ID en broadcast adres bij, en deze keer ook een internet gateway. Ook deze komt op plus 3 voor een totaal van 8 adressen.

Vervolgens gaan we bepalen hoe groot de netwerken moeten worden en wat voor subnetmask. We beginnen bij de grootste en eindigen bij de kleinste om .
- Het grootste subnet is het tweede subnet. Deze heeft een totaal van 33 adressen nodig. Om een netwerk te maken dat groot genoeg is gaan we vanaf rechts bit gebruiken totdat we genoeg bits hebben om 33 adressen te kunnen gebruiken. Het eerste bit levert ons 2 adressen op het tweede 4 het derde 8 (de formule is 2^n, waarbij n het aantal bits zijn. 2^n-2 zijn het aantal hosts die er beschikbaar zijn bij n bits). Bij 5 bits is dat 32 adressen, bij 6 bits is dat 64. 32 is te weinig dus we gebruiken 6 bits voor 64 hosts. Dit resulteert in een /26
- Het tweede grootste netwerk is het eerste subnet. Deze heeft 17 adressen nodig. Volgens een vergelijkbare beredenering van het vorige netwerk gebruik je een subnet van 32 adressen, dus 5 bits en dat is een /27 netwerk.  
- Het kleinste netwerk is het derde netwerk met 8 adressen. Met drie bits heb je exact 8 adressen , dus volgens de opdracht voldoet dit. Helaas geen mogelijkheid voor toekomstige uitbreiding hier. Dit wordt dus een /29 netwerk.  

Nu de subnets en host bekend zijn kunnen we de ip adressen gaan indelen. Ik heb genomen als netwerk het 10.0.0.0/24 netwerk. Hierin gaan we de netwerken creëeren. 
Het grootste eerst. 
- Dat is het netwerk met de NAT gateway. Deze begint bij 10.0.0.0/29. Het laatste adres in dit netwerk wordt 10.0.0.63/29.
- Het volgende netwerk is het het eerste subnet en heeft 32 adressen. Het eerstvolgende ip adres dat vrij is en heeft een subnet van /27. Di wordt dan 10.0.0.64/27. Het heeft 32 adressen dus het laatste adres en tevens broadcast adres is 10.0.0.95/27.  
- En het laatste netwerk is het kleinste subnet met 8 adressen en een subnet van /29. Het ip adres van dit netwerk wordt dan 10.0.0.96/29 en een broacast ip van 10.0.0.103/29 is het broadcast ip.  


### Gebruikte bronnen
https://cloudcasts.io/course/vpc-basics/private-vs-public-subnets

### Ervaren problemen
Vinden van de correcte images in app.diagrams.net.  

### Resultaat
Hieronder het diagram van het netwerk:
