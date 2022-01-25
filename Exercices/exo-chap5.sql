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