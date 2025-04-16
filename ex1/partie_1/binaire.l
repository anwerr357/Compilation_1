%{
#include <stdio.h>
%}

%%

[01]+      { printf("Nombre binaire valide : %s\n", yytext); }
.|\n       { printf("Ce n'est pas un nombre binaire : %s\n", yytext); }

%%

int main(int argc, char **argv)
{
    ++argv, --argc;
    if (argc > 0)
        yyin = fopen(argv[0], "r");
    else
        yyin = stdin;

    yylex();
    return 0;
}
