CREATE TABLE utilisateur
(
    iduser int PRIMARY KEY,
    nom varchar(100),
    prenom varchar(100),
    date_naissance DATE,
    ville varchar(255),
    code_postal varchar(5)
)