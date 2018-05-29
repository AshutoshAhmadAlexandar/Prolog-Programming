go :- write('Tiny PL Call Graph Analyzer. Commands are:'), nl,
      write('   callers(f, L).'), nl,
      write('   undefined(L).'), nl,
      write('   is_recursive(f).'), nl,
      write('   all_calls(f, L).'), nl,
      nl.

/*  Commented out the calls/2 facts for Problem 3

calls(f,[g]).
calls(g,[h,k]).
calls(h,[f]).
calls(k,[t]).
calls(p,[k,s,f,r]).
calls(q,[]).
calls(r,[un1]).
calls(s,[s]).
calls(t,[un2]).
*/


%callers(F, L) definition goes here
callers(F, L) :- setof(X,helper(X,F),L).
helper(X,F) :-
	calls(X,J),
	member(F,J).

%undefined(L) definition goes here
undefined(L) :- 
	setof(Z,helper2(Z),L).

helper2(Z) :- 
	calls(_,Y),
	member(Z,Y),
	\+ calls(Z,_).

%is_recursive(F) definition goes here
is_recursive(X):- cyclic(X,[X]).

cyclic(X,L):-
       calls(X,L2),
        member(Y,L2),
       (member(Y,L)
              ->  true
               ;  cyclic(Y,[Y|L])
       ).

%all_calls(F,L) definition goes here
get_all_calls(Calls) :-
   bagof(calls(X,Y), calls(X,Y), Calls).

all_calls(F, L) :-
    get_all_calls(Calls),
    all_calls(Calls, F, Out),
    flatten(Out, FOut),
    list_to_set(FOut, L).

all_calls([], L, L).

all_calls(Calls, F, L) :-
    select(calls(F, Nodes), Calls, Rest)
    -> setof([X|Y], (member(X, Nodes), all_calls(Rest, X, Y)), L)
    ;  L = [].
