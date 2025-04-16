%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int ligne = 1;

void erreur(const char* type, const char* lexeme) {
    printf("%s ** Erreur : ligne %d ** %s\n", lexeme, ligne, type);
}
%}

DIGIT   [0-9]
ID      [a-zA-Z_][a-zA-Z0-9_]*
REEL    [-+]?{DIGIT}+\.[0-9]*([eE][+-]?{DIGIT}+)?|[-+]?\.{DIGIT}+([eE][+-]?{DIGIT}+)?|[-+]?{DIGIT}+[eE][+-]?{DIGIT}+
ENTIER  [-+]?{DIGIT}+
ESPACE  [ \t]+
NL      (\r\n|\r|\n)

%%

{NL}                    { ligne++; }
{ESPACE}                { /* Ignorer */ }

\"([^\"\n]*)\"          { printf("CHAINE : %s\n", yytext); }
\"[^\"\n]*              { erreur("fin de chaîne attendue", yytext); }

if|else|while           { printf("MOTCLE : %s\n", yytext); }

"<="|">="|"=="|"!="|"<"|">" { printf("OP-REL : %s\n", yytext); }
"="                      { printf("AFFECT : %s\n", yytext); }
"+"|"-"|"*"|"/"          { printf("OP-ARTHM : %s\n", yytext); }

"#"[^\n]*               { printf("COMMENTAIRE : %s\n", yytext); }
"#fin"                  { erreur("#attendu", yytext); }

{REEL}                  { printf("REEL : %f\n", atof(yytext)); }
{ENTIER}                { printf("ENTIER : %s\n", yytext); }

{ID}                    { printf("IDENT : %s\n", yytext); }

{DIGIT}+[eE]            { erreur("exposant attendu", yytext); }
{DIGIT}+{ID}            { erreur("identificateur mal formé", yytext); }
[-+]{ID}                { erreur("nombre attendu", yytext); }

.                       { erreur("lexème inconnu", yytext); }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) {
            perror("Fichier introuvable");
            exit(1);
        }
        yyin = f;
    }
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
