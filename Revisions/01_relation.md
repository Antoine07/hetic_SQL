# Révisions

## 01 exercices tables

Créez deux tables une table posts et une table categories avec les champs respectifs suivants :

- posts : title, content, published_at

- categories : title, description

Nous allons implémenter la relation : Un post peut avoir au plus une catégorie et une catégorie peut avoir de 0 à N posts. 

Correction :

```sql

CREATE DATABASE IF NOT EXISTS `db_blog`
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


use db_blog;

CREATE TABLE `posts` (
    `id` BIGINT NOT NULL AUTO_INCREMENT, 
    `title` VARCHAR(100),
    `content` TEXT NULL,
    `publish_at` DATETIME NULL,
    CONSTRAINT pk_posts PRIMARY KEY (`id`)
    ) ENGINE=InnoDB ;

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