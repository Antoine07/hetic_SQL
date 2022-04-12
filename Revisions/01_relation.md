# Révisions

## 01 exercices tables

Créez deux tables une table posts et une table categories avec les champs respectifs suivants :

- posts : title, content, published_at

- categories : title, description

Nous allons implémenter la relation : Un post peut avoir au plus une catégorie et une catégorie peut avoir de 0 à N posts. 

Correction :

```sql

DROP DATABASE IF EXISTS `db_blog`;

CREATE DATABASE IF NOT EXISTS `db_blog`
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

use db_blog;

CREATE TABLE `posts` (
    `id` BIGINT NOT NULL AUTO_INCREMENT, 
    `title` VARCHAR(100),
    `content` TEXT NULL,
    `published_at` DATETIME NULL,
    CONSTRAINT pk_posts PRIMARY KEY (`id`)
    ) ENGINE=InnoDB;

CREATE TABLE `categories` (
    `id` BIGINT NOT NULL AUTO_INCREMENT  , 
    `title` VARCHAR(100),
    `description` TEXT NULL,
    CONSTRAINT pk_posts PRIMARY KEY (`id`)
    ) ENGINE=InnoDB ;

``` 

Relation entre les deux tables 

```sql
ALTER TABLE `posts` 
ADD COLUMN `category_id` BIGINT NULL AFTER `id`;

ALTER TABLE `posts` 
ADD CONSTRAINT `fk_posts_categories_id` 
    FOREIGN KEY (`category_id`) 
    REFERENCES `categories` (`id`);
```

implémentez la relation entre les deux tables avec un atler table.

- 1. Création de la catégorie PHP

```sql
INSERT INTO categories SET title="PHP";

INSERT INTO posts SET title="les nouvelles features de PHP", category_id = 1 ;
INSERT INTO posts SET title="PHP est-il asynchrone ?", category_id = 1 ;
```

- Impossible si il existe des/une référence(s) dans la table posts à cette catégorie dont la clé id est égale à 1.

```sql
DELETE FROM categories WHERE id = 1 ;
```

- Supposons que la catégorie 190 n'existe, la commande suivante est bloquée :

```sql
INSERT INTO posts SET title="Python expressivité", category_id = 190 ;
