# SEC-06 Public Key Infrastructure
Maak een certificaat in Linux. Bestudeer een aantal certificaten.  

## Key-terms
**public key infrastructure (PKI)**  
is a set of roles, policies, hardware, software and procedures needed to create, manage, distribute, use, store and revoke digital certificates and manage public-key encryption.
Deze houdt de connectie bij van public keys met mensen en/of organisaties.  

You have public key and private key to encrypt dat for e.g. a website. This public key is distributed via a certificate. This certificate is released by a certificate authority (CA). This CA is a trusted organisation or Trusted Third Party (TTP). CA has a private key that is trusted, that's why the distributed certificate is trusted.  

**SSL (Secure Socket Layer)**  
SSL is een afkorting voor Secure Socket Layer. SSL en de opvolger TLS (Transport Layer Security) zijn protocollen voor het creëren van een versleutelde verbinding tussen een webserver en een internetbrowser. 

**Hashing Algorithm**  
A hashing algorithm is a mathematical function that garbles data and makes it unreadable.
Hashing algorithms are one-way programs, so the text can’t be unscrambled and decoded by anyone else. And that’s the point. Hashing protects data at rest, so even if someone gains access to your server, the items stored there remain unreadable. 
Hashing can also help you prove that data isn’t adjusted or altered after the author is finished with it. And some people use hashing to help them make sense of reams of data. 

**certificate authority**  
Een instantie dat digitale certificaten opslaat, tekent en uitgeeft.  

**X.509**  
In cryptography, X.509 is an International Telecommunication Union (ITU) standard defining the format of public key certificates. An X.509 certificate binds an identity to a public key using a digital signature. A certificate contains an identity (a hostname, or an organization, or an individual) and a public key (RSA, DSA, ECDSA, ed25519, etc.), and is either signed by a certificate authority or is self-signed.  


## Opdracht  
1. Na wat studie ben ik gaan opzoeke hoe een certificaat aan te maken in Linux. De eerste stap is programma te hebben voor certificaten. Daarvoor OpenSSL geïnstalleer met "sudo apt update" en "sudo apt install openssl -y". Na het commando "openssl version" kreeg ik te zien dat OpenSSL 1.1.1f geïnstalleerd is.  

2. Ben bezig geweest onder SSH certificaten dit was niet de bedoeling. Moet SSL zijn.

3. Nu commando opgezocht dat met openssl een certificaat aanmaakt volgens x509 standaard. Heb het commando "openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout rogier_sec06.key -out rogier_sec06.crt" gevonden op website sslcertificaten.nl. Na dit command zijn er twee bestanden bijgeschreven. rogier_sec_06.key en rogier_sec06.crt. Dit is een private key en een self-signed certificate. Deze bestanden hadden moeten staan in de map /etc/ssl/certs. Heb commando nog een keer uitgevoerd in deze map. En de eerdere bestanden verwijderd, Hieronder resultaat.  

5. ![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/04_Security/SEC_06%20openssl%20crt.jpg)  


Gechecked of het certificate gesigned was. Hieronder het certificate. Je ziet dat subject en issuer hetzelfde zijn. Dit laat zien dat het certificate self-signed is.  

![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/04_Security/SEC_06%20cert%20details.jpg)  

4. Sites hebben vaak verschillende certificates. Hieronder zie je de certificate paths van abnamro.nl. De paths beginnen allemaal bij een CA. Dat is een Certificate Authority. Daaronder een overzicht van vertrouwde certificaten in Firefox. Je ziet dat de CA van ABN-Amro in de lijst van certificaten staat vermeld. Dit wil zeggen dat mijn browser dit certificate certrouwd, maar ook certificates die door dit certificate zijn aangeboden.  

![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/04_Security/SEC_06%20abnamro.jpg)  

En hieronder een aantal vertrouwde certificaten in mijn Firefox browser. Zie de Entrust certificates hierboven en hieronder:  

![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/04_Security/SEC_06%20firefox%20cert.jpg)  

5. In de afbeelding hierboven is een onderdeel van de lijst te zien van mijn browser waar de trusted certificates gemeld staan. (Firefox > Settings > Privacy & security > Certificates)  

Met het commando "gawk -vc="openssl x509 -noout -subject" '{print|c}/^-----END/{close(c)}'  <ca-certificates.crt" krijg je een lijst met namen van de certificates in linux ide staan vermeld in ca-certificates.crt file. Hieronder een fragment:







### Gebruikte bronnen
https://en.wikipedia.org/wiki/Public_key_infrastructure
https://www.okta.com/identity-101/hashing-algorithms/  
https://itslinuxfoss.com/install-openssl-ubuntu-22-04/  
https://www.sslcertificaten.nl/support/OpenSSL/OpenSSL_-_Aanmaken_self-signed_certificaat  
https://security.stackexchange.com/questions/93162/how-to-know-if-certificate-is-self-signed

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
