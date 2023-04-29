%Evaluator 

eval_program(t_prog(P), NewEnv) :-
    eval_block(P, [], NewEnv).

eval_block(t_block(T1), Env, NewEnv) :-
    eval_dec(T1, Env, NewEnv).
eval_block(t_block(T1,T2), Env, NewEnv) :-
    eval_dec(T1, Env, Env1),eval_cmd(T2, Env1, NewEnv).

eval_dec(t_multdec(T1, T2), Env, NewEnv) :-
    eval_dec(T1, Env, Env1),
    eval_dec(T2, Env1, NewEnv).

eval_dec(T,Env,NewEnv) :- eval_singledec(T, Env, NewEnv).

eval_dec(t_singledec(D), Env, NewEnv) :-
    eval_singledec(D, Env, NewEnv).

eval_singledec(t_declr_var(_, t_ident(X), Exp), Env, NewEnv) :-
    eval_exp(Exp, Env, Val),
    update(X, Val, Env, NewEnv).

eval_cmd(t_multicmd(T1,T2),Env, NewEnv) :-
    eval_cmd1(T1, Env, Env1),eval_cmd(T2,Env1,NewEnv).

eval_cmd(t_multicmd(T1),Env, NewEnv) :-
    eval_cmd1(T1, Env, NewEnv).

eval_cmd(t_singlecmd(D), Env, NewEnv) :-
    eval_cmd1(D, Env, NewEnv).


eval_cmd(T1,Env, NewEnv) :-
    eval_cmd1(T1, Env, NewEnv).

eval_cmd1(t_assign(t_ident(T), Exp), Env, NewEnv) :-
    eval_exp(Exp, Env, Val),
    update(T, Val, Env, NewEnv).



eval_cmd1(empty_command(), Env, Env).

eval_cmd1(t_ifelse(T1,T2,_),Env,Z):- bool_eval(T1,Env,Env1,true), eval_cmd(T2,Env1,Z).
eval_cmd1(t_ifelse(T1,_,T2),Env,Z):- bool_eval(T1,Env,Env1,false), eval_cmd(T2,Env1,Z).

eval_cmd1(t_ternary(T1,T2,_),Env,NewEnv) :- bool_eval(T1,Env,Env1,true),eval_cmd(T2,Env1,NewEnv).
eval_cmd1(t_ternary(T1,_,T2),Env,NewEnv):- bool_eval(T1,Env,Env1,false),eval_cmd(T2,Env1,NewEnv).

eval_cmd1(t_while(BoolExp, Cmd), Env, NewEnv) :-
    bool_eval(BoolExp, Env, _, 'true'),
    eval_cmd(Cmd, Env, Env1),
    eval_cmd1(t_while(BoolExp, Cmd), Env1, NewEnv).
eval_cmd1(t_while(_, _), Env, Env).

eval_cmd1(t_forrange(t_ident(Id), From, To, Cmds), Env, NewEnv) :-
    eval_forrange(Id, From, To, Cmds, Env, NewEnv).

eval_forrange(Id, From, To, Cmds, Env, NewEnv) :-
    eval_expr(From, Env, FromVal),
    eval_expr(To, Env, ToVal),
    forrange(Id, FromVal, ToVal, Cmds, Env, NewEnv).

forrange(_, To, To, _, Env, Env).
forrange(Id, From, To, Cmds, Env, NewEnv) :-
    update(Id, From, Env, Env1),
    eval_cmd(Cmds, Env1, Env2),
    Next is From + 1,
    forrange(Id, Next, To, Cmds, Env2, NewEnv).


bool_eval(t_bool_true(true), _, _, 'true').
bool_eval(t_bool_false(false), _, _, 'false').
bool_eval(t_bool_less_than(Exp1, Exp2), Env, _, 'true') :-
    eval_exp(Exp1, Env, Val1),
    eval_exp(Exp2, Env, Val2),
    Val1 < Val2.
bool_eval(t_bool_less_than(Exp1, Exp2), Env, _, 'false') :-
    eval_exp(Exp1, Env, Val1),
    eval_exp(Exp2, Env, Val2),
    Val1 >= Val2.

bool_eval(t_bool_greater_than(Exp1, Exp2), Env, _, 'true') :-
    eval_exp(Exp1, Env, Val1),
    eval_exp(Exp2, Env, Val2),
    Val1 >= Val2.
bool_eval(t_bool_greater_than(Exp1, Exp2), Env, _, 'false') :-
    eval_exp(Exp1, Env, Val1),
    eval_exp(Exp2, Env, Val2),
    Val1 < Val2.

bool_eval(t_bool_equal(T1, T2), Env, _, 'true') :-
    eval_exp(T1, Env, Val1),
    eval_exp(T2, Env, Val2),
    Val1 == Val2.

bool_eval(t_bool_equal(T1, T2), Env, _, 'false') :-
    eval_exp(T1, Env, Val1),
    eval_exp(T2, Env, Val2),
    Val1 =\= Val2.


eval_exp(t_exp(E), Env, Val) :-
    eval_expr(E, Env, Val).

eval_expr(t_add(E1, E2), Env, Val) :-
    eval_expr(E1, Env, Val1),
    eval_expr(E2, Env, Val2),
    Val is Val1 + Val2.
eval_expr(t_sub(E1, E2), Env, Val) :-
    eval_expr(E1, Env, Val1),
    eval_expr(E2, Env, Val2),
    Val is Val1 - Val2.
eval_expr(t_mul(E1, E2), Env, Val) :-
    eval_expr(E1, Env, Val1),
    eval_expr(E2, Env, Val2),
    Val is Val1 * Val2.
eval_expr(t_div(E1, E2), Env, Val) :-
    eval_expr(E1, Env, Val1),
    eval_expr(E2, Env, Val2),
    Val is Val1 / Val2.
eval_expr(t_paren(E), Env, Val) :-
    eval_expr(E, Env, Val).
eval_expr(t_ident(Id), Env, Val) :-
    lookup(Id, Env, Val).
eval_expr(t_num(Num), _, Num).



%lookup function
lookup(Var,[(Var,Val)|_],Val).
lookup(Var,[_|Tail],Val):- lookup(Var,Tail,Val).

%update function
update(Var,NewVar, [], [(Var,NewVar)]).
update(Var, NewVar, [(Var,_)|Tail], [(Var, NewVar)|Tail]).
update(Var, NewVar, [Head|Tail], [Head|NewEnv]) :-Head \= (Var,_),update(Var,NewVar, Tail, NewEnv).