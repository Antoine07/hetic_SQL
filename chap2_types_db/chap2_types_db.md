# Les types dans MySQL

MySQL est un langage typé, cela signifi que vous devez définir un type pour les colonnes des tables.

- **INT** sur 4 octets (1 octet=8 bits par exemple 10100011), nombre compris entre -2147483648 et 2147483648

Attention, si la valeur que l'on enregistre dépasse le max ou le min de cet intervalle, alors MySQL met son max ou son min par défaut pour toute valeur

- **BIGINT** 8 octets => -9223372036854775808 et 9223372036854775808

- **TINYINT** 1 octet => -127 à 127

- **TINYINT UNSIGNED**  1 octet => 0 à 255

*UNSIGNED peut-être utilisé avec les autres types numériques.*

- **DECIMAL(n,v)** pour stocker des nombres sur n chiffres significatifs ayant v chiffres après la virgule:

- **CHAR(x)** et **VARCHAR(x)**
Pour stocker un texte court x < 255 octets on utilise CHAR et VARCHAR

- **CHAR(x)** Stocke (réserve) x octets quelle que soit la valeur que l'on place dans la colonne ayant ce type.
Attention, donc MySQL réserve un nombre d'octets fixe pour chaque champ.

- **VARCHAR(x)** stocke jusqu'à x octets (0 à x octets) selon la taille du mot à stocker. Cette option alloue donc dynamiquement le nombre d'octets requis =< x.

Pour les textes supérieurs à 255 octets on utilise le type

- **TEXT** sur 2^16 octets.

- **BLOB** est un type binaire capable de stocker des objets binaires de grande taille. Ici les chaînes de caractères seront sensibles à la casse...Nous ne l'aborderons pas dans le cours.

- **ENUM** Définit un ensemble de caractères autorisés de type chaîne de caractères :

```sql
title ENUM('foo', 'bar', 'baz')
```

- **DATE**
Attention au format
AAAA-MM-JJ ~ AAMMJJ ~ AAAA/MM/JJ ~ AAAA%MM%JJ

- **DATETIME**  C'est le type que l'on utilise en général pour les dates de nos posts en base de données.
AAAA-MM-JJ HH:MM:SS

On ne parlera pas du TIMESTAMP de MySQL (mal implémenté), sachez seulement qu'en informatique c'est pour une date donnée « t » le temps en secondes qui s'est écoulé depuis la naissance d'UNIX (1 janvier 1970, 0h0min0s).
