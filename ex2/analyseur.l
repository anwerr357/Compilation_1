%{
#include <stdlib.h>

int mots = 0;
int lignes = 1; // Commence à 1 car la première ligne compte comme ligne 1
int caracteres = 0;
int somme_nombres = 0;
%}

CHIFFRE [0-9]
LETTRE [a-zA-Z]
MOT {LETTRE}+
NOMBRE {CHIFFRE}+

%%
{NOMBRE} {
    somme_nombres += atoi(yytext);
    mots++;
    caracteres += yyleng;
}

{MOT} {
    mots++;
    caracteres += yyleng;
}

"\n" {
    lignes++;
    caracteres++;
}

. {
    caracteres++;
}
%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    yylex();
    
    FILE *fichier = fopen("resultat.txt", "w");
    if (fichier == NULL) {
        perror("Erreur lors de l'ouverture du fichier");
        return 1;
    }
    
    fprintf(fichier, "Résultats de l'analyse :\n");
    fprintf(fichier, "------------------------\n");
    fprintf(fichier, "Nombre de mots : %d\n", mots);
    fprintf(fichier, "Nombre de lignes : %d\n", lignes);
    fprintf(fichier, "Nombre de caractères : %d\n", caracteres);
    fprintf(fichier, "Somme des nombres : %d\n", somme_nombres);
    
    fclose(fichier);
    return 0;
}