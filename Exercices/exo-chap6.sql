-- Quelles sont les coordonnées des compagnies qui employe(nt) des pilotes faisant moins de 90 heures de vols ?
SELECT name, street, city FROM compagnies; -- adresses des compagnies
SELECT * FROM pilots WHERE numFlying < 90; -- data des pilotes qui font moins de 90h

SELECT name, street, city FROM compagnies
WHERE (SELECT compagny FROM pilots WHERE numFlying < 90); -- ne marche pas car la sous-requette renvoie plus d'un résultat

SELECT name, street, city FROM compagnies
WHERE comp IN (SELECT compagny FROM pilots WHERE numFlying < 90); -- résultat attendu

-- Faites la somme des heures de vols des pilotes de la compagnie d'Air France
SELECT SUM(numFlying) FROM pilots WHERE compagny = (SELECT comp FROM compagnies WHERE name = 'Air France'); -- possible car la sous-requette ne retourne qu'une seule donnée
SELECT SUM(numFlying) FROM pilots WHERE compagny IN (SELECT comp FROM compagnies WHERE name = 'Air France'); -- marche aussi et est plus générique

-- Ajoutez maintenant la compagnie suivante dans la table compagnies :
-- comp = ITA, street = mapoli, city = Rome, name = Italia Air, numStreet =  20
INSERT INTO compagnies SET comp='ITA', street='mapoli', city='rome', name='Italia Air', numStreet=20;

-- Trouvez toute(s) les/la compagnie(s) n'ayant pas de pilotes.
SELECT name FROM compagnies WHERE comp NOT IN (SELECT DISTINCT compagny FROM pilots);
SELECT name FROM compagnies as c WHERE NOT EXISTS (SELECT 1 FROM pilots as p WHERE p.compagny = c.comp);

-- ajouter ça :
ALTER TABLE pilots
ADD COLUMN plane
ENUM('A380', 'A320', 'A340') AFTER name;

