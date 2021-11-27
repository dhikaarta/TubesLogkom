:- dynamic(player/12).
:- dynamic(energy/2). %energy(currentEnergy, maxEnergy)
:- dynamic(isExhausted/0).
:- dynamic(birthday/1).
% player(Job, Level, Level farming, Exp farming, Level fishing, Exp fishing, Level ranching, Exp ranching,Exp, LevelUpExp, Gold,Max job exp)
% player(A  , B    , C            , D          , E            , F          , G             , H           ,I  , J         , K   ,L          )

energy(100,100).


status :- player(A,B,C,D,E,F,G,H,I,J,K,L),energy(CurrEnergy,MaxEnergy),
    MaxExpFarming is L + 50*C,
    MaxExpFishing is L + 50 *E,
    MaxExpRanching is L + 50*G,
    write('Job            : '), write(A), nl,
    write('Level          : '), write(B), nl,
    write('Level farming  : '), write(C), nl,
    write('Exp farming    : '), write(D), write('/') , write(MaxExpFarming),nl,
    write('Level fishing  : '), write(E), nl,
    write('Exp Fishing    : '), write(F), write('/') , write(MaxExpFishing),nl,
    write('Level Ranching : '), write(G), nl,
    write('Exp ranching   : '), write(H), write('/') , write(MaxExpRanching),nl,
    write('Exp            : '), write(I), write('/'), write(J) ,nl,
    write('Gold           : '), write(K), nl,
    write('Stamina        : '), write(CurrEnergy), write('/') , write(MaxEnergy),nl.



initPlayer :- random(1,366,X),retractall(birthday(Birthday)),assertz(birthday(X)), 
write('Welcome to Strukdat Valley ! List of jobs here:'),nl,
write('1. Farmer'),nl,
write('2. Rancher'),nl,
write('3. Fisher'),nl,
chooseJob.


chooseJob :- write('Choose a Job (1/2/3) :'), read(CC),nl,
(CC =:= 1 -> assertz(player('Farmer', 1, 1, 0, 1, 0, 1, 0, 0, 300, 0, 100)), write('You are a farmer ! Good Luck ') ;
CC =:= 2 -> assertz(player('Rancher', 1, 1, 0, 1, 0, 1, 0, 0, 300, 0, 100)), write('You are a rancher ! Good Luck ')  ;
CC =:= 3 -> assertz(player('Fisher', 1, 1, 0, 1, 0, 1, 0, 0, 300, 0 , 100)), write('You are a fisher ! Good Luck ')  ;
write('No such job ! Choose again'), nl,chooseJob).

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), I > J,
            NewLevel is B + 1,
            NewExp is I - J,
            NewMax is J + 100,
            retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,NewLevel,C,D,E,F,G,H,NewExp,NewMax,K,L)),
            write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
            write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
            write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
            write('You have leveled up ! '), write(B), write('->'), write(NewLevel), nl, levelUp, !.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), D > (L + (50*C)),  
            NewLevel is C + 1,
            NewExp is D - (L + (50*C)),
            retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,NewLevel,NewExp,E,F,G,H,I,J,K,L)),
            write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
            write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
            write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
            write('Your farming skillz leveled up ! '), write(C), write('->'), write(NewLevel), nl,farmPriceUp, levelUp, !.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), F > L + (50*E), 
            NewLevel is E + 1,
            NewExp is F - (L + (50*E)) ,
            retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,NewLevel,NewExp,G,H,I,J,K,L)),
            write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
            write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
            write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
            write('Your fishing skillz leveled up ! '), write(E), write('->'), write(NewLevel), nl, levelUp, !.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), H > L + (50*G), 
            NewLevel is G + 1,
            NewExp is H - (L + (50*G)),
            retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,NewLevel,NewExp,I,J,K,L)),
            write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
            write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
            write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
            write('Your ranching skillz leveled up ! '), write(G), write('->'), write(NewLevel), nl,ranchPriceUp,levelUp, !.

levelUp :- !.

levelDown :- player(A,B,C,D,E,F,G,H,I,J,K,L), I < 0,
            NewLevel is B - 1,
            NewMax is J - 100,
            NewExp is NewMax + I,
            retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,NewLevel,C,D,E,F,G,H,NewExp,NewMax,K,L)),
            write('You lost a level '), write(B), write('->'), write(NewLevel), nl, levelDown, !.

levelDown :- player(A,B,C,D,E,F,G,H,I,J,K,L), D < 0,  
            NewLevel is C - 1,
            NewExp is (L + (50*NewLevel) + D),
            retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,NewLevel,NewExp,E,F,G,H,I,J,K,L)),
            write('Your farming skillz got worse '), write(C), write('->'), write(NewLevel), nl, levelDown, !.

levelDown :- player(A,B,C,D,E,F,G,H,I,J,K,L), F <0, 
            NewLevel is E - 1,
            NewExp is (L + (50*NewLevel) + F) ,
            retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,NewLevel,NewExp,G,H,I,J,K,L)),
            write('Your fishing skillz got worse '), write(E), write('->'), write(NewLevel), nl, levelDown, !.

levelDown :- player(A,B,C,D,E,F,G,H,I,J,K,L), H < 0, 
            NewLevel is G - 1,
            NewExp is (L + (50*NewLevel) + H),
            retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,NewLevel,NewExp,I,J,K,L)),
            write('Your ranching skillz got worse ! '), write(G), write('->'), write(NewLevel), nl, levelDown, !.

levelDown :- !.

addGold(X) :- player(A,B,C,D,E,F,G,H,I,J,K,L),
              NewGold is K + X,
              retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,H,I,J,NewGold,L)),
              write('You gained '), write(X), write(' Gold !'), nl.

loseGold(X) :- player(A,B,C,D,E,F,G,H,I,J,K,L),
              NewGold is K - X, NewGold >0,
              retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,H,I,J,NewGold,L)),
              write('You spent '), write(X), write(' Gold !'), nl.

loseGold(X) :- player(A,B,C,D,E,F,G,H,I,J,K,L),
              NewGold is K - X, NewGold <0, NewGold is 0,
              retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,H,I,J,NewGold,L)),
              write('You spent '), write(X), write(' Gold !'), nl.

unconsiousGold(X) :- player(A,B,C,D,E,F,G,H,I,J,K,L),
                     NewGold is K - X, NewGold >0,
                     retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,H,I,J,NewGold,L)),
                     write('You lost '), write(X), write(' Gold !'), nl.

unconsiousGold(X) :- player(A,B,C,D,E,F,G,H,I,J,K,L),
                     NewGold is K - X, NewGold<0, NewGold is 0,
                     retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,H,I,J,NewGold,L)),
                     write('You lost '), write(X), write(' Gold !'), nl.


addExp(X,Y) :- player(A,B,C,D,E,F,G,H,I,J,K,L),  % Y = 0 for general exp, Y = 1 for farming exp, Y=2 for fishing xp, Y =3 for ranching exp
               (Y =:= 0 -> NewExp is I + X, retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,H,NewExp,J,K,L));
                Y =:= 1 -> NewExp is D + X, retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,NewExp,E,F,G,H,I,J,K,L));
                Y =:= 2 -> NewExp is F + X, retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,NewExp,G,H,I,J,K,L));
                Y =:= 3 -> NewExp is H + X, retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,NewExp,I,J,K,L))),
                levelUp.
                
loseExp(X,Y) :- player(A,B,C,D,E,F,G,H,I,J,K,L),  % Y = 0 for general exp, Y = 1 for farming exp, Y=2 for fishing xp, Y =3 for ranching exp
               (Y =:= 0 -> NewExp is I - X, retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,H,NewExp,J,K,L));
                Y =:= 1 -> NewExp is D - X, retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,NewExp,E,F,G,H,I,J,K,L));
                Y =:= 2 -> NewExp is F - X, retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,NewExp,G,H,I,J,K,L));
                Y =:= 3 -> NewExp is H - X, retractall(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,NewExp,I,J,K,L))),
                levelDown.
                

restoreEnergy :- energy(CurrEnergy,Max),retractall(energy(CurrEnergy,Max)), assertz(energy(Max,Max)), write('Your stamina has been restored !\n'),retractall(isExhausted).

addEnergy(X) :- energy(A,Max), Anew is A + X,
                (Anew > Max -> restoreEnergy, Anew is Max;
                 retractall(energy(A,Max)), assertz(energy(Anew, Max)), retractall(isExhausted)),
                 write('You now have '), write(Anew), write(' stamina'), nl.
                 
                

depleteEnergy(X) :- energy(A,Max), 
                    (A < X -> write('You don\'t have enough energy to do that !'), nl;
                     A > X -> NewEnergy is A - X, retractall(energy(A,Max)), assertz(energy(NewEnergy,Max)), write('You now have '), write(NewEnergy), write(' stamina'), nl;
                     A =:= X -> retractall(energy(A,Max)), assertz(energy(0,Max)), assertz(isExhausted), write('You ran out of stamina, you are now exhausted'), nl).
                     
                    

farmPriceUp :- 
priceitems('bayam',A), Anew is A + 3, changePrice('bayam',Anew),
priceitems('wortel',B), Bnew is B + 3,changePrice('wortel',Bnew),
priceitems('kentang',C), Cnew is C + 3,changePrice('kentang',Cnew),
priceitems('jagung',D), Dnew is D + 3,changePrice('jagung',Dnew),
priceitems('cabe',E), Enew is E+ 3,changePrice('cabe',Enew),
priceitems('bawang merah',F), Fnew is F + 3,changePrice('bawang merah',Fnew),
priceitems('bawang putih',G), Gnew is G + 3,changePrice('bawang putih',Gnew),
priceitems('padi',H), Hnew is H + 3,changePrice('padi',Hnew),
priceitems('kangkung',I), Inew is I + 3,changePrice('kangkung',Inew).

ranchPriceUp :- 
priceitems('egg',A), Anew is A + 3, changePrice('egg',Anew),
priceitems('milk',B), Bnew is B + 3,changePrice('milk',Bnew),
priceitems('wol',C), Cnew is C + 3,changePrice('wol',Cnew),
priceitems('cow meat',D), Dnew is D + 3,changePrice('cow meat',Dnew),
priceitems('sheep meat',E), Enew is E+ 3,changePrice('sheep meat',Enew),
priceitems('chicken meat',F), Fnew is F + 3,changePrice('chicken meat',Fnew).