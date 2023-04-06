# Bash scripting
Creëer een scripts directory en maak hier een PATH variable voor aan. Maak daarna drie scripts.

## Key-terms
**echo $PATH**  
Adding new directories to your user or global $PATH variable is pretty simple. This allows you to execute commands and scripts stored on nonstandard locations without needing to type the full path to the executable.

**export PATH="directory:$PATH"**  
Voegt directories toe aan de PATH variable. Voeg deze regel toe aan .profile bestand om deze permanent te maken.

**.sh -bestand**
Script bestand.

**sudo password "username"**  
past wachtwoord aan van de user "username".

**(random%x)**  
Selecteert random getal onder x.

**$**  
Plaats $ voor een variabele om de waarde van de variabele weer te geven.

## Opdracht
### Gebruikte bronnen
https://phoenixnap.com/kb/linux-add-to-path  
https://www.baeldung.com/linux/path-variable  
https://www.javatpoint.com/steps-to-write-and-execute-a-shell-script  
https://blog.eduonix.com/shell-scripting/generating-random-numbers-in-linux-shell-scripting/  
https://www.thegeekstuff.com/2010/06/bash-if-statement-examples/


### Ervaren problemen
Eerste keer sinds lange tijd script geschreven. Veel trial and error. Gebruik van $, en haken vs aanhalingstekens.

### Resultaat
**Exercise 1**  
Met MKDIR commando een "scripts" directory aangemaakt. Met "echo $PATH" kan je zien welke directories in de directory PATH staan. Met het commando "export PATH="/~/scripts:$PATH" Heb ik de scripts dierctory daaraan toegevoegd en weer gecontrolleerd met "echo $PATH".
I Eerste script is een regel. Echo met de text "Nieuwe regel" gevolgd door >> met de bestandsnaam appline.txt. Hierdoor word elke keer als het bestand appline.sh wordt uitgevoerd een nieuwe regel aa het textbestand appline.txt toegevoegd. De tweede regel heb ik toegevoegd om een feedback te krijgen wat het bestand heeft gedaan. In het bestand appline.txt is na elke "run" inderdaad een nieuwe regel toegevoegd.  
II Heb een scipt aangemaakt met de naam httpd.sh. Onder elkaar de commandos geplaatst voor installatie, upgrade enabling en status. Voor de installatie van de Apache2 software heb ik sudo commands gebruikt. Ook een password ingesteld omdat de installatie daarom vroeg. Hieronder het resultaat van het script.  

**Exercise 2**  
Eerst random waarde aan R toegevoegd mvia R=$((random%10)). Vervolgens met commando echo $R >> ~/scripts/randomizer.txt het getal aan het txt bestand toegevoegd.  


**Exercise 3**  
Randomizer gebruitke asl is exercise 2. Daarna met if..then..else..fi command voorwaardes gesteld voor wat te doen. Het script en resultaat staan hieronder afgebeeld.


