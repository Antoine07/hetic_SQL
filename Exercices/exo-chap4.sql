-- Insérer un nouvel enregistrement dans la table :
-- (On insère une compagnie dans compagnies pour éviter une erreur ensuite)
INSERT INTO compagnies
VALUES ('AFRA', 'a roissy', 'Roissy', 'Air France', '48', 'published');

-- Afficher le contenu d'une table (pour vérifier ce qui s'ajoute dedans)
SELECT * FROM nom_de_la_table
-- Exemples :
SELECT * FROM compagnies;
SELECT * FROM pilots;


-- On insère dans pilots
INSERT INTO pilots
VALUES ('aze123', '123.5', 'AFRA', 'Johnson'); -- ==> ok

INSERT INTO pilots
VALUES ('aze123', '123.5', 'Johnson'); -- plante car pas le bon nombre de champs
-- on peut eventuellement corriger comme ça :
INSERT INTO pilots
VALUES ('aze124', '123.5', null, 'Johnson');

INSERT INTO pilots
(certificate, name)
VALUES ('sdfs12', 'Sully');

INSERT INTO pilots (certificate) VALUES ('sdfs13'); -- Plante car name ne peut pas être NULL

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

INSERT INTO pilots (certificate, name, compagny)
VALUES
('wgt597', 'Harry', null);

-- Remplir table compagnies
INSERT INTO compagnies 
(comp, street, city, name, numStreet, status) 
VALUES
('AUS', 'sidney', 'Australie', 'AUSTRA Air', 19, 'draft'),
('CHI', 'chi', 'Chine', 'CHINA Air', NULL, 'draft'),
('FRE1', 'beaubourg', 'France', 'Air France', 17, 'draft'),
('FRE2', 'paris', 'France', 'Air Electric', 22, 'draft'),
('SIN', 'pasir', 'Singapour', 'SIN A', 15, 'draft');

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

-- ## 02 Exercice ajout d'une colonne et mise à jour
ALTER TABLE pilots ADD birth_date DATETIME;
ALTER TABLE pilots ADD next_flight DATETIME;
ALTER TABLE pilots ADD num_jobs SMALLINT UNSIGNED DEFAULT 0;
-- ou bien en une seule fois :
ALTER TABLE pilots 
ADD birth_date DATETIME,
ADD next_flight DATETIME,
ADD num_jobs SMALLINT UNSIGNED DEFAULT 0;

-- Pour modifier un champs en cas de besoin :
ALTER TABLE la_table CHANGE le_champs_a_changer nouveau_nom_du_champs_si_besoin TYPE_DE_CHAMPS AUTRES_OPTIONS;
-- ex :
ALTER TABLE pilots CHANGE num_jobs num_jobs SMALLINT DEFAULT 0;
ALTER TABLE pilots CHANGE next_flying next_flight DATETIME;

-- ## Commande de suppression DELETE ou TRUNCATE
TRUNCATE la_table;
TRUNCATE pilots; -- Vide complètement la table (remet les auto-increment à 0)
DELETE FROM pilots; -- Vide complètement la table (conserve la valeur de l'auto-increment)

DELETE FROM pilots [WHERE (condition)];
DELETE FROM pilots WHERE name = 'Johnson';
DELETE FROM pilots WHERE name = "albert" AND company = "AUS";

-- Ne pas confondre TRUNCATE la_table avec DROP TABLE la_table
DROP TABLE la_table; -- Suprime TOUT, y compris la table elle-même !

-- ## 03 Exercice sauvegarde et suppression (facultatif)
-- dupliquer la table pilots dans new_pilots :
CREATE TABLE `new_pilots` (SELECT * FROM `pilots`);