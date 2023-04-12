# Working with text (CLI)

Text aan een bestand toevoegen en weergeven in de Linux CLI.

## Key-terms
**echo "text" >> filename.ext**  
Plaats de "text" achteraan bij het aangegeven bestand.

**head filename.ext**  
Geeft de de inhoud van het textbestand weer.

**tail +n**  
laat alleen de laatste n lijnen zien van een tekstbestand. (head filename.ext | tail +n)

**grep**  
grep "text" filename.ext - laat de regel zien waarin de "text" voorkomt in filename.ext.

**>**  
print de output van de opdracht naar een textbestand.

## Opdracht
### Gebruikte bronnen
https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file  
https://www.linode.com/docs/guides/how-to-grep-for-text-in-files/  
https://stackoverflow.com/questions/16631423/output-grep-results-to-text-file-need-cleaner-output

### Ervaren problemen
Hoofdlettergevoelig 


### Resultaat
Heeft een extra lijn aan het textbestand toegevoegd uit de vorige oefening (LNX-02). In de sceenshot hierondeer is te zien dat de regel met het woord Techgrounds als output is weergegeven. Ook voor de laatste stap is te zien dat er een textbestand (techground.txt) is gecreëerd met de Techgrounds regel.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-03%20grep.png)

