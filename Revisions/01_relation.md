# Relation révision

## 01 exercices tables

Créez deux tables une table posts et une table categories avec les champs respectifs suivants :

- posts : title, content, published_at

- categories : title, description

Nous allons implémenter la relation : Un post peut avoir au plus une catégorie et une catégorie peut avoir de 0 à N posts. 

Correction :

```sql

CREATE TABLE `posts` (
     `id` INT  
    `title` VARCHAR(100),
    `content` TEXT NULL,
    `publish_at` DATETIME NULL,
    CONSTRAINT pk_posts PRIMARY KEY (`id`)
    ) ENGINE=InnoDB ;

CREATE TABLE `categories` (
     `id` INT  
    `title` VARCHAR(100),
    `description` TEXT NULL,
    CONSTRAINT pk_posts PRIMARY KEY (`id`)
    ) ENGINE=InnoDB ;

``` 