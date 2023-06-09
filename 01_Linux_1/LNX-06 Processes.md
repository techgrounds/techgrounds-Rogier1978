# Processes
Start Daemon process en achterhaal process id en geheugen verbruik. Sluit daarna het Daemon process

## Key-terms
**apt install telnetd -y**  
Installeert telnet

**ps aux**  
Lijst van Linux processen. Aanvullen met "| Grep " om processen te zoeken met een bepaald term. (bc ps aux | grep telnet)

**systemctl start/status/stop inetd**  
Start, geeft status en stopt het Inetd proces. Systemctl is er om systemd en service manager te beheren.



## Opdracht
### Gebruikte bronnen
https://adamtheautomator.com/linux-to-install-telnet/  
https://www.cyberciti.biz/faq/how-to-check-running-process-in-linux-using-command-line/  
https://devconnected.com/understanding-processes-on-linux/  
https://itslinuxfoss.com/start-stop-and-restart-services-ubuntu/

### Ervaren problemen
Veel problemen gehad met deze opdracht waar ik eigenlijk moeilijk mijn vinger op kon leggen. Kreeg in de processen overzicht na het "ps aux"-commando niet het gewenste resultaat. Ook na de status opdracht van de systemctl kreeg ik foutmeldingen over "failed logins". Nadat ik onderzocht had hoe het "inetd" proces te sluiten, vielen alle problemen weg en functioneerde het op een logische manier.

### Resultaat
Telnet geïnstalleerd met command "sudo apt install telnetd -y". Dit start automatisch het telnet process. Daarna heb ik via "sudo systemctl status inetd" een overzicht gekregen dat het proces actief is. 
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-06%2001install.png)

Met de commando's "sudo systemctl start inetd" en "sudo systemctl stop inetd" kun je de service starten en stoppen. Met het commando "ps aux | grep inetd" kan je info over de inet processen inzien, waaronder PID, processor gebruik en geheugengebruik.
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/LNX-06%2002%20startenstop.png)

