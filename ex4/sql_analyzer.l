%{
#include <stdio.h>
#include <string.h>

void print_token(const char* type, const char* value);
%}

BLANK [ \t\n]
LETTER [A-Za-z]
DIGIT [0-9]
ALPHANUM [A-Za-z0-9_]
TYPE "int"|"varchar"|"DATE"
KEYWORD "CREATE"|"TABLE"

%%

"PRIMARY KEY"   { print_token("CONSTRAINT", yytext); }
"CREATE"        { print_token("KEYWORD", yytext); }
"TABLE"         { print_token("KEYWORD", yytext); }
{TYPE}          { print_token("TYPE", yytext); }
"("             { print_token("PAREN_OPEN", "("); }
")"             { print_token("PAREN_CLOSE", ")"); }
","             { print_token("COMMA", ","); }
{DIGIT}+        { print_token("NUMBER", yytext); }
{LETTER}{ALPHANUM}*  {
    /* Vérification exhaustive des mots-clés */
    if (strcmp(yytext, "PRIMARY") != 0 && 
        strcmp(yytext, "KEY") != 0 &&
        strcmp(yytext, "CREATE") != 0 &&
        strcmp(yytext, "TABLE") != 0)
        print_token("IDENTIFIER", yytext);
    else
        print_token("KEYWORD", yytext);
}
{BLANK}+        ; /* Ignore les espaces */
.               { print_token("UNKNOWN", yytext); }

%%

void print_token(const char* type, const char* value) {
    printf("%-15s: %s\n", type, value);
}

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}