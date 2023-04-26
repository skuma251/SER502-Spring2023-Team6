%:- use_rendering(svgtree).
:- table  dec/3,arth/3, arth2/3.
%Grammar rule for  Program
program(t_prog(T1)) --> ['{'], block(T1),['}'].

%Grammar rule for block
block(t_block(T1)) --> dec(T1).
block(t_block(T1,T2)) --> dec(T1), block(T2).

dec(t_dec(T1)) --> dec1(T1), ['.'].
dec(t_dec(T1,T2)) --> dec1(T1),['='],exp(T2),['.'].
dec(t_dec(T1)) --> cond(T1).

%Grammar for expression
exp(t_exp(T1)) --> number(T1).
exp(t_exp(T1)) --> boolexp(T1). 
exp(t_exp(T1)) --> ident(T1).
exp(t_exp(T1)) --> arth(T1).

% Grammar for arithemetic expression    
arth(t_add(T1,T2)) --> arth(T1),[+], arth2(T2).
arth(t_sub(T1,T2)) --> arth(T1),[-], arth2(T2).
arth(T1) --> arth2(T1).
arth2(t_mul(T1,T2)) --> arth2(T1), [*], arth3(T2).
arth2(t_div(T1,T2)) --> arth2(T1), [/], arth3(T2).
arth2(T1) --> arth3(T1).
arth3(T1) --> number(T1).
arth3(T1) --> ident(T1).

%Grammar for conditions
cond(t_if(T1,T2,T3)) --> [if],['('] ,conds(T1),[')'], [then],['{'], block(T2), ['}'], [else], ['{'], block(T3), ['}'].
cond(t_while(T1,T2)) --> [while],['('],conds(T1),[')'],['{'], block(T2), ['}'].
cond(t_for(T1,T2,T3,T4)) --> [for],['('],forupd(T1),[';'],conds(T2),[';'],forupd(T3),[')'],['{'],block(T4),['}'].
cond(t_forrange(T1,T2,T3,T4)) --> [for], ident(T1),[in],[range],['('],number(T2),[','],number(T3),[')'],['{'],block(T4),['}'].

%Grammar rule for ternary
tern(t_tern(T1,T2,T3,T4,T5)) --> ['('], ident(T1), condop(T2), ident(T3),[')'], ['?'], exp(T4),[':'], exp(T5).

%Grammar rule for forupdate
forupd(t_forupd(T1,T2)) --> ident(T1),['='],exp(T2).

%Grammar for boolean expression
boolexp(t_not(T1)) --> ['not'],ident(T1).
boolexp(t_not(T1)) --> ['not'],bool(T1).
boolexp(t_equal(T1)) --> bool(T1).
boolexp(t_and(T1,T2)) --> ident(T1),['and'],ident(T2).
boolexp(t_and(T1,T2)) --> bool(T1),['and'],bool(T2).
boolexp(t_or(T1,T2)) --> ident(T1),['or'],ident(T2).
boolexp(t_or(T1,T2)) --> bool(T1),['or'],bool(T2).
% Comments from TA 
%boolexp(t_and(T1,T2)) --> ident(T1),['and'],bool(T2).
%boolexp(t_and(T1,T2)) --> bool(T1),['and'],ident(T2).
%boolexp(t_or(T1,T2)) --> ident(T1),['or'],bool(T2).
%boolexp(t_or(T1,T2)) --> bool(T1),['or'],ident(T2).


%Grammar for cond statement
conds(t_condst(T1,T2,T3)) --> exp(T1), condop(T2),exp(T3).
conds(t_condst(T1)) --> bool(T1).

%Grammar for conditonal operator
condop(t_comp(==)) --> ['=='].
condop(t_comp(<)) --> ['<'].
condop(t_comp(>)) --> ['>'].
condop(t_comp(<=)) --> ['<','='].
condop(t_comp(>=)) --> ['>','='].
condop(t_comp('!=')) --> ['!','=']. % Need to fix this unbalanced operator
    
%Grammar rules for declaration
dec1(t_var(T1)) --> [int], ident(T1).
dec1(t_var(T1)) --> [bool], ident(T1).
dec1(t_var(T1)) --> [string], ident(T1).

% Grammar rule for boolean
bool(t_true()) --> [true].
bool(t_false()) --> [false]. 

%Grammar rules for identifier
ident(t_ident(x)) --> [x]. 
ident(t_ident(y)) --> [y]. 
ident(t_ident(z)) -->[z]. 
ident(t_ident(u)) --> [u]. 
ident(t_ident(v)) --> [v]. 


%Grammar rules for numbers
number(t_num(0)) -->['0']. 
number(t_num(1)) -->['1']. 
number(t_num(2)) -->['2']. 
number(t_num(3)) -->['3']. 
number(t_num(4)) -->['4']. 
number(t_num(5)) -->['5']. 
number(t_num(6)) -->['6']. 
number(t_num(7)) -->['7']. 
number(t_num(8)) -->['8']. 
number(t_num(9)) -->['9'].


% Test cases
%Test case for for. loop
%program(P,['{', 'int', 'x', '=', '0', '.', 'for', '(', 'x', '=', '0', ';', 'x', '<', '9', ';', 'x', '=', 'x', '+', '1', ')', '{', 'int', 'z', '=', '0', '.', '}', '}'], []).
%Test case for for range
%program(P,['{','int', 'x', '=', '0', '.', 'for', 'x', 'in', 'range', '(', '0', ',', '5', ')', '{', 'int', 'z', '=', '0', '.', '}', '}'], []).