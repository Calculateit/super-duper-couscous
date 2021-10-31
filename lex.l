%{
	#include <string>
	#define YYSTYPE std::string
	#include "parser.tab.hpp"
	
   	
	void yyerror(char *s);
%}

%option yylineno
%option noyywrap

%%
	
[/][/]*\n      ;//Comment
	
if				return IF;//IF terminals
fi				return FI;
else			return ELSE;
	
then            return THEN;//Common IF terminals
	
for             { return FOR_; }
while           return WHILE;
	
do				{ return DO; }
done			{ return DONE; }

"=="            return EQ;//Condition terminals
"<="            return LE;
>=              return GE;
!=              return NE;
&&				return AND;
"||"			return OR;

echo           	{ return ECHO_; }

[0-9]+          { 
					yylval = yytext;
                  	return NUM;
                }
                
[a-zA-Z_][a-zA-Z0-9_]* 	{ 	
							yylval = yytext;
                  			return ID;
            		    }
[ \t\r\n]       ;//Whitespace

[-;()\[\]=<>+"*/!$%] { return *yytext; }
.               yyerror("Invalid character\n");

%%
