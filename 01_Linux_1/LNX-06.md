# Processes
Start Daemon process en achterhaal process id en geheugen verbruik. Sluit daarna het Daemon process

## Key-terms
**apt install telnetd -y**  
Installeert telnet

**ps aux**  
Lijst van Linux processen. Aanvullen met "| Grep " om processen te zoeken met een bepaald term. (bc ps aux | grep telnet)

**systemctl status inetd**  
Geeft status weer van het Inetd proces. Systemctl is er om systemd en service manager te beheren.



## Opdracht
### Gebruikte bronnen
https://adamtheautomator.com/linux-to-install-telnet/  
https://www.cyberciti.biz/faq/how-to-check-running-process-in-linux-using-command-line/  
https://devconnected.com/understanding-processes-on-linux/

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
Telnet geïnstalleerd met command "sudo apt install telnetd -y". Dit start automatisch het telnet process. Daarna heb ik via "sudo systemctl status inetd" een overzicht gekregen dat het proces actief is.
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-06%2001install.png)
