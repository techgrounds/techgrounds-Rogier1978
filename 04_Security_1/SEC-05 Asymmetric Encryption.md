# SEC-05 Asymmetric Encryption
Creëer RSA key pair en communiceer met peers vie deze pair.

## Key-terms
**RSA (cryptosystem)**  
RSA (Rivest–Shamir–Adleman) is a public-key cryptosystem that is widely used for secure data transmission. 

In a public-key cryptosystem, the encryption key is public and distinct from the decryption key, which is kept secret (private). An RSA user creates and publishes a public key based on two large prime numbers, along with an auxiliary value. The prime numbers are kept secret. Messages can be encrypted by anyone, via the public key, but can only be decoded by someone who knows the prime numbers.[

## Opdracht
1. Generate Key Pair is gedaan via devglan.com op de rsa encryption decryption pagina.

2. Dit werkt als je de public key deelt, zodat iemand anders met deze key messages kan encrypten voor de eigenaar van de public key. Met de private key kan de eigenaar deze weer ontcijferen. Zolang de key private is is het moeilijk de code te ontcijferen. Via devglan.com RSA pairs gemaakt en in de groep public keys uitgewisseld om te zien of dit zo werkt. Toen het werkt dit in de publieke chat gedaan. Belangrijk om public en private key in een textbestand op te slaan.

### Gebruikte bronnen
https://en.wikipedia.org/wiki/RSA_(cryptosystem)
https://www.devglan.com/online-tools/rsa-encryption-decryption  


### Ervaren problemen
Puzzelen om te zien hoe dit veilig is.

### Resultaat
Encrypted communication in the chat. Term public en private key zijn nu logisch:
