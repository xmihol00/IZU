
list_add(X, [], [X]).
list_add(X, L, [X|L]).

set_add(X, S, [X|S]) :- \+  member(X, S), !.
set_add(X, S, S).

list_elem_add([H|L], A, L2) :- list_elem_add(L, A, L3), R is H+A, list_add(R, L3, L2).
list_elem_add([], A, []).

list_elem_mod([H|L], A, L2) :- list_elem_mod(L, A, L3), !, R is mod(H, A), list_add(R, L3, L2).
list_elem_mod([], A, []).

member(X, [H|L]) :- X =:= H.
member(X, [H|L]) :- member(X, L).

list2set([], []).
list2set([H|L], S) :- member(H, L), !, list2set(L, S).
list2set([H|L], [H|S]) :- list2set(L, S).

inter([], _, []).
inter([H|T], S2, I) :- member(H, S2), !, inter(T, S2, I1), set_add(H, I1, I).
inter([H|T], S2, I) :- inter(T, S2, I).

union([], S, S2) :- list2set(S, S2).
union([H|T], S, U) :- union(T, S, U1), set_add(H, U1, U).

diff([], _, []).
diff([H|T], S, D) :- member(H, S), !, diff(T, S, D), !.
diff([H|T], S, D) :- diff(T, S, D1), set_add(H, D1, D).

u1([H], 1) :- H =\= 0, !.
u1([H], 0) :- H =:= 0, !.
u1([H|T], D) :- H =\= 0, u1(T, D1), !, D is D1 + 1.
u1([H|T], D) :- H =:= 0, u1(T, D).

len([H], 1).
len([H|T], L) :- len(T, L1), !, L is L1 + 1.

u2(S1, S2, S3) :- len(S1, X), u2_l(S1, S2, S3, X).
u2_l([H|T], S2, S3, X) :- len(T, Y), Y+1 > X/2, u2_l(T, S4, S3, X), !, list_add(H, S4, S2).
u2_l(S1, S2, S1, X).

u3([H|T], S2, D) :- D > 0, !, D1 is D-1, u3(T, S3, D1), !, list_add(H, S3, S2).
u3(_, [], _).

u4([H|T], D) :- u4_mm(T, H, H, Min, Max), !, D is Max - Min.
u4_mm([H|T], Min1, Max1, Min2, Max2) :- H > Max1, u4_mm(T, Min1, H, Min2, Max2).
u4_mm([H|T], Min1, Max1, Min2, Max2) :- H < Min1, u4_mm(T, H, Max1, Min2, Max2). 
u4_mm([H|T], Min1, Max1, Min2, Max2) :- u4_mm(T, Min1, Max1, Min2, Max2).
u4_mm([], Min1, Max1, Min1, Max1).

u5([H|T]) :- H /\ 1 =:= 1, !, u5_o(T).
u5([H|T]) :- u5_e(T). 
u5_o([H|T]) :- H /\ 1 =:= 1, !, u5_o(T).
u5_o([]).
u5_e([H|T]) :- H /\ 1 =:= 0, !, u5_e(T).
u5_e([]).

u6([H|T]) :- H > 0, u6(T), !.
u6([H|T]) :- H < 0, u6(T), !.
u6([]).

u7(L, D) :- u7_diff(L, X, Y), !, D is X - Y.
u7_diff([H|T], X, Y) :- H > 0, u7_diff(T, X1, Y), !, X is X1+1.
u7_diff([H|T], X, Y) :- H < 0, u7_diff(T, X, Y1), !, Y is Y1+1.
u7_diff([H|T], X, Y) :- u7_diff(T, X, Y).
u7_diff([], 0, 0).

u8([H|T], D) :- u8(H, T, D), !.
u8(X, [H|T], D) :- X-H >= D, u8(H, T, D), !.
u8(X, [], D).

u9([H|T], D) :- u9(H, T, D), !.
u9(X, [H|T], D) :- u9(H, T, D1), X-H > D1, !, D is X-H.
u9(X, [H|T], D) :- u9(H, T, D1), !, D is D1.
u9(X, [], 0).

head([H|T], H, T).
u10(0, []).
u10(1, [0]).
u10(2, [1, 0]).
u10(X, S) :- X1 is X-1, u10(X1, S1), !, head(S1, H1, T1), head(T1, H2, T2), X2 is H1 + H2, list_add(X2, S1, S).

u11([H|T], S2, S3, P) :- H =< P, u11(T, S4, S3, P), !, list_add(H, S4, S2).
u11([H|T], S2, S3, P) :- H > P, u11(T, S2, S4, P), !, list_add(H, S4, S3).
u11([], [], [], _).

list_rev(L, R) :- list_rev(L, [], R).
list_rev([H|T], A, R) :- list_rev(T, [H|A], R).
list_rev([], A, A).

list_cmp([H1|T1], [H2|T2]) :- H1 =:= H2, list_cmp(T1, T2).
list_cmp([], []).

u12(S) :- list_rev(S, R), list_cmp(S, R).

max(X1, X2, X1) :- X1 >= X2.
max(X1, X2, X2). 

u13(S) :- u13(S, M, P), P > M.
u13([H|T], M, P) :- H >= 0, u13(T, M, P1), !, max(H, P1, P).
u13([H|T], M, P) :- H < 0, u13(T, M1, P), !, max(-H, M1, M).
u13([], 0, 0).

sum([H|T], X) :- sum(T, X1), !, X is X1 + H.
sum([H], H).

abs(X, X) :- X >= 0.
abs(X, -X) :- X < 0.

u14(S, H, V) :- u14_a(S, S1, H), len(S1, X), sum(S1, Y), V is Y/X.
u14_a([H|T], S1, A) :- abs(H, X), X =< A, u14_a(T, S2, A), !, list_add(X, S2, S1).
u14_a([H|T], S1, A) :- u14_a(T, S1, A).
u14_a([], [], _).

u15(S) :- u15(S, X, Y), X > Y.
u15([H|T], X, Y) :- H > 0, u15(T, X1, Y), !, X is X1 + 1.
u15([H|T], X, Y) :- H < 0, u15(T, X, Y1), !, Y is Y1 + 1.
u15([H|T], X, Y) :- u15(T, X, Y).
u15([], 0, 0).

get([H|T], H, T, _).
get([], H, T, [H|T]).

list_cpy([H|T], L) :- list_cpy(T, L1), !, list_add(H, L1, L).
list_cpy([], []).

u16(S1, S2, S3) :- list_cpy(S2, S4), u16(S1, S2, S3, S4).
u16([H|T], S2, S3, S4) :- get(S2, X, Y, S4), !, u16(T, Y, S5, S4), !, Z is H - X, list_add(Z, S5, S3).
u16([], S2, [], S4).

u17([H1|T1], [H2|T2], R) :- u17(T1, T2, R1), R is R1 + H1*H2.
u17([], [], 0).

u19([H|T]) :- u19_line(H), !, u19(T), !.
u19([]).
u19_line([H|[]]) :- write(H), nl.
u19_line([H|T]) :- write(H), write(' '), u19_line(T), !.

u20([H|T], S) :- H /\ 1 =:= 1, u20(T, S1), !, list_add(H, S1, S).
u20([H|T], S) :- u20(T, S).
u20([], []).

u21([H|T], R) :- H =\= 0, u21(T, R1), !, R is R1*H.
u21([H|T], R) :- u21(T, R). 
u21([], 1).

u22([H1|T1], [H2|T2], S) :- u22(T1, T2, S1), !, list_add(H2, S1, S2), list_add(H1, S2, S).
u22(S, [], S).
u22([], S, S).
u22([], [], []).

%u22([H|T], S1, S2) :- u23_b(T, S1, S3), !, list_add(H, S3, S2).
%u22_b(S1, [H|T], S2) :- u23(S1, T, S3), !, list_add(H, S3, S2).
%u22([], S, S).
%u22_b(S, [], S).
%u22([], _, []).
%u22_b(_, [], []).

u23([H|T], S) :- abs(H, X), u23(T, S1), !, S is S1 + X.
u23([], 0). 

u24([H|T], Min, Max, H) :- H >= Min, H =< Max. 
u24([H|T], Min, Max, X) :- u24(T, Min, Max, X), !.
u24([], Min, Max, X) :- Min > Max.

u25(X) :- X > 0, X2 is X /\ 1, X1 is X//2, u25(X1), !, write(X2).
u25(0).

u26(X) :- X > 0, X2 is X /\ 15, X1 is X//16, u26(X1), !, u26w(X2).
u26(0).
u26w(X) :- X < 10, write(X).
u26w(10) :- write('A').
u26w(11) :- write('B').
u26w(12) :- write('C').
u26w(13) :- write('D').
u26w(14) :- write('E').
u26w(15) :- write('F').

u27([H|T], S) :- u27a(T, S, H).
u27a([H|T], S, X) :-  u27a(T, S1, X), list_add(H, S1, S).
u27a([], [X], X).

u28a([T], [], T).
u28a([H|T], S, X) :- u28a(T, S1, X), !, list_add(H, S1, S).
u28(L, S) :- u28a(L, S1, X), !, list_add(X, S1, S), !.

prime(2).
prime(3).
prime(5).
prime(7).
prime(11).
prime(13).
prime(17).

u29([H|T], X) :- prime(H), u29(T, X1), !, X is X1 + 1.
u29([H|T], X) :- u29(T, X), !.
u29([], 0).

u30(S, V) :- u30a(S, X, Y), !, V is X/Y.
u30a([H|T], X, Y) :- abs(H, Z), u30a(T, X1, X2), !, X is X1 + Z, Y is X2 + 1.
u30a([], 0, 0).

u31(S, X) :- u31a(S, X1, Y, Z), X is X1 - Y.
u31a([H|T], X, X, H) :- u31a(T, X1, Y1, Z1), H >= Z1, !, X is X1 + 1.
u31a([H|T], X, Y, Z) :- u31a(T, X1, Y, Z), !, X is X1 + 1.
u31a([T], 0, 0, T).

u32(S1, S2) :- u32a(S1, S2, X, Y), !, X > Y.
u32a([H1|T1], [H2|T2], X, Y) :- u32a(T1, T2, X1, Y1), H1 =:= 0, H2 =:= 0, !, X is X1 + 1, Y is Y1 + 1.
u32a([H1|T1], [H2|T2], X, Y) :- u32a(T1, T2, X1, Y), H1 =:= 0, !, X is X1 + 1.
u32a([H1|T1], [H2|T2], X, Y) :- u32a(T1, T2, X, Y1), H2 =:= 0, !, Y is Y1 + 1.
u32a([H1|T1], [H2|T2], X, Y) :- u32a(T1, T2, X, Y), !.
u32a([H1|T1], [], X, Y) :- u32a(T1, [], X1, Y), H1 =:= 0, !, X is X1 + 1.
u32a([H1|T1], [], X, Y) :- u32a(T1, [], X, Y), !.
u32a([], [H1|T1], X, Y) :- u32a([], T1, X, Y1), H1 =:= 0, !, Y is Y1 + 1.
u32a([], [H1|T1], X, Y) :- u32a([], T1, X, Y), !.
u32a([], [], 0, 0).

u33([H|T], S) :- H /\ 1 =:= 0, u33(T, S1), !, X is H-1, list_add(X, S1, S).
u33([H|T], S) :- u33(T, S1), !, list_add(H, S1, S).
u33([], []).

u34([H|T], S) :- H /\ 1 =:= 1, u34(T, S1), !, X is H*2, list_add(X, S1, S).
u34([H|T], S) :- u34(T, S1), !, list_add(H, S1, S).
u34([], []).

u36(S1, X) :- u36b(S1, _, X).
u36a([H|T], Y, X) :- u36a(T, _, Y1), H > Y1, !, Y is Y1, X is H, !.
u36a([H], H, H).
u36a([H|T], X, Y) :- u36a(T, X, Y), !.

u36b([H], H, -9999999999999999999).
u36b([H|T], H, X) :- u36b(T, X, Y1), H > X, !. 
u36b([H|T], X, H) :- u36b(T, X, Y), H > Y, !. 
u36b([H|T], X, Y) :- u36b(T, X, Y), !. 

u37(S, P) :- u37a(S, P1), P1 =< P.
u37a([H|T], P) :- u37a(T, P1), P is P1 + (H /\ 1).
u37a([], 0).

mbr(X, [X|T]).
mbr(X, [H|T]) :- mbr(X, T).

l2s([H], [H]).
l2s([H|T], S) :- l2s(T, S), mbr(H, S), !.
l2s([H|T], [H|S]) :- l2s(T, S).

int_uni(L1, L2, L3, X) :- itr(L2, L3, X1), uni(L1, X1, X).

itr([], _, []).
itr([H|T], L2, X) :- member(H, L2), itr(T, L2, X1), !, set_add(H, X1, X).
itr([H|T], L2, X) :- itr(T, L2, X).

uni([], H, H).
uni([H|T], L2, X) :- uni(T, L2, X1), set_add(H, X1, X).

l2_sum([A, B], X) :- X is A + B.
l2_sum([H|T], X) :- l2_sum(T, X), !.

max_idxa(S, X) :- max_idxa(S, A, B, _), !, X is A - B. 
max_idxa([H], 0, 0, H).
max_idxa([H|T], X, Y, Z) :- max_idxa(T, X1, Y1, Z1), H >= Z1, Z is H, !, X is X1 + 1, Y is X.
max_idxa([H|T], X, Y, Z) :- max_idxa(T, X1, Y, Z), !, X is X1 + 1.

l2sum(L, X) :- l2suma(L, Y, Z), !, X is Y + Z.
l2suma([A, B], A, B) :- A > B.
l2suma([A, B], B, A) :- A =< B.
l2suma([H|T], H, A) :- l2suma(T, A, B), H >= A, !.
l2suma([H|T], A, H) :- l2suma(T, A, B1), H >= B1, !.
l2suma([H|T], A, B) :- l2suma(T, A, B), !.

ladd(H, S, [H|S]).
nmem(X, [H|T]) :- X \= H, nmem(X, T).
nmem(_, []).

u38(S) :- u38(S, X), !.
u38([H|T], X) :- u38(T, X1), H /\ 1 =:= 1, !, nmem(H, X1), ladd(H, X1, X). 
u38([H|T], X) :- u38(T, X), H /\ 1 =:= 0, !. 
u38([], []).

p(b).
p(c).
r(a).
r(d).

u39(S, X, Y, Z) :- u39a(S, X, Y, Z), !, Z >= X.
u39a([], X, Y, Z) :- Z is X - 1.
u39a([H|T], X, Y, H) :- u39a(T, X, Y, Z), H > Z, H >= X, H =< Y, !.
u39a([H|T], X, Y, Z) :- u39a(T, X, Y, Z), !.

u40([H|T]) :- H /\ 1 =:= 1, u40a(T), !.
u40([H|T]) :- u40b(T), !.
u40a([H|T]) :- H /\ 1 =:= 0, u40b(T), !.
u40b([H|T]) :- H /\ 1 =:= 1, u40a(T), !.
u40a([]).
u40b([]).
