program_eval(t_prog(P),NewEnv):- block_eval(P, [], NewEnv).

%evaluation for block
block_eval(t_block(T1), Env, Env1) :- dec_eval(T1,Env, Env1).
block_eval(t_block(T1,T2),Env, NewEnv) :- dec_eval(T1,Env, Env1), block_eval(T2,Env1,NewEnv).
block_eval(t_block(T1,T2),Env, NewEnv) :- exp_eval(T1, T2, Env, NewEnv).
    
dec_eval(t_dec(Declaration), Env, NewEnv) :- dec_eval1(Declaration, Env, NewEnv).
dec_eval(t_dec(T1,T2),Env,NewEnv) :- dec_eval1(T1, Env, Env1), exp_eval(T1,T2, Env1,NewEnv).

dec_eval1(t_int(t_ident(Name)), Env, NewEnv) :- update(Name, Env, 0, NewEnv).
dec_eval1(t_bool(t_ident(Name)), Env, NewEnv) :- update(Name, Env, false, NewEnv).
dec_eval1(t_string(t_ident(Name)), Env, NewEnv) :- update(Name, Env, "", NewEnv).

exp_eval(t_int(t_ident(Name)),t_exp(t_num(Value)), Env, NewEnv) :- update(Name, Env, Value,NewEnv).
exp_eval(t_dec(t_ident(Name)),t_exp(t_num(Value)), Env, NewEnv) :- update(Name, Env, Value,NewEnv).


%Lookup function, looking for the variable 
lookup(Var,[(Var,Val)|_],Val). 
lookup(Var,[_|Tail],Val):- lookup(Var,Tail,Val).

%update function
update(Var, [], NewVar, [(Var,NewVar)]).
update(Var, [(Var,_)|Tail], NewVar, [(Var, NewVar)|Tail]).
update(Var, [Head|Tail], NewVar, [Head|NewEnv]) :-Head \= (Var,_),update(Var, Tail, NewVar, NewEnv).