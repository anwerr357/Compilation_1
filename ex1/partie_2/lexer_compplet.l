%%
[a-zA-Z][a-zA-Z0-9]*    { printf("ID: %s\n", yytext); }
[0-9]+                   { printf("NB: %s\n", yytext); }
.                        { /* ignorer */ }
%%

int yywrap() { return 1; }

int main() {
    yylex();
    return 0;
}