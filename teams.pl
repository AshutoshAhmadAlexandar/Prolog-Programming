solve(Ans):-
       Ans = [triple(_,_,pascal),
	      triple(_,_,perl),
	      triple(_,_,python),
	      triple(_,_,prolog)],
       constraints(Ans).

constraints(Ans) :-
       constraint1(Ans),
       constraint2(Ans),
       constraint3(Ans),
       constraint4(Ans),
       constraint5(Ans).

/*
a.  Kejal programs in Python but Kate does not.
b.  Don programs in Pascal and Daod does not program in Prolog.
c.  Neither Kim nor Kari nor Deep programs in Perl.
d.  Ding cannot be with Kim, Kari, or Kejal.
e.  Kari cannot be with Don and Kate cannot be with Don or Daod.
*/

constraint1(Ans) :-
       member(triple(_, kejal, python), Ans),
       member(triple(_, kate, PL), Ans),           PL \== python.

constraint2(Ans) :-
       member(triple(don,_, pascal), Ans), 
       member(triple(daod,_, PL), Ans), PL \== prolog.

constraint3(Ans) :-
       member(triple(deep,_, PL), Ans), PL \== perl,
       member(triple(_,kari, PL), Ans), PL \== perl,
       member(triple(_,kim, ML), Ans), ML \== perl.

constraint4(Ans) :-
       member(triple(ding, PL,_), Ans), PL \== kim,
       member(triple(ding, ML,_), Ans), ML \== kari,
       member(triple(ding, AL,_), Ans), AL \== kejal.

constraint5(Ans) :-
       member(triple(PL, kate,_), Ans), PL \== daod,
       member(triple(ML, kate,_), Ans), ML \== don,
       member(triple(AL, kari,_), Ans), AL \== don.
