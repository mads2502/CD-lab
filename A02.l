%{
	#include<stdio.h>
	#include<string.h>
     int flag=0,f1=0,f2=0;
     char val[10][2];
     char ids[10][15];
     int typ[10];
     int pos1=0,pos2=0,pos3=0;
%}
multicomm  ^\/\*
multicommend (\*\/)$
key       auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while
func      (printf|scanf|getch|clrscr|main)\(.*\)
identifier [A-Za-z][A-Za-z0-9]*
num       [0-9][0-9]* 
ft        [0-9][0-9]*\.[0-9][0-9]*  
arith     [\+\-%\*]
arithssign [\+\-%\*]\=
relational [\<\>!]\=*|\=\=
assign     \=
logical    &&|\|\||!
bitwise   \<\<|\>\>|&|\^
unary     \+\+|--|-
special   [\[\]\{\}\(\),;\.]
prepro    ^#.*
comm     ^\\\\.*
newlne    \n
stringy  ^".*"$
%%
{multicomm} {flag=1;printf("%s-Multi-Line comment\n",yytext);}
{num}  {if(flag==0){printf("%s-Integer Constant\n",yytext);if(f1){strcpy(val[pos2++],yytext);typ[pos3++]=2;}}}
{ft} {if(flag==0){printf("%s-Float\n",yytext);if(f2){strcpy(val[pos2++],yytext);typ[pos3++]=4;}}}
{comm}  {if(flag==0)printf("%s-Single Line comment\n",yytext);}
{stringy}  {if(flag==0)printf("%s-String constant\n",yytext);else printf("%s-Comment",yytext);}
{key} {if(flag==0){printf("%s-Keyword\n",yytext);if(strcmp(yytext,"int")==0){f1=1;}else f1=0;if(strcmp(yytext,"float")==0){f2=1;}else f2=0;}else printf("%s-Comment\n",yytext);}
{func} {if(flag==0)printf("%s-Function call\n",yytext);}
{identifier} {if(flag==0){printf("%s-Identifier\n",yytext);strcpy(ids[pos1++],yytext); }else printf("%s-Comment\n",yytext);}
{arith}  {if(flag==0)printf("%s-Arithmetic operator\n",yytext);}
{arithssign} {if(flag==0)printf("%s-Arithmetic Assignment operator\n",yytext);}
{relational} {if(flag==0)printf("%s-Relational operator\n",yytext);}
{logical} {if(flag==0)printf("%s-Logical operator\n",yytext);}
{bitwise} {if(flag==0)printf("%s-Bitwise operator\n",yytext);}
{unary} {if(flag==0)printf("%s-Unary operator\n",yytext);}
{special} {if(flag==0)printf("%s-Special character\n",yytext);}
{prepro} {if(flag==0)printf("%s-Pre processor statement\n",yytext);}
{assign}  {if(flag==0)printf("%s-Assignment operator\n",yytext);}

{multicommend} {flag=0;printf("%s-End of multi-line comment\n",yytext);}
%%
main(){
	FILE *yyin;
	int i=0,addr=1000;
	yyin=fopen("code_02.txt","r");
	yyset_in(yyin);
    yylex();
    printf("\nSymbol table\n");
    printf("Name\tValue\tSize\tAddress\n");
    printf("----\t-----\t----\t-------\n");
    for(i=0;i<pos2;i++){
printf("\n%s\t%s\t%d\t%d-%d\n",ids[i],val[i],typ[i],addr,addr+typ[i]);
addr=addr+typ[i];
    }
    return 0;

}
