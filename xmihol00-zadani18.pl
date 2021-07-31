% =========================================================================================================
% Soubor:       xmihol00-uloha18.pl
% Uloha:        VUT, FIT, IZU, projekt 2
% Datum:        24. 3. 2021
% Autor:        David Mihola
% Kontakt:      xmihol00@stud.fit.vutbr.cz
% Interpret:    SWI-Prolog version 7.6.4 for amd64
% Popis:        Program pro spocitani prvku v seznamu prirozenych cisel bets nez 0, ktere nejsou prvocisla.
% Poznamka:     Zvolil jsem obecny postup, ktery by mel fungovat i na seznamy s vetsimi cisly nez 20.
%               Predpokladam, ze to nebude problem. Naspod dokumentu jsem pripadne nechal rucni reseni
%               pouze pro cisla z intervalu <1..20>. 
% ==========================================================================================================

% 1 neni prvocislo
notPrime(1).

% cislo neni prvocislo, pokud je delitelne jinym cislem nez 1 a ono samo
notPrime(X) :- divisibleOtherThanSelf(X, 2).

% cislo je prvocilso pokud neni neprvocislo a je vetsi nez 1
prime(X) :- \+ notPrime(X), X > 1.

% cislo je delitelne jinym mensim cislem
divisibleOtherThanSelf(X,Y) :- X > 2, X mod Y =:= 0, !.

% pokud je druha mocnina delitele mensi nez delenec, muzeme pokracovat s o 1 vetsim delitelem
% jinak je cislo prvocislem
divisibleOtherThanSelf(X,Y) :- X > Y*Y, divisibleOtherThanSelf(X, Y+1).

% koncova podminka pro rekurzi nad seznamem
uloha18([], 0).

% cislo neni prvocislo vede na zvetseni delky o 1
uloha18([X|T], DELKA) :- notPrime(X), uloha18(T, DELKA1), DELKA is DELKA1 + 1.

% cislo je prvocislo, delka se nemeni
uloha18([X|T], DELKA) :- prime(X), uloha18(T, DELKA).


% rucni definovani prvocisel a neprvocisel, pouze pro seznamy v intervalu <1..20>
%notPrime(1).
%notPrime(4).
%notPrime(6).
%notPrime(8).
%notPrime(9).
%notPrime(10).
%notPrime(12).
%notPrime(14).
%notPrime(15).
%notPrime(16).
%notPrime(18).
%notPrime(20).
%
%prime(2).
%prime(3).
%prime(5).
%prime(7).
%prime(11).
%prime(13).
%prime(17).
%prime(19).
