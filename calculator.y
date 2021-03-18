%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
   #include "calculator.tab.h"
    #include<math.h>
    int yylex(void);

%}
%token INTEGER
%%
program : line program
        | line
line : expr '\n' {printf("Ans : %d\n",$1);}
expr : expr '+' mulex {$$=$1+$3;}
     | expr '-' mulex {$$=$1-$3;}
     | mulex {$$=$1;}
mulex : mulex '*' expoex {$$=$1*$3;}
      | mulex '/' expoex {$$=$1/$3;}
      | expoex {$$=$1;}
expoex : expoex '^' term {$$=pow($1,$3);}
       | boolex {$$=$1;}
boolex : boolex '&' boolex {$$=$1&$3;}
       | boolex '|' boolex {$$=$1|$3;}
       | compex {$$=$1;}
compex : compex '>' compex {$$=$1>$3;}
       | compex '<' compex {$$=$1<$3;}
       | bitex {$$=$1;}
bitex : bitex '<<' bitex {$$=$1<<$3;}
      | bitex '>>' bitex {$$=$1>>$3;}
      | relex {$$=$1;}
relex : relex '==' relex {$$=($1==$3);}
      | relex '!=' relex {$$=($1!=$3);}
      | condex {$$=$1;}
condex : condex '?' condex ':' condex {$$=$1?$3:$5;}
       | term {$$=$1;}
term : '(' expr ')' {$$=$2;}
     | INTEGER {$$=$1;}

%%
/*Madhumitha S 185001086*/
/*the above gives the productions with precedence in consideration*/

void yyerror(char* s){
    fprintf(stderr,"%s\n",s);
}
void yywrap(){
    return 1; 
}
int main(){
    yyparse();//calling the parse function for YACC file
    return 0;
}


