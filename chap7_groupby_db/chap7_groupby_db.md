# DQL

## Fonctions de groupe

Elles s'utilisent dans la clause SELECT sur une/des colonnes, elles permettent de regrouper des données. Si vous utilisez les fonctions de groupement avec une requête ne contenant pas de clause GROUP BY, cela revient à grouper toutes les lignes.

```text
AVG([DISTINCT] exp)              moyenne
COUNT({*| DISTINCT] expr})       nombre de lignes
MAX([DISTINCT] exp)              max
MIN([DISTINCT] exp)              min
SUM([DISTINCT] exp)              somme
GROUP_CONCAT(exp)                composition d'un nombre de valeurs, concaténation de valeurs de champ a, b, c, d
VARIANCE(exp)                    variance
STDDEV(exp)                       écart type

```
## Groupement de lignes

```text
SELECT col1 [,col2, ...], fonction_groupe
FROM table
WHERE (condition)
**GROUP BY clo1 [, col2, ...]**
HAVING condition
ORDER BY col1 [ASC | DESC] [, col2 ...]
```

- La clause WHERE exclue des lignes pour chaque groupement ou permet de rejetr des groupements entiers. Elle s'applique à la totalité de la table.

- La clause GROUP BY liste des colonnes de groupement.

- La clause HAVING permet de poser des conditions sur chaque groupement.

Attention, les colonnes préssentes dans le SELECT doivent apparaître dans le GROUP BY. Seules des fonctions ou expressions peuvent exister en plus dans le SELECT.

## Exercice moyenne des vols

Calculez la moyenne des vols pour chaque compagnie.

## Exercice moyenne et bonus

Calculez la moyenne des heures de vols des pilots dont le bonus est de 500,
par compagnie.

## Exercice nombre de pilotes

Sélectionnez les compagnies et leur nombre de pilote(s), ayant plus d'un pilote.

## Exercice ajout d'une colonne & valeurs

*Si vous n'avez pas fait les exercices supplémentaires. Vous devez faire ce qui suit, sinon passer à la suite.*

Ajoutez une colonne plane à la table pilots de type ENUM ayant pour valeurs possibles :
'A380', 'A320', 'A340'.

Et mettez à jour la table avec les contraintes suivantes :

- 'Alan', 'Sophie', 'Albert', 'Benoit' volent sur un A380.

- 'Tom', 'Jhon', 'Pierre' volent sur un A320.

- 'Yan', 'Yin' sur un A340.

## Exercice sélectionner pilotes & compagnies

Sélectionnez le nombre de pilote(s) par compagnie et par type d'avion.

## Exercice noms de pilotes

- Sélectionnez le noms des pilotes par bonus.

- Sélectionnez le noms et la compagnie des pilotes par bonus.

## Exercice étendue

Calculez l'étendue du nombre d'heure de vol par compagnie.

## Exercice moyenne et nombre de jours

- Faites la somme du nombre de jours de vols par compagnie dont la somme est supérieur à 30.

09. Exercice moyenne des heures de vol

Afficher la moyenne des heures de vol pour les compagnies qui sont en France.
```sql
SELECT AVG(numflying) 
FROM pilots 
WHERE compagny IN (
	SELECT comp FROM compagnies 
	WHERE city = 'France')
GROUP BY compagny ;
```


## ROLLUP & CUBE

### ROLLUP

Cette clause permet de créer des regroupement combinés, prenons un exemple 

```sql
SELECT col1, col2, col3, fonction_groupe(col3)
FROM table
GROUP BY col1, col2, col3 WITH ROLLUP
```

Le ROLLUP permettra de faire les regroupements suivants : col1 et col1, col2 et enfin col1, col2, col3

## 02 Exercices sales et découverte des procédures

1. Créez la table sales, elle représente la table des dépenses. Mettez à jour cette table avec les données suivantes :

**Création de la table sales référencée à la table compagnies, avec les champs suivants**

id : bigint unsigned auto_increment (clé primaire)
created_at : date avec une date par défaut à 1980-01-01
compagny : clé étrangère référencée à la table compagnies (champs comp)
profit : champ décimale de 15 chiffres avec 2 chiffres après la virgule.
```sql
DROP TABLE IF EXISTS sales;
CREATE TABLE `sales` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` DATE DEFAULT '1980-01-01',
    `compagny` CHAR(4),
    `profit` DECIMAL(15,2),
    CONSTRAINT pk_id PRIMARY KEY (`id`),
    CONSTRAINT fk_sales_compagny FOREIGN KEY (compagny) REFERENCES compagnies(`comp`)
) ENGINE=InnoDB ;
```



2. Procédure découverte 

Nous allons découvrir une méthode pour hydrater la table sales : une procédure SQL, sorte de fonction que nous appelerons dans la console MySQL pour exécuter un script. Voici ci-desous un exemple de procédure :

```sql
DELIMITER $$

DROP PROCEDURE IF EXISTS calculate 
CREATE PROCEDURE calculate(IN x INT, IN y INT, OUT sum INT)
BEGIN
  SET sum = x + y;
END;
DELIMITER ;

-- Appel de la procédure dans la console mysql
call calculate(1, 2, @s );
SELECT @s;
```

Nous vous donnons cette première procédure afin de découvrir la syntaxe SQL pour l'implémenter dans votre code, ATTENTION pensez à bien échapper le champ year_month avec les cote habituel

```sql

-- change le délimiter pour créer la procédure
DELIMITER $$

DROP PROCEDURE IF EXISTS set_data$$
CREATE PROCEDURE set_data(IN  comp CHAR(4))
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE d DATE DEFAULT '1980-01-01';
  loop_data : LOOP

    IF (i = 20*12) THEN
        LEAVE loop_data;
    END IF;

    INSERT INTO 
    `sales` (created_at, compagny, profit) VALUES ( d, comp, ROUND(RAND()*15 * 100000, 2 ));

    SET d = DATE_ADD(d, INTERVAL 1 MONTH);
    SET i = 1 + i;
  END LOOP; 
END$$

-- rétablit le délimiter dans la console
DELIMITER ;

call set_data('AUS');
call set_data('CHI');
call set_data('SIN');
call set_data('FRE1');
call set_data('ITA');
```
## 03 Exercices sales ROLLUP

1. Calculez les profits de chaque compagny par année, ainsi que le total par année pour toutes les compagnies et enfin le total global des profits.
```sql
SELECT year(created_at) as year, compagny, sum(profit) as CA
FROM sales
GROUP BY year, compagny WITH ROLLUP;

```

2. Calculez maintenant par année et par mois avec la même granularité que la question 1 respectivement par rapport à ce dernier regroupement.
```sql
SELECT year(created_at) as year,month(created_at) as month, compagny, sum(profit) as CA
FROM sales
GROUP BY year, month, compagny WITH ROLLUP;
```