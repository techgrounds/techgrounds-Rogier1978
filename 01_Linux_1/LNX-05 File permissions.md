# File permissions
Maak een tekstbestand en verander de permissons van het bestand. 


## Key-terms
**ls -l**  
Long listing laat the permissions zien.
drwxrwxrwx Directory - Read - Write - Execute voor users, group en others (u-g-o).
De eerste kolom met gebruikersnaam is de owner, de tweede kolom met gebruiksersnamen is de group of users.

**chmod**
Command om permissions te wijzigen. (bv chmod u=rw,og-r filename.ext)

**chown**  
Change owner. Verandert eigenaar van de file. (bv chown new-owner filename.ext)

**chgrp**  
Change group. Verandert de group van het bestand. Werkt vergelijkbaar met chown van hierboven.

## Opdracht
### Gebruikte bronnen
https://www.elated.com/understanding-permissions/  
https://www.howtogeek.com/437958/how-to-use-the-chmod-command-on-linux/  
https://www.linuxlinks.com/linux-starters-guide-linux-files-permissions/2/  
https://docs.oracle.com/cd/E19683-01/817-0365/secfile-3/index.html  
https://docs.oracle.com/cd/E19683-01/806-4078/6jd6cjs2v/index.html


### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
De aangemaakt textfile had als permissions -rw-rw-r--, dat is read en write of owner en usergroup, read voor others. Rogier is in dit geval de eigenaar en group user. Na aanpassing van de permissions is dit te zien in het ls -l command. De file is door de eigenaar nog steeds te lezen met het head command. (zie screenshot)  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-05%20chmod.png)

Met het command chown de owner verandert naar test_user. Na het ls -l command is te zien dat het bestand van eigenaar is verandert. Ook kan ik als andere user het bestand niet meer lezen met het head command.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-05%20chown.png)  

Tot slot met command chgrp de user group verandert naar sudo group.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-05%20chgrp.png)


