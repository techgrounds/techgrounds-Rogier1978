# SEC-04 Symmetric Encryption
Onderzoek encryption. Deel een symmetrische encryptie.

## Key-terms  

**Encryption**  
In cryptography, encryption is the process of encoding information. This process converts the original representation of the information, known as plaintext, into an alternative form known as ciphertext.  

**Caesar cipher**  
Caesar ciphers use a substitution method where letters in the alphabet are shifted by some fixed number of spaces to yield an encoding alphabet. A Caesar cipher with a shift of 1 would encode an A as a B, an M as an N, and a Z as an A, and so on.  

**Ciphers (coderen)**
Algorithms for encoding text to make it unreadable to voyeurs.

**Keys**
Numeric parameters that change the behavior of ciphers  

**plain text**  
Unencrypted data

**cipher text**  
encrypted data

**Symmetric-key cryptosystems (Called Private Key Cryptography)**  
Algorithms that use the same key for encoding and decoding (fast, better performance metrics, optimized for bulk, easy to implement)

**Asymmetric-key cryptosystems**  
Algorithms that use different keys for encoding and decoding

**Public-key cryptography**  
A system making it easy for millions of computers to send secret messages  

**stream ciphers**  
Encrypts bit for bit

**block cyphers**  
Encrypts per entire block (e.g. 128 bit blocks)

**Digital signatures**  
Checksums that verify that a message has not been forged or tampered with  

**Digital certificates**  
Identifying information, verified and signed by a trusted organization  

## Opdracht  
1. More historic encryption cipher:  

Playfair Cipher

The Playfair cipher is a diagraph substitution cipher. Instead of encoding a message by replacing individual characters, it replaces them in pairs. To encode a message, the Playfair cipher uses a keyword to generate a 5 by 5 encoding table and then follows 4 rules to encode digrams (pairs of characters) using the table.  

Book Cipher

The book cipher is an encryption method often used in popular culture. With a book cipher, both the sender and recipient of a secret message must have the same copy of a book, usually down to the same edition. The sender then encodes the secret message word-by-word by replacing the plaintext word with coordinates mapping to the location of the same word within the chosen book. For example, if the word “Kill” appeared in the book on page 39, paragraph 7, word 12, the ciphertext coordinates would be {39:7:12}. To decode the word, the recipient would find the word within their copy of the book in the notated position.  

More ciphers here: https://www.secplicity.org/2017/05/25/historical-cryptography-ciphers/  

Also famous:

Enigma machine 

The Enigma machine is a cipher device developed and used in the early- to mid-20th century to protect commercial, diplomatic, and military communication.
https://en.wikipedia.org/wiki/Enigma_machine  

2. Digitale symmetrische ciphers zijn onder ander AES (Advanced Encrypt Standard), en DES (Data Encryption Standards).  

3. Eerst gaan kijken hoe je encryption kan maken. Met wat geëxpeimenteer in de groep ben ik voor devglan.com gaan gebruiken. Dit is een website waar je kan encrypten en decrypten in verschillende codes. Ik heb AES gebruikt. Hieronder een afbeelding van devglan.com en hoe je een zin encrypt (links) en decrypt (rechts) met ECB en 128 bit key size.  



4. Nu kan je de encrypted output van de linkerkant versturen samen met de Secret Key. Als je deze invult aan de rechter kant kan je de cipher text weer terug coderen naar plain text. Probleem met deze methode is dat de key op een of andere manier naar de ontvanger mee moet worden gezonden en dus een veiligheidsrisico kan zijn.

### Gebruikte bronnen
https://brilliant.org/wiki/caesar-cipher/  
https://www.secplicity.org/2017/05/25/historical-cryptography-ciphers/  
https://www.oreilly.com/library/view/http-the-definitive/1565925092/ch14s02.html  
https://en.wikipedia.org/wiki/Cryptography
https://www.simplilearn.com/tutorials/cryptography-tutorial/symmetric-encryption  
https://www.devglan.com/cryptotools/cryptography-tools

### Ervaren problemen
De voorbeelden in de Slack van klasgenoten ware erg creatief, kon er op het moment niet aan tippen.

### Resultaat
Ik ben in staat via devglan.com een zin te encrypten en vie een paswoord weer te decrypten. Deze code samen met paswoord zijn makkelijk te verspreiden, creativiteit is nodig om het op een veilige manier te doen.
