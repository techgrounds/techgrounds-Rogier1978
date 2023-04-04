# Users and groups

Creëer een nieuwe user en lokaliseer waar de info is opgeslagen.

## Key-terms
**adduser**  
Command dat een nieuwe user aanmaakt.

**userdel**  
Command dat een user verwijdert.

**usermod**  
Het command usermod kan o.a. users aan bepaalde groepen toevoegen.
bv. "usermod -aG sudo [username]" maakt de user lid van de sudo groep.

**cat etc/passwd**  
laat alle linux users zien.

**cat etc/shadow**  
laat encrypted passwords zien van alle gebruikers.

**cat etc/group**  
laat alle groepen in linux zien.

**logout**  
log de nieuwe user uit en de 

## Opdracht
### Gebruikte bronnen
https://www.digitalocean.com/community/tutorials/how-to-create-a-new-sudo-enabled-user-on-ubuntu-22-04-quickstart  
https://devconnected.com/how-to-list-users-and-groups-on-linux/

### Ervaren problemen
-

### Resultaat
Met adduser een account aangemaakt voor test_user hierbij werd tevens een een password aangemaakt (test1234). Met moduser lid gemaakt van de sudo groep. Deze kon de root directory inzien. Via de 3 cat commands in de keyterms kan je informatie vinden van alle gebruikers. Hieronder screenshot van cat etc/group command. De sudo group is highlighted. 
