-- Insérer un nouvel enregistrement dans la table :
-- (On insère une compagnie dans compagnies pour éviter une erreur ensuite)
INSERT INTO compagnies
VALUES ('AFRA', 'a roissy', 'Roissy', 'Air France', '48', 'published');
-- On insère dans pilots
INSERT INTO pilots
VALUES ('aze123', '123.5', 'AFRA', 'Johnson');
INSERT INTO pilots
VALUES ('zer458', null, 'AFRA', 'Sully');

INSERT INTO pilots
(certificate, name)
 VALUES ('gfhf41', 'Harry');

INSERT INTO pilots
(compagny)
 VALUES ('AFRA'); -- Marche pas parce que certificate et name ne peuvent pas être NULL

INSERT INTO pilots
SET certificate='sdf587', name='Ron';

-- Exemple pour insérer plusieurs enregistrement d'un coup dan sla table
INSERT INTO pilots (certificate, name, compagny)
VALUES
('wgt596', 'Hermione', 'AFRA'),
('cdd594', 'Sirius', 'AFRA'),
('mlk456', 'Lupin', 'AFRA');
-- Pas obligé de conserver l'ordre des champs tel qu'il est dans la table
-- Mais l'ordre des valeurs doit correspondre à l'ordres des champs indiqués

-- Pour voir le contenu de la table :
SELECT * FROM nom_de_la_table
-- Exemples :
SELECT * FROM compagnies;
SELECT * FROM pilots;

-- Insérez les données suivantes dans la table compagnies :

INSERT INTO compagnies
(comp, street, city, name, numStreet)
VALUES
('AUS', 'sidney', 'Australie', 'AUSTRA Air', '19'),
('CHI', 'chi', 'Chine', 'CHINA Air', NULL),
('FRE1', 'beaubourg', 'France', 'Air France', '17'),
('FRE2', 'paris', 'France', 'Air Electric', '22'),
('SIN', 'pasir', 'Singapour', 'SIN A', '15');

-- ## 01 Exercice Ajouter une colonne created
ALTER TABLE pilots ADD created DATETIME DEFAULT CURRENT_TIMESTAMP;

-- insérez les pilotes suivants:
INSERT INTO `pilots`
(`certificate`,`numFlying`,`compagny` ,`name`)
VALUES
    ('ct-1', 90, 'AUS', 'Alan' ),
    ('ct-12', 190, 'AUS', 'Albert' ),
    ('ct-7', 80, 'CHI', 'Pierre' ),
    ('ct-11', 200, 'AUS', 'Sophie' ),
    ('ct-6', 20, 'FRE1', 'Jhon' ),
    ('ct-10', 90, 'FRE1', 'Tom' ),
    ('ct-100', 200, 'SIN', 'Yi' ),
    ('ct-16', 190, 'SIN', 'Yan' ),
    ('ct-56', 300, 'AUS', 'Benoit' );

-- Si vous souhaitez vider complètement la table :
TRUNCATE la_table;
TRUNCATE pilots; -- par exemple

-- Exercice ajout d'une colonne et mise à jour
-- Ajoutez les colonnes birth_date, next_flight, num_jobs dans la table pilots
ALTER TABLE `pilots`
ADD birth_date DATE,
ADD next_flight DATETIME,
ADD num_jobs SMALLINT UNSIGNED DEFAULT 0;

-- Supprimer une table complète :
DROP TABLE la_table;
DROP TABLE pilots;

-- Pour modifier un champs en cas de besoin :
ALTER TABLE la_table
CHANGE le_champs_a_changer nouveau_nom_du_champs TYPE_DE_CHAMPS AUTRES_OPTIONS;
-- ex :
ALTER TABLE pilots CHANGE num_jobs num_jobs SMALLINT DEFAULT 0;

UPDATE `pilots`
SET `birth_date` = '1978-02-04 00:00:00',
 `next_flight` = '2020-12-04 09:50:52',
 `num_jobs` = 10
 WHERE name = 'Yi';
-- On modifie aussi les autre (voir code dans le cours)

-- ## Commande de suppression DELETE ou TRUNCATE
TRUNCATE pilots; -- Vide complètement la table (remet les auto-increment à 0)
DELETE FROM pilots; -- Vide complètement la table (conserve la valeur de l'auto-increment)

DELETE FROM pilots WHERE name = 'albert';
DELETE FROM pilots WHERE name = "albert" AND company = "AUS";

DROP TABLE new_pilots;