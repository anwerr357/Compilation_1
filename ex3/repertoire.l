%{
#include <stdio.h>
%}

MAJ [A-Z]
MIN [a-z]
ALPHA [A-Za-z]
DIGIT [0-9]
BLANC [ \t]+

NOM {MAJ}{MIN}+
PRENOM ({MIN}+{BLANC})*{MIN}+
TELEPHONE ({DIGIT}{DIGIT}{BLANC}){4}{DIGIT}{DIGIT}

%%
{NOM}          { printf("NOM: %s\n", yytext); }
{PRENOM}       { printf("PRENOM: %s\n", yytext); }
"@"            { printf("SEPARATEUR: @\n"); }
{TELEPHONE}    { printf("TELEPHONE: %s\n", yytext); }
\n             { printf("FIN LIGNE\n"); }
.              ; /* Ignorer les autres caractères */
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}