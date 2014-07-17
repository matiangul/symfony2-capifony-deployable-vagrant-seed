##### YOURPRODUCTIONLOGIN = np. bkoninski
##### YOUREMAIL = np. bkoninski@n-educatio.pl
##### PRODUCTION_IP = np. 1.1.1.1
```
cd ~/.ssh
ssh-keygen -t rsa -C "YOUREMAIL"
```
##### generowanie klucza (HASŁO)
##### dodać klucz do githuba
```
ssh-agent /bin/bash
ssh-add ~/.ssh/id_rsa_YOURPRODUCTIONLOGIN
scp id_rsa_YOURPRODUCTIONLOGIN.pub YOURPRODUCTIONLOGIN@PRODUCTION_IP:
```
##### zalogować się na produkcję i
```
cd ~
mv id_rsa_YOURPRODUCTIONLOGIN.pub ~/.ssh
cd ~/.ssh
cp authorized_keys authorized_keys.copy
cat id_rsa_YOURPRODUCTIONLOGIN.pub >> authorized_keys
```
##### BARDZO WAŻNE !!!
##### Jeśli nie będzie pliku ~/.ssh/config to będzie forwardował nasze klucze ssh do wszystkich z którymi się 
##### połączymy po ssh NOOOO!
```
Host PRODUCTION_IP
  ForwardAgent yes
```
