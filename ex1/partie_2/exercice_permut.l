
%{
%}

%%
a*b*          { printf("[%s]: des a d'abord et des b ensuite\n", yytext); }
(aa|bb)*((ab|ba)(aa|bb)*(ab|ba)(aa|bb)*)*  { printf("[%s]: pair pair\n", yytext); }
.             { /* ignorer */ }
%%


int yywrap() { 
    return 1; 
}

int main() {
    yylex();
    return 0;
}