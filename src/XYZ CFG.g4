grammar XYZ;

program : '{' block '}' ;

block : (declaration)* (command)*  ;

declaration : datatype identifier '.' | datatype assignment_operator ;

datatype : 'int' | 'string' | 'bool' ;

command : assignment_operator | control_statements | print_statement  ;

assignment_operator : identifier '=' expression '.' ;

expression : digits | identifier | bool_expression | arithemetic_expression | ;

bool_expression : 'not' identifier | 'not'  bool_values  | identifier 'and' identifier | identifier 'or' identifier | bool_values 'and' bool_values | bool_values 'or' bool_values | bool_values ;

arithemetic_expression : arithemetic_expression1 '+' arithemetic_expression | arithemetic_expression1 '-' arithemetic_expression | arithemetic_expression1;

arithemetic_expression1 : ident_number '*' arithemetic_expression1 |  ident_number '/' arithemetic_expression1 | ident_number;

ident_number : identifier | digits ;

control_statements : if_control_statement | while_control_statement ;

if_control_statement : 'if' '(' conditional_statement ')' 'then'  '{' block '}' 'else' '{' block '}' ;

while_control_statement : 'while' '(' conditional_statement ')' '{' block '}' ;

conditional_statement : expression conditional_operators expression | bool_values ;

identifier :  lowerChar (upperChar |lowerChar  | digits)* ;

conditional_operators :  '=='| '<'| '>'| '<='| '>='| '!=';

bool_values : 'true'| 'false' ;

print_statement : 'print' '(' expression ')' '.';


digits : (digit)+;
digit : '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' ;
lowerChar : 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm' | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z' ;
upperChar : 'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G' | 'H' | 'I' | 'J' | 'K' | 'L' | 'M' | 'N' | 'O' | 'P' | 'Q' | 'R' | 'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z' ;

Comment_statement : '/#' (.)*? '#/' -> skip;
WS: [ \t\r\n]+ -> skip ;