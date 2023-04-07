# Cron jobs
Maak een script en gebruik cron jobs om het script regelmatig uit te voeren.

## Key-terms
**Cronjob**  
Een cronjob is een Unix-commando dat automatisch op gezette tijden wordt uitgevoerd met behuilp van de systeemdienst cron. 

**Crontab**  
Command om crontabs opdrachten ui te voeren(-e is editor, -l is lijst van actieve crontabs)

**Date**  
Laat datum zien.

## Opdracht
1 - Script maken om datum toe te voegen aan een tekstbestand. script is "date >> ~/date.txt".

2 - uitzoeken wat een cronjob is. En de commandos die hiervoor gebruikt worden.  
3 - Met crontab -e kom je in de crontab editor. Hier kan je cronjobs invoeren. eerst 5 sterren die vertegenwoordigem tijdseenheden (min - uren - dag vd maand - maand - dag vd week). Hierachter plaats je het script wat je periodiek wilt uitvoeren.  
4 - Script dat datum toevoegd aan date.txt in crontab editor toevoegen. Eerst tijdsinterval aan de hand van de 5 sterren (*/1 * * * * = elke minuut) gevolgd door script. 

5 - uitzoeken hoe je diskspace laat zien. Dit doe je met df command. (-h - geeft weer in M(egabytes), G(igabytes), -- total - laat totaal onderaan de lijst zien). Gecombineerd met |grep total laat alleen de totaal lijn zien.  
6 - script schrijven om de diskspace in een bestand toe te voegen. Eerst met een tijdelijk tekstbestand. "df -h --total | grep total >> diskspace.txt" script functioneert. Voegt steeds regel met diskspace aan tekstbestand.txt.  
7 - var/log directory gevonden. Plan om een diskspace.txt bestand te creëeren om de diskspace naar weg te schrijven.
8 - Cronjob toevoegen met crontab -e (editor). Command 0 0 * * 0 ~/scripts/diskspace.sh toegevoegd. Dit laat elke zondag om 0:00u het bestand updaten.  
9 - tot slot heb ik het bestand in het script aangepast naar var/log/diskspace.txt.  
10 - Na het uitvoeren bleek dat de permissions niet voldeden. Ik heb de permissions aangepast naar rw voor user, group en others("sudo chmod g=rw  diskspace.txt" en "sudo chmod o=rw  diskspace.txt"). Dit resulteerde dat na het uitvoeren van het script de diskspace regel was toegevoegd aan het diskspace bestand.  
11 - heb crontab -e verandert in "0 12 * * 5 ~/scripts/diskspace.sh". Zou op vrijdag 12 uur de info bij moeten schrijven dus snellere controle.

### Gebruikte bronnen
https://ostechnix.com/a-beginners-guide-to-cron-jobs/  
https://www.computerhope.com/unix/ucrontab.htm  
https://www.atatus.com/blog/df-command-in-linux-with-examples/


### Ervaren problemen
Permissions van var/log/diskspace.txt (solved)


### Resultaat
Het script om de datum toe te voegen:
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-08%20-%201%20script.png)

Het script om de diskspace toe te voegen:
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-08%20-%202%20script%202.png)

De crontab:
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-08%203%20crontab.png)

Date.txt:
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-08%204%20date%20txt%20file.png)

