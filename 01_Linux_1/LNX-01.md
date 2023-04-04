# Setting up
Maak met een verbinding met een VM via SSH.

## Key-terms
**SSH**  
SSH is an encrypted connection protocol that allows secure sign-ins over unsecured connections. 

**Public key**  
The public key is placed on your Linux VM when you create the VM.

**Private key**  
The private key remains on your local system. Protect this private key.

**Powershell**  
PowerShell is een platformoverschrijdende oplossing voor taakautomatisering, samengesteld uit een opdrachtregelshell, een scripttaal en een framework voor configuratiebeheer. 

**SSH command**
Als je in de powersell SSH invoert gevolgd door enter krijg je een overzicht van de mogelijkheden van het command.

## Opdracht
In de powershell het volgende command ingevoerd:  

    ssh -p 52207 -i desktop/nest-ro-van-vliet.pem rogier@18.157.179.30  

De poortnummers en server info staan in de Techgrounds drive.

Daarna met het command whoami is mijn gebruikersnaam bevestigd (zie screenshot bij resultaat)

### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows  
https://learn.microsoft.com/nl-nl/powershell/scripting/overview?view=powershell-7.3

### Ervaren problemen
Vind bestandslocaties lastig.

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
