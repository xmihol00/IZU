p(b).
p(c).
r(a).
r(d).

rl([_], c).
rl([_,t], d).
rl([H|T], X) :- p(H), rl(T, X).
rl([H|T], s(X)) :- r(H), rl(T, X).


%a) ?-rl([a], X).
%b) ?-rl([a,h,a], X).
%c) ?-rl([a,c,d,c], X).
%d) ?-rl([a,b,b,a,t], X).
