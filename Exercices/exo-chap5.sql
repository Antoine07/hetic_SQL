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

-- 1 
SELECT * FROM pilots WHERE compagny= "AUS";

-- 2 on peut ajouter dans la projection des comandes cela crée une colonne en plus

SELECT name FROM pilots WHERE compagny= "FRE1" AND numFlying > 15;

-- 3.0 Sélectionnez les noms des pilotes de la compagnie FRE1 ayant fait plus de 20 heures de vols.

SELECT name FROM pilots WHERE compagny= "FRE1" AND numFlying > 20 ;
SELECT name FROM pilots WHERE compagny= "FRE1" AND numFlying > 20 AND numFlying < 10 ;

-- 3.1 comptez le nombre de pilotes qui on fait plus de 20 heures de vols ?

SELECT COUNT(*) FROM pilots WHERE numFlying > 20; 

-- 3.2 On aimerait connaitre tous les heures de vols distincts des pilots

SELECT DISTINCT numFlying FROM pilots; -- commande DISTINCT unique représentant dans l'ensemble

-- 4 Sélectionnez les noms des pilotes de la compagnie FRE1 ou AUST ayant fait plus de 20 de vols.

SELECT name, compagny FROM pilots WHERE ( compagny = 'FRE1' OR compagny = 'AUS' ) AND numFlying > 20 ; 
SELECT name, compagny FROM pilots WHERE compagny IN ('AUS', 'FRE1') AND numFlying > 20 ; 

-- 5 Sélectionnez les noms des pilotes ayant fait entre 190 et 200 heures de vols.

SELECT name, numFlying FROM pilots WHERE numFlying BETWEEN 190 AND 200 ;


-- 6 Sélectionnez les noms des pilotes qui sont nés après 1978.

SELECT name, birth_date
FROM pilots
WHERE birth_date> '1978';

-- 7 Sélectionnez les noms des pilotes qui sont nés avant 1978.

SELECT name, birth_date
FROM pilots
WHERE birth_date < '1978';

-- 8 Sélectionnez les noms des pilotes qui sont nés entre 1978 et 2000.

SELECT name, birth_date
FROM pilots
WHERE birth_date > '1978' AND birth_date < '2000' ;

-- 9 Quels sont les pilotes qui ont un vol programmé après 2020-05-08 ?

SELECT name as n , next_flight as nf
FROM pilots
WHERE next_flight > '2020-05-08 : 00:00:00';

-- 10 Calculez la somme du nombre d'heures de vols

SELECT SUM(numFlying) FROM pilots;

-- 10.1 Calculez la fréquence du nombre d'heure de vols par pilots

SELECT ROUND( numFlying / (SELECT SUM(numFlying) FROM pilots) , 2 ) * 100 as freq_h_pilots
FROM pilots;

/*
POINT DE COURS
On peut dans un SELECT effectuer des calculs avec des sous requêtes qui renvoient des valeurs avec les fonctions comme AVG, COUNT, SUM par exemple
*/

-- 11 Sélectionnez tous les noms des pilotes qui sont dans les compagnies : AUS et FRE1.

-- 11.1 Cette requête ne renvoie aucun résultat 

SELECT name 
FROM pilots
WHERE compagny = 'AUS' AND compagny = 'FRE1';

-- 11.2 Sélectionnez tous les noms des pilotes qui sont soient dans les compagnies : AUS ou FRE1.

SELECT name, compagny
FROM pilots
WHERE compagny IN ('FRE1', 'AUS');


-- 11.3 Sélectionnez tous les noms des pilotes qui ne sont pas dans les compagnies : AUS et FRE1.

SELECT name, compagny
FROM pilots
WHERE compagny NOT IN ('FRE1', 'AUS');


--- 12 Sélectionnez tous les des pilotes dont le nom de compagnie contient un A.

/*
 %A% n'importe quel caractère avant ou après et un A ou a même chose dans la recherche CI dans la chaîne
*/

SELECT name
FROM pilots
WHERE compagny LIKE '%a%';


-- 13 Sélectionnez tous les pilotes dont le nom de la compagnie commence par un F.

SELECT name
FROM pilots
WHERE compagny LIKE 'f%';

-- 14 Sélectionnez tous les pilotes dont le nom de la compagnie contient un I suivi d'un caractère.

SELECT name
FROM pilots
WHERE compagny LIKE '%i_';


-- 15 Récupérez tous les noms des pilotes dont le nom de leur compagnie se termine par R suivi de 2 caractères exactement

SELECT name, compagny 
FROM pilots 
WHERE compagny REGEXP '.*r.{2}$';

/*

. n'importe quel caractère
* 0 à N caractère(s)
r le caractère r
{2} exactement 2
$ se termine

*/