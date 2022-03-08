-- moyenne d'heures de vol par compagnies
SELECT compagny, AVG(numFlying) as MoyenneVol FROM pilots GROUP BY compagny;

-- Calculez la moyenne des heures de vols des pilotes dont le bonus est de 500, par compagnie
SELECT AVG(numFlying) AS Moyenne_vol 
FROM pilots 
WHERE bonus = 500 
GROUP BY compagny;

-- Sélectionnez les compagnies et leur nombre de pilote(s), ayant plus d'un pilote
SELECT compagny, COUNT(*) AS nb_pilots FROM pilots GROUP BY compagny; -- on a le nb de pilotes par compagny, mais tous.
SELECT compagny, COUNT(*) AS nb_pilots FROM pilots GROUP BY compagny HAVING COUNT(*) > 1; -- avec Having on ajoute la condition de n'avoir que les compagny  avec plus d'un pilote
SELECT compagny, COUNT(*) AS nb_pilots FROM pilots GROUP BY compagny HAVING nb_pilots > 1; -- Idem que ci-dessus, mais on peut utiliser l'alias créé dans la condition

-- Sélectionnez le nombre de pilote(s) par compagnie et par type d'avion
SELECT compagny, plane, COUNT(*) AS nb_pilots FROM pilots GROUP BY compagny, plane;

-- Sélectionnez le noms des pilotes par bonus
SELECT bonus, name FROM pilots GROUP BY bonus; -- Plante, le name doit être aussi dans la clause GROUP BY
SELECT bonus, name FROM pilots GROUP BY bonus, name; -- affiche les résultats, mais on a plusieurs fois les bonnus d'une même valeur
SELECT bonus, GROUP_CONCAT(name) FROM pilots GROUP BY bonus; -- on concatène les noms, ce qui évite les répétitions des bonus

-- Sélectionnez la compagnie, le bonus et les noms des pilotes par compagny et par bonus
SELECT compagny, bonus, GROUP_CONCAT(`name`) 
FROM pilots GROUP BY compagny, bonus;

-- Sélectionnez le noms des pilotes par bonus
SELECT name, bonus FROM pilots GROUP BY name, bonus; -- pas ce qu'on veut
SELECT name, bonus FROM pilots GROUP BY bonus, name; -- -> Mieux mais pas ce qu'on veut
SELECT bonus, GROUP_CONCAT(name) FROM pilots GROUP BY bonus; -- Youpi !

-- Sélectionnez le noms et la compagnie des pilotes par bonus
SELECT GROUP_CONCAT(`name`), GROUP_CONCAT( `compagny`), `bonus`
FROM `pilots`
GROUP BY `bonus`;
-- Avec DISTINCT, on évite les répétitions inutiles dans la colonne compagny :
SELECT GROUP_CONCAT(`name`), GROUP_CONCAT(DISTINCT `compagny`), `bonus`
FROM `pilots`
GROUP BY `bonus`;

-- Calculez l'étendue du nombre d'heure de vol par compagnie
-- (le max moins le min)
SELECT compagny, (MAX(numFlying) - MIN(numFlying)) AS etendue FROM pilots GROUP BY compagny;
-- Autre possibilité : avoir les Min et Max des heures de vol par compagnie
SELECT compagny, MIN(numFlying) AS minFly, MAX(numFlying) AS maxFly FROM pilots GROUP BY compagny;
-- On peut concaténer les Min et Max pour avoir une résultat plus lisible :
SELECT compagny, CONCAT(MIN(numFlying), ' à ', MAX(numFlying)) as plageFlying FROM pilots GROUP BY compagny;

-- Faites la somme du nombre de jours de vols par compagnie dont la somme est supérieur à 30
SELECT compagny, SUM(numFlying) AS sumFly FROM pilots GROUP BY compagny; -- Somme des heures par compagny
SELECT compagny, SUM(numFlying)/24 AS flyDays FROM pilots GROUP BY compagny; -- Nb de jour (24h) par compagny
SELECT compagny, SUM(numFlying)/24 AS flyDays FROM pilots GROUP BY compagny HAVING flyDays > 30; -- résultat final demandé