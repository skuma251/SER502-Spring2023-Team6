%Grammar rule for  Program
program(t_prog(T1)) --> ['{'], block(T1),['}'].

%Grammar rule for block
block(t_block(T1)) --> dec(T1).
block(t_block(T1,T2)) --> dec(T1), block(T2).

%Grammar rule for declaration
dec(t_dec(T1)) --> dec1(T1), ['.'].
dec(t_dec(T1,T2)) --> dec1(T1),['='],number(T2),['.'].
dec(t_dec(T1)) --> cond(T1).


%Grammar for conditions
cond(t_if(T1,T2,T3)) --> [if],['('] ,bool(T1),[')'], [then],['{'], block(T2), ['}'], [else], ['{'], block(T3), ['}'].
cond(t_while(T1,T2)) --> [while],['('],bool(T1),[')'],['{'], block(T2), ['}'].


%Grammar rule for datatype declaration
dec1(t_var(T1)) --> [int], ident(T1).
dec1(t_var(T1)) --> [bool], ident(T1).
dec1(t_var(T1)) --> [string], ident(T1).

% Grammar rule for boolean
bool(t_true()) --> [true].
bool(t_bool()) --> [false].

%Grammar rules for identifier
ident(t_ident(x)) --> [x]. 
ident(t_ident(y)) --> [y]. 
ident(t_ident(z)) -->[z]. 
ident(t_ident(u)) --> [u]. 
ident(t_ident(v)) --> [v]. 

%Grammar rules for numbers
number(t_num(0)) -->[0]. 
number(t_num(1)) -->[1]. 
number(t_num(2)) -->[2]. 
number(t_num(3)) -->[3]. 
number(t_num(4)) -->[4]. 
number(t_num(5)) -->[5]. 
number(t_num(6)) -->[6]. 
number(t_num(7)) -->[7]. 
number(t_num(8)) -->[8]. 
number(t_num(9)) -->[9].