# Procdures stockées (stored procedure )

Lorsque vous avez une requête qui doit-être exécutée plusieurs fois par jour par différents utilisateurs, vous pouvez utiliser une procdéure stockée. Une procédure stockée est équivalent à la notion de fonction dans d'autres langages.

```sql
DELIMITER |
CREATE PROCEDURE pilots_compagny (IN comp CHAR(4))
BEGIN
    SELECT name, salary
    FROM pilots
    WHERE compagny = comp;
END |
DELIMITER ; 
```

Attention vous devez remettre le délimiteur par défaut à la fin de la procédure.

Vous commencerez une procédure stockée par BEGIN et la terminerée par END. Vous devez utiliser un délimiter différent de ";"

Le mot réservé IN indique un paramètre entrant dans la procédure. Vous avez également le mot réservé OUT ou INOUT pour les paramètres sortant ou entrant/sortant.

Notez que si vous ne précisez pas le paramètre entrant/sortant il sera par défaut entrant. Vous devez comme pour une fonction donnez un nom et un type.

Dans votre terminal vous pouvez maintenant appeler la procédure comme suit :

```sql
CALL pilots_compagny('AUS');
```

Pour supprimer votre procédure vous devez taper la ligne de code suivante :

```bash
DROP PROCEDURE pilots_compagny;
```

## Paramètre sortant

Voici la syntaxe pour un paramètre sortant, attention le paramètre sortant ne peut avoir qu'une seule valeur sortante. Vous créez plusieurs paramètres sortants.

```sql
DELIMITER |
CREATE PROCEDURE get_count (OUT nb INT) 
    BEGIN
        SELECT COUNT(*) INTO nb FROM pilots;
    END
    |
DELIMITER ; 
```

Dans MySQL sur la base db_aviation, vous devez tapez la ligne de commande suivante pour exécuter la procédure :

```sql
set @n = 0;
CALL get_count(@n);
SELECT @n;
```

## 01 Exercices

1. Créez une procédure qui affiche la liste des noms pilotes.

2. Créez une procédure qui affiche les compagnies qui employent plus de 2 pilotes.

3. Créez une procédure qui affiche les compagnies qui n'ont pas de pilote.

4. Créez une procédure qui affiche la somme des heures de vols pour un pilote.

5. Créez une procédure qui affiche les pilotes d'une compagnie donnée.

6. Créez une procédure qui affiche les noms des pilotes avec leurs bonus ordonnées par ordre décroissant de bonus.

7. Créez une procédure permettant de calculer la moyenne des salaires des pilotes d'une compagnie donnée.

8. Créez une procédure qui retourne 1 ou 0 si la compagnie a respectivement des pilotes ou aucun pilote.

9. Créez une procédure qui augmente tous les salaires de 10% si ce dernier est pair.

10. Créez une procédure qui augmente tous les salaires de 10% si ce dernier est pair ordonné par ordre décroissant de salaire avec un colonne d'indice commençant par 1 incrémenté.

Voyez les indications en fin de documents

## 02 Exercice algo

Créez une procédure afin de déterminer si on a un nombre pair ou impair de ligne dans la table pilots. 

## Indications

Pour compter le nombre de ligne(s) vous pouvez utiliser la commande suivante :

```sql
SELECT @row:=@row+1 as `row` 
FROM pilots , (SELECT @row:=0) AS r;
```

Vous pouvez également dans la procédure stockée utiliser des conditions voyez les syntaxes suivantes :

```sql
IF condition THEN
    -- TODO
ELSE
    -- TODO
END IF;
```

Et enfin vous pouvez définir des variables dans la procédures comme suit :

```sql
DECLARE s INT DEFAULT 0;
```


## Transaction

C'est un ensemble de requêtes qui sont exécutées en un seul bloc, si l'une d'entre elle échoue on peut tout annuler.

Vous ne pouvez utiliser les transactions que sur des tables de type InnoDB.

Lorsque vous validez une requête d'une transaction on dit qu'on commit les changements. Et à l'inverse lorsqu'on annule des requêtes on fait un rollback.

Par défaut MySQL est en mode autocommit. Pour activer le mode transactionnel il faut taper pour la session en cours :

```sql
SET autocommit=0;
```

Pensez à remettre le mode autocommit à 1, valeur par défaut pour la session en cours.

Les commandes suivantes permettent de commiter ou de faire un rollback :

```sql
COMMIT; -- valider
ROLLBACK; -- annuler
```

## 03 Exercice

Tapez les lignes de commandes suivantes, que constatez-vous ? Que faudra-t-il faire pour valider les requêtes dans le bloc ?

```sql
SET autocommit=0;

INSERT INTO pilots (certificate,name) VALUES ('C-00', 'anonymous');

SELECT name FROM pilots;

ROLLBACK;

SELECT name FROM pilots;

SET autocommit=1;

```

Remarques importantes : 

1. un commit ou rollback met fin à la transaction. 

2. Attention, toutes les commandes DDL valident automatiquement les transactions.

3. La commande LOAD DATA provoque une validation.

4. Vous ne pouvez/devez pas imbriquer des transaction. 


## Commande START TRANSACTION

Cette commande permet d'ouvrir le mode transactionnel un commit ou rollback terminera ce mode.

Attention si vous imbriquez les transactions avec START TRANSACTION les transactions seront validés.


## Définir une transaction dans une procédure

Voici un exemple qui permettra d'invalider un bloc requêtes si l'une d'entre elle échoue, testez-le :

```sql
DROP PROCEDURE p1;

DELIMITER | 
CREATE PROCEDURE p1()
BEGIN
    DECLARE EXIT HANDLER  FOR SQLEXCEPTION
    BEGIN
        SELECT 'SQLEXCEPTION handler was activated' AS msg;
        ROLLBACK;
    END ;
    START TRANSACTION;
        INSERT INTO pilots (certificate, name) VALUES ('cc', 'ano');
        INSERT INTO pilots (certificate, name) VALUES ('cc', 'ano');
    COMMIT;

END |

DELIMITER ; 
```

## ACID

C'est un acronyme, dont la signification est décrite ci-dessous et que l'on applique au mode transactionnel :

**A** pour atomique : chaque requête d'une transaction ne peut exister que dans le bloc spécifique. Par exemple débiter un compte puis créditer un autre compte dans un processus de commande est indivisible.

**C** pour cohérence : l'état de vos données doivent restées cohérent. Par exemple un virement d'un client sur le compte d'un site de vente en ligne doit déclencher une commande.

**I** isolation des transactions : chaque transaction ne doit pas affecter une autre transaction. Cela peut intervenir lorsqu'on ouvre plusieurs sessions et que l'on fait des transactions.

**D** durabilité : les données stockées doivent ne sont pas perdu.
