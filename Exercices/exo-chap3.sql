-- Exo 1
ALTER TABLE compagnies 
ADD status ENUM("published", "unpublished", "draft") DEFAULT "draft";

-- Ajout de la colonne numStreet
ALTER TABLE compagnies ADD numStreet INT UNSIGNED;

-- suppression de numStreet
ALTER TABLE compagnies DROP numStreet;

-- ré-ajout de la colonne numStreet APRES name
ALTER TABLE compagnies ADD numStreet INT UNSIGNED AFTER name;

-- Exo 2
-- Créer la table pilots
CREATE TABLE `pilots` (
`certificate` VARCHAR(6) NOT NULL,
`numFlying` DECIMAL(7,1) NULL,
`compagny` CHAR(4) NULL,
`name` VARCHAR(20) NOT NULL,
CONSTRAINT pk_pilots primary key (`certificate`)
) ENGINE=InnoDB ;

-- Ajouter une contrainte (foreign Key)
ALTER TABLE pilots ADD CONSTRAINT fk_pilots_compagny FOREIGN KEY (compagny) REFERENCES compagnies(`comp`);

-- Ajouter contrainte UNIQUE sur le champs name :
ALTER TABLE pilots ADD CONSTRAINT un_name UNIQUE (`name`) ;



-- supprimer une contrainte
ALTER TABLE pilots DROP INDEX `un_name`;

-- show all constraint
SELECT COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
FROM information_schema.KEY_COLUMN_USAGE
