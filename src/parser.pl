:- table  dec/3,term/3, expr/3.

%Grammar rule for  Program
program(t_prog(T1)) --> block(T1).

%Grammar rule for block
block(t_block(T1,T2)) -->  ['{'], dec(T1), cmd(T2), ['}'].

dec(t_multdec(T1,T2)) --> singledec(T1), [.], dec(T2).
dec(t_singledec(X)) --> singledec(X), [.].


singledec(t_declr_var(T1, T2, T3)) --> datatype(T1), ident(T2), ['='], exp(T3).

exp(t_multi_exp(X,Y)) --> ident(X), ['='], exp(Y).
exp(t_exp(X)) --> expr(X).

expr(t_add(X,Y)) --> expr(X), [+], term(Y).
expr(t_sub(X,Y)) --> expr(X), [-], term(Y).
expr(X) --> term(X).

term(t_mul(X,Y)) --> term(X), [*], term1(Y).
term(t_div(X,Y)) --> term(X), [/], term1(Y).
term(X) --> term1(X).
term1(X) --> ident(X).
term1(X) --> number(X).



cmd(t_multicmd(X,Y)) --> singlecmd(X), ['.'], cmd(Y).
cmd(t_singlecmd(X)) --> singlecmd(X).
cmd(empty_command([])) --> [].




singlecmd(t_assign(X,Y)) --> ident(X), ['='], exp(Y),['.'].

singlecmd(t_ifelse(T1,T2,T3)) --> ['if'], ['('],boolexp(T1),[')'], [then],['{'], cmd(T2), ['}'], [else], ['{'], cmd(T3), ['}'].
single_command(t_while(T1,T2)) --> [while], ['('], boolean_exp(T1), [')'], ['{'], cmd(T2), ['}'].
single_command(t_forrange(T1, T2, T3, T4)) -->  [for], ident(T1),[in],[range],['('],number(T2),[','],number(T3),[')'],['{'],cmd(T4),['}'].

boolexp(t_bool_not(X)) --> ['not' ], boolexp(X).
boolexp(t_bool_true(true)) --> [true].
boolexp(t_bool_false(false)) --> [false].
boolexp(t_bool_equal(X,Y)) --> exp(X), ['=='], exp(Y).
boolexp(t_bool_not_equal(X,Y)) --> exp(X), ['!='], exp(Y).
boolexp(t_bool_less_than(X,Y)) --> exp(X), [<], exp(Y).
boolexp(t_bool_greater_than(X,Y)) --> exp(X), [>], exp(Y).
boolexp(t_bool_greater_than_equal(X,Y)) --> exp(X), [>=], exp(Y).
boolexp(t_bool_less_than_equal(X,Y)) --> exp(X), [<=], exp(Y).
boolexp(t_bool_or(X,Y)) --> exp(X), ['or'], exp(Y).
boolexp(t_bool_and(X,Y)) --> exp(X), ['and'], exp(Y).




%Grammar rules for declaration
datatype(t_int) --> [int].
datatype(t_bool) --> [bool].
datatype(t_str) --> [string].

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