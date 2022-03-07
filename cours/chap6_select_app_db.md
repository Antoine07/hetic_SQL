
# Sous interogations multilignes IN

- IN compare un élément à une donnée quelconque d'une liste ramenée par sous-interogations.

Vous pouvez effectuer en MySQL des sous-requêtes, attention cependant à mettre celles-ci dans des paranthèses, elles ne doivent pas comporter de clause ORDER BY :

```sql

SELECT colonne(s) FROM mytable1
WHERE colonne(s) IN (
  SELECT colonne(s) FROM mytable2
)
```

## Exercice adresse des compagnies et heures de vols

Quelles sont les coordonnées des compagnies qui employe(nt) des pilotes faisant moins de 90 heures de vols ?

## Exercice somme des heures de vols

Faites la somme des heures de vols des pilotes de la compagnie d'Air France.

## Exercice compagnie(s) sans pilote

Ajoutez maintenant la compagnie suivante dans la table compagnies :

comp = ITA, street = mapoli, city = Rome, name = Italia Air, numStreet =  20

Trouvez toute(s) les/la compagnie(s) n'ayant pas de pilotes.

## Clause ALL

Cette commande s’utilise dans une clause conditionnelle entre l’opérateur de condition et la sous-requête. L’exemple ci-dessous montre un exemple basique :

Cette clause s'utilise dans une sous-requête de manière identique à la clause IN. Elle permet de comparer une valeur dans l'ensemble de valeurs d'une sous-requête.

## Exercice nombre inférieur d'heure de vols

Ajoutez la colonne plane à la table pilots :

```sql

ALTER TABLE pilots
ADD COLUMN plane
ENUM('A380', 'A320', 'A340') AFTER name;

UPDATE pilots
SET plane = 'A380'
WHERE name in ('Alan', 'Jhon', 'Albert', 'Benoit');

UPDATE pilots
SET plane = 'A320'
WHERE name in ('Tom', 'Sophie', 'Yi');

UPDATE pilots
SET plane = 'A340'
WHERE name in ('Yan', 'Pierre');
```

Sélectionnez toutes les compagnies dont le nombre d'heures de vol est inférieur à tous les nombres d'heures de vol (chaque heure de vol) des A320.
