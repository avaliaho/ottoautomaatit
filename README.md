# ottoautomaatit-java
Ottoautomaatit-sovelluksen webservice

http://localhost:8080/ottoautomaatit/webservice - tulostaa kaikki Otto-automaatit Suomessa
http://localhost:8080/ottoautomaatit/webservice?sivu=0 - rajaa haun 100 kappaletta per sivu (nollasta alkaen)
http://localhost:8080/ottoautomaatit/webservice?postitoimipaikka=helsinki - tulostaa kaikki Otto-automaatit Helsingissä
http://localhost:8080/ottoautomaatit/webservice?postitoimipaikka=helsinki&sivu=0 - tulostaa 100 ensimmäistä Otto-automaattia Helsingissä

Ottoautomaatit-sovelluksen client
- voi hakea ottoautomaatteja paikkakunnan nimellä
- sivuttaa automaattisesti
- voi siirtyä sivulta toiselle (vain Helsingissä yli 100 Otto-automaattia)
