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
