# SEC-07 Passwords
Bestudeer passwords. 

## Key-terms
**Hashing Algorithm**  
A hashing algorithm is a mathematical function that garbles data and makes it unreadable.
Hashing algorithms are one-way programs, so the text can’t be unscrambled and decoded by anyone else. And that’s the point. Hashing protects data at rest, so even if someone gains access to your server, the items stored there remain unreadable. 
Hashing can also help you prove that data isn’t adjusted or altered after the author is finished with it. And some people use hashing to help them make sense of reams of data.  

**Rainbow table**  
A rainbow table is a precomputed table for caching the outputs of a cryptographic hash function, usually for cracking password hashes.  
It starts with a plaintext, creates a hash function from the plaintext. Then it takes a reduction of the result of the hash. A reduction is a sort of reversed engineered hash. You use the result of this reversing and hash this again to create a huge string of hashes and "reversed" hashes. You can use this to lookup hashes that matches and use the "plaintext" that the hash originates from to use as password.

**"salt"**  
In cryptography, a salt is random data that is used as an additional input to a one-way function that hashes data, a password or passphrase.



## Opdracht
1. Hashing is a one way encryption (see key terms). Is preferred over symmetric encryption because its hard (impossible) to decrypt.  

2. Met crackstation.net heb ik de hashes ingevoerd. De eerste hash resulteerde in password "Welldone!". De tweede resulteerde in a not found result. Dit laat zien dat een sterk wachtwoord de veiligere keuze is tegen Rainbow Table attacks.  

3. Newuser aangemaakt met wachtwoord 12345. Informatie over user wachtwoord etc. is opgeslagen in /etc/shadow file. Zie afbeelding. De onderste regel is info over het "newuser" account. $6$ = SHA-512. Daarna volg een reeks tekens wat de hash van het wachtwoord is. Aan het eind tussen dubbele punten staan: last :password change:minimum between changes:maximum days valid:warn before expiration:days inactive:expiration.  

4. 


### Gebruikte bronnen
https://en.wikipedia.org/wiki/Rainbow_table  
https://kestas.kuliukas.com/RainbowTables/  

### Ervaren problemen

### Resultaat
