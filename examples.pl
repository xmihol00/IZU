
xor(L1, L2, S) :- difference(L1, L2, S1), difference(L2, L1, S2), union(S1, S2, S).

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

len([X|[]], 1).
len([X|T], LEN) :- len(T, NEW_LEN), LEN is NEW_LEN + 1.

list2set([], []).
list2set([H|T], S) :- member(H, T), !, list2set(T, S), !.
list2set([H|T], [H|S]) :- list2set(T, S).

set_add(X, S1, S1) :- member(X, S1), !.
set_add(X, S1, [X|S1]).

union([], L, S) :- list2set(L, S).
union([H|T], L, S) :- union(T, L, S1), set_add(H, S1, S).

union3(L1, L2, L3, S) :- union(L1, L2, S1), union(L3, S1, S).

intersection([], _, []).
intersection([H|T], L, S) :- member(H, L), !, intersection(T, L, S1), set_add(H, S1, S).
intersection([H|T], L, S) :- intersection(T, L, S).

intersection3(L1, L2, L3, S) :- intersection(L1, L2, S1), intersection(L3, S1, S).

difference([], _, []).
difference([H|T], L, S) :- member(H, L), !, difference(T, L, S), !.
difference([H|T], L, S) :- difference(T, L, S1), set_add(H, S1, S).

len_no_0([H|[]], 1) :- H =\= 0.
len_no_0([H|[]], 0) :- H =:= 0.
len_no_0([H|T], N) :- H =:= 0, len_no_0(T, N).
len_no_0([H|T], N) :- H =\= 0, len_no_0(T, NN), N is NN + 1.


add(X, S, [X|S]).

u2(S, S1, S2) :- len(S, X), u2(S, S1, S2, X).
u2([H|T], S1, S2, X) :- len(T, Y), Y > (X-2)/2, u2(T, SS1, S2, X), !, add(H, SS1, S1), !.
u2([H|T], [], S2, X) :- add(H, T, S2), !.