-- Exemple de requetes :
SELECT `name` FROM pilots ; -- selectionne juste les "name" de tous les pilotes
SELECT name, certificate FROM pilots ; -- selectionne juste les "name" et "certificate"

SELECT * FROM pilots WHERE certificate='ct-1' ; -- selectionne juste la personne avec le certificate ct-1
SELECT * FROM pilots WHERE compagny='AUS' ; -- selectionne tous les pilotes de la compagny AUS
SELECT * FROM pilots WHERE compagny='aus'; -- idem, MySQL n'est pas sensible à la casse

SELECT DISTINCT num_jobs FROM pilots; -- selectionne tous les num_jobs différents (pas de doublon)
SELECT DISTINCT compagny FROM pilots; -- selectionne les compangnies différentes (pas de doublon)

SELECT DISTINCT compagny FROM pilots ORDER BY compagny; -- ordonne selon compagny, ordre croissant
SELECT DISTINCT compagny FROM pilots ORDER BY compagny DESC; -- ordonne selon compagny, ordre décroissant

SELECT * FROM pilots ORDER BY next_flight; -- ordonne selon next_flight croissant
SELECT * FROM pilots ORDER BY next_flight DESC; -- ordonne selon next_flight décroissant
SELECT * FROM pilots ORDER BY compagny, next_flight DESC; -- ordonne selon compagny croissant et next_flight décroissant
SELECT * FROM pilots ORDER BY compagny DESC, next_flight ASC; -- ordonne selon compagny décroissant et next_flight décroissant
SELECT compagny, name, next_flight FROM pilots ORDER BY compagny, next_flight DESC;

SELECT * FROM pilots WHERE num_jobs > 30; -- num_jobs supérieur à 30
SELECT * FROM pilots WHERE num_jobs >= 30; -- num_jobs supérieur ou égal à 30
SELECT * FROM pilots WHERE num_jobs <> 30; -- num_jobs différent de 30
SELECT * FROM pilots WHERE num_jobs != 30; -- num_jobs différent de 30 (autre syntaxe)
SELECT * FROM pilots WHERE num_jobs <> 30 AND compagny = 'FRE1'; -- num_jobs différent de 30 ET pilote appartient à la compagnie FRE1
SELECT * FROM pilots WHERE num_jobs <> 30 AND compagny = 'AUS'; -- num_jobs différent de 30 ET pilote appartient à la compagnie AUS
SELECT * FROM pilots WHERE num_jobs <> 30 OR compagny = 'AUS'; -- num_jobs différent de 30 OU pilote appartient à la compagnie AUS
SELECT * FROM pilots WHERE num_jobs BETWEEN 10 AND 30; -- num_jobs entre 10 et 30 (compris dans l'intervalle)
select * from pilots where num_jobs = 10 and num_jobs = 30; -- ne retourne rien => on peut pas demander qu'un même champs retourne 2 valeurs différentes
select * from pilots where num_jobs = 10 OR num_jobs = 30; -- est ok

SELECT name FROM pilots WHERE name LIKE 'a%'; -- name commance par un "a"
SELECT name FROM pilots WHERE name LIKE '%a%'; -- nbame contient un "a"
SELECT name FROM pilots WHERE name LIKE '%n'; -- name termine par un "n"
SELECT name FROM pilots WHERE name LIKE '____'; -- seulement 5 caratères exacteent (1 "—" vaut pour 1 caractère)
SELECT name FROM pilots WHERE name LIKE 'a%n'; -- Commence par "a" et finit par "n"
SELECT name FROM pilots WHERE name LIKE '_o%'; -- possède un "o" en 2e caractère

SELECT name, num_jobs FROM pilots WHERE num_jobs = 7 OR num_jobs = 10 OR num_jobs = 50; -- sélectionne les num_jobs égals à 7, 10 ou 50
SELECT name, num_jobs FROM pilots WHERE num_jobs IN (7,10,50); -- pareil que ci-dessus, mais en plus simple
SELECT name, compagny FROM pilots WHERE compagny IN ('sin','aus','chi'); -- marche aussi avec des chaines de caractères

SELECT * FROM pilots LIMIT 1; -- Ne retourne qu'un seul résultat, le premier qui arrive dans la table (pas de tri)
SELECT * FROM pilots ORDER BY birth_date LIMIT 1; -- retourne le plus vieux pilot (ordonné par date croissante) + limit à 1
SELECT * FROM pilots ORDER BY birth_date LIMIT 0,1; -- idem que ci-dessus
SELECT * FROM pilots ORDER BY birth_date LIMIT 0,3; -- retourne les 3 premiers réseultats (les 3 pilotes les plus vieux donc)
SELECT * FROM pilots ORDER BY birth_date LIMIT 3,3; -- retourne les 3 suivants (principe de pagination)

SELECT * FROM pilots ORDER BY RAND() LIMIT 3; -- mélange la table ( ORDER BY RAND() ) et prend les 3 premiers résutats qui tombent.
SELECT ROUND( RAND() * 100 ) + 1; -- Retourne une valeur aléatoire entre 1 et 100 (voir la doc MySQL pour plus d'infos)

select * from pilots where YEAR(next_flight) > 2021; -- retourne les pilotes dont l'année du prochain vol est (strictement) après 2021
select * from pilots where YEAR(next_flight) >= 2021; -- retourne les pilotes dont l'année du prochain vol est à partir de 2021 (compris)
select YEAR(next_flight) from pilots; -- retourne l'année du prochain vol de chaque pilote

--- LUNDI 7 fevrier corrections et revisions @Antoine GROUPE 01

--- LUNDI 7 fevrier corrections et revisions @Antoine GROUPE 01

-- Comptez le nombre d'heure de vols distincts

SELECT COUNT(numFlying) FROM pilots; -- compte toutes les heures même identiques

SELECT COUNT( DISTINCT numFlying ) FROM pilots; -- compte toutes les heures distincts


-- 1 
SELECT name FROM pilots WHERE compagny= "AUS";

-- 2 on peut ajouter dans la projection des comandes cela crée une colonne en plus

SELECT name FROM pilots WHERE compagny= "FRE1" AND numFlying > 15;

-- 3.0 Sélectionnez les noms des pilotes de la compagnie FRE1 ayant fait plus de 20 heures de vols.

SELECT name FROM pilots WHERE compagny= "FRE1" AND numFlying > 20 ;

-- Sélectionnez les noms des pilotes de la compagnie FRE1 ayant fait entre 10 et 20 heures de vols.

SELECT name FROM pilots WHERE compagny= "FRE1" AND numFlying > 10 AND numFlying < 20 ;


-- Sélectionnez les noms des pilotes de la compagnie FRE1 ou AUS ayant fait plus de 20 de vols.

-- attention AND est prioritaire par rapport à OR, n'oubliez pas les parenthèses

SELECT name 
FROM pilots
WHERE ( compagny = 'FRE1' OR compagny = 'AUS' ) AND numFlying > 20;

-- Sélectionnez les noms des pilotes ayant fait entre 190 et 200 heures de vols.
-- Attention le between est large il prend les "bornes" de l'intervalle.

SELECT name 
FROM pilots
WHERE numFlying BETWEEN 190 AND 200;

-- Sélectionnez les noms des pilotes qui sont nés après 1978.


SELECT name, birth_date
FROM pilots
WHERE birth_date > '1978';


-- Sélectionnez les noms des pilots qui sont nés après mars 1978

SELECT name, birth_date
FROM pilots
WHERE birth_date > '1978-03';

-- Sélectionnez les noms des pilotes qui sont nés avant 1978.

SELECT name, birth_date
FROM pilots
WHERE birth_date < '1978';

-- Sélectionnez les noms des pilotes qui sont nés entre 1978 et 2000.

SELECT name, birth_date
FROM pilots
WHERE birth_date > '1978' AND birth_date < '2000';

-- Attention dans ce cas on aura les années 2000
SELECT name, birth_date
FROM pilots
WHERE YEAR(birth_date) BETWEEN '1978' AND  '1999';


-- Quels sont les pilotes qui ont un vol programmé après 2020-05-08 ?

SELECT name, next_flight
FROM pilots
WHERE next_flight > '2020-05-08';


-- Sélectionnez tous les noms des pilotes qui sont dans les compagnies : AUS et FRE1.

SELECT name FROM pilots WHERE compagny = 'AUS' AND compagny = 'FRE1';

-- Sélectionnez tous les noms des pilotes qui sont dans les compagnies : AUS ou FRE1.

SELECT name FROM pilots WHERE compagny = 'AUS' OR compagny = 'FRE1';

SELECT name FROM pilots WHERE compagny IN ( 'AUS', 'FRE1' );

-- Sélectionnez tous les noms des pilotes qui ne travaillent pas pour les compagnies : AUS ou FRE1.

SELECT name FROM pilots WHERE compagny NOT IN ( 'AUS', 'FRE1' );

SELECT name FROM pilots WHERE compagny != 'AUS' AND compagny != 'FRE1';

-- Sélectionnez tous les des pilotes dont le nom de compagnie contient un A.

-- Calculez la somme des heures de vols des pilots 

SELECT SUM(numFlying) 
FROM pilots;

-- Calculez la fréquence des heures de vols de chaque pilote par rapport au total des heures de vols

SELECT ROUND( numFlying / (SELECT SUM(numFlying)  FROM pilots), 2 ) * 100 as fq_nbflying
FROM pilots;

-- Autres arrondis :
SELECT numFlying / 2.6 as fq_nbflying
FROM pilots;
SELECT ROUND(numFlying / 2.6, 2) as fq_nbflying
FROM pilots;
-- Arrondi à l'entier inférieur
SELECT FLOOR(numFlying / 2.6) as fq_nbflying
FROM pilots;
-- Arrondi à l'entier supérieur
SELECT CEIL(numFlying / 2.6) as fq_nbflying
FROM pilots;

-- Sélectionnez tous les des pilotes dont le nom de compagnie contient un A.

SELECT name, compagny
FROM pilots
WHERE compagny LIKE '%a%';

-- Sélectionnez tous les pilotes dont le nom de la compagnie commence par un F.

SELECT name, compagny
FROM pilots
WHERE compagny LIKE 'f%';

-- Sélectionnez tous les pilotes dont le nom de la compagnie contient un I suivi d'un caractère.

SELECT name,compagny 
FROM pilots 
WHERE compagny LIKE '%i_';  

-- modification de la table pilots :

ALTER TABLE pilots
DROP bonus;

ALTER TABLE pilots
ADD bonus SMALLINT UNSIGNED AFTER certificate;

UPDATE `pilots` 
SET `bonus` = 1000 
WHERE `certificate` IN ('ct-1', 'ct-11', 'ct-12');

UPDATE `pilots` 
SET `bonus` = 2000 
WHERE `certificate` IN ('ct-56'); 

UPDATE `pilots` 
SET `bonus` = 500 
WHERE `bonus` IS NULL; 

-- avec un case when on peut mettre à jour nos données en une commande.
UPDATE `pilots` 
SET `bonus` = (
    CASE 
        WHEN certificate IN ('ct-1', 'ct-11', 'ct-12') THEN 1000
        WHEN certificate IN ('ct-56') THEN 2000
        ELSE 500
    END);

-- pilote ayant eu le meilleur bonus
SELECT MAX(bonus) FROM pilots; -- Donne le meilleur bonus

SELECT name, bonus FROM pilots
WHERE bonus = (SELECT MAX(bonus) FROM pilots); -- donne le nom du pilot avec le meilleur bonus


-- heures de vols distincts dans la table pilots
SELECT DISTINCT numFlying FROM pilots; -- liste les différents nb d'heures de vol
SELECT COUNT(DISTINCT numFlying) as nbflyhours FROM pilots; -- affiche les nbs d'heures différents


-- Combien de pilotes sont en dessous de la moyenne d'heure de vols ?
SELECT AVG(numFlying) FROM pilots; -- moyenne d'heures de vol
SELECT name FROM pilots WHERE numFlying < (SELECT AVG(numFlying) FROM pilots); -- liste des pilotes sous la moyenne