:- table  dec/3,term/3, expr/3.

%Grammar rule for  Program
program(t_prog(T1)) --> block(T1).

%Grammar rule for block
block(t_block(T1,T2)) -->  ['{'], dec(T1), cmd(T2), ['}'].

dec(t_multdec(T1,T2)) --> singledec(T1), [.], dec(T2).
dec(t_singledec(T1)) --> singledec(T1), [.].

singledec(t_declr_var(T1, T2, T3)) --> datatype(T1), ident(T2), ['='], exp(T3).

exp(t_multi_exp(T1,T2)) --> ident(T1), ['='], exp(T2).
exp(t_exp(T1)) --> expr(T1).

expr(t_add(T1,T2)) --> expr(T1), [+], term(T2).
expr(t_sub(T1,T2)) --> expr(T1), [-], term(T2).
expr(T1) --> term(T1).

term(t_mul(T1,T2)) --> term(T1), [*], term1(T2).
term(t_div(T1,T2)) --> term(T1), [/], term1(T2).
term(T1) --> term1(T1).
term1(T1) --> ident(T1).
term1(T1) --> number(T1).

cmd(t_multicmd(T1,T2)) --> singlecmd(T1), cmd(T2).
cmd(t_singlecmd(T1)) --> singlecmd(T1).
cmd() --> [].

singlecmd(t_assign(T1,T2)) --> ident(T1), ['='], exp(T2),['.'].

singlecmd(t_ifelse(T1,T2,T3)) --> ['if'], ['('],boolexp(T1),[')'], [then],['{'], cmd(T2), ['}'], [else], ['{'], cmd(T3), ['}'].
singlecmd(t_while(T1,T2)) --> [while], ['('], boolexp(T1), [')'], ['{'], cmd(T2), ['}'].
singlecmd(t_forrange(T1, T2, T3, T4)) -->  [for], ident(T1),[in],[range],['('],number(T2),[','],number(T3),[')'],['{'],cmd(T4),['}'].
singlecmd(t_for(T1,T2,T3,T4)) --> [for],['('],exp(T1),[';'],boolexp(T2),[';'],exp(T3),[')'],['{'],exp(T4),['}'].
singlecmd(t_ternary(T1, T2, T3)) --> boolexp(T1), ['?'], value(T2), [':'], value(T3).

boolexp(t_bool_not(T1)) --> ['not' ], boolexp(T1).
boolexp(t_bool_true(true)) --> [true].
boolexp(t_bool_false(false)) --> [false].
boolexp(t_bool_equal(T1,T2)) --> exp(T1), ['=='], exp(T2).
boolexp(t_bool_not_equal(T1,T2)) --> exp(T1), ['!='], exp(T2).
boolexp(t_bool_less_than(T1,T2)) --> exp(T1), [<], exp(T2).
boolexp(t_bool_greater_than(T1,T2)) --> exp(T1), [>], exp(T2).
boolexp(t_bool_greater_than_equal(T1,T2)) --> exp(T1), [>=], exp(T2).
boolexp(t_bool_less_than_equal(T1,T2)) --> exp(T1), [<=], exp(T2).
boolexp(t_bool_or(T1,T2)) --> exp(T1), ['or'], exp(T2).
boolexp(t_bool_and(T1,T2)) --> exp(T1), ['and'], exp(T2).

%Grammar rules for declaration
datatype(t_int) --> [int].
datatype(t_bool) --> [bool].
datatype(t_str) --> [string].

value(t_int(T)) --> number(T).
value(t_booleanexpr(T)) --> boolexp(T).

% Grammar rule for boolean
bool(t_true()) --> [true].
bool(t_false()) --> [false].

%Grammar rules for identifier
ident(t_ident(x)) --> [x].
ident(t_ident(y)) --> [y].
ident(t_ident(z)) --> [z].
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

