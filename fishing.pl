% ini ada start biar bisa nerapin teori HP soalnya fishing batesannya HP
% simulasi HP character --> character(HP, Max HP, XP, money)

:- dynamic(character/2).
:- dynamic(fish/2).

start :- asserta(character(100, 100, 0, 0)).

fish :-
    HPLoss is 2,
    character(Health, MaxHealth, Lvl, Money), (Health - HPLoss >= 0),
    write('Current HP: '), write(Health), write('/'), write(MaxHealth), nl,
    write('Current XP Fishing: '), write(Lvl), nl,
    write('Current Money: '), write(Money), nl,
    write('------------------------'), nl, nl,
    write('Reeling in...'), nl,
    write('Fishy fish...'), nl,
    write('Plz don\'t break @ fishing pole...'), nl, nl,
    write('------------------------'), nl,

    (   Lvl @=< 10 -> noobfish ; 
        (10 < Lvl, Lvl @=< 20) -> avgfish ;
        20 < Lvl -> profish),
    fish(Type, Price),

    CurHealth is Health - HPLoss,
    CurLvl is Lvl + 2,
    CurMoney is Money + Price,
    retract(character(Health, MaxHealth, Lvl, Money)),
    asserta(character(CurHealth, MaxHealth, CurLvl, CurMoney)), nl,

    (   Type == 'None' -> write('A fish fell prey to your bait, but was able to get away.'), nl, write('You left home empty-handed. Bummer.'), nl ;
        write('You caught a fish! It\'s '), write(Type), nl, write('You got '), write(Price), write(' Golds'), nl, 
        write('Current HP: '), write(CurHealth), write('/'), write(MaxHealth), nl), !.

fish :- 
    write('Not enough HP'), !.

% dummy fish types
noobfish :- random(0, 4, X),
        (   X =:= 0 -> asserta(fish('None', 0)) ;
            X =:= 1 -> asserta(fish('Teri Biasa Aja', 15)) ; 
            X =:= 2 -> asserta(fish('Teri Mini', 5)) ; 
            X =:= 3 -> asserta(fish('Teri Mikroskopis', 2))), !.

avgfish :- random(0, 4, X),
        (   X =:= 0 -> asserta(fish('None', 0)) ;
            X =:= 1 -> asserta(fish('Sarden Badan Licin', 65)) ; 
            X =:= 2 -> asserta(fish('Salmon Kulit Crispy Daging Kenyal', 45)) ; 
            X =:= 3 -> asserta(fish('Cupang Menggemaskan', 30))), !.

profish :- random(0, 4, X),
        (   X =:= 0 -> asserta(fish('None', 0)) ;
            X =:= 1 -> asserta(fish('Cacing Besar Alaska', 90)) ; 
            X =:= 2 -> asserta(fish('Ayah Nemo', 75)) ; 
            X =:= 3 -> asserta(fish('Geri Si Gurame', 110))), !.