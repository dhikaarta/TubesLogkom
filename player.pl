:- dynamic(player/12).
:- dynamic(energy/2). %energy(currentEnergy, maxEnergy)
:- dynamic(isExhausted/0).

energy(100,100).


status :- player(A,B,C,D,E,F,G,H,I,J,K,L),energy(CurrEnergy,MaxEnergy),
    MaxExpFarming is L + 50*D,
    MaxExpFishing is L + 50 *F,
    MaxExpRanching is L + 50*H,
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



initPlayer :- write('Welcome to Strukdat Valley ! List of jobs here:'),nl,
write('1. Farmer'),nl,
write('2. Rancher'),nl,
write('3. Fisher'),nl,
chooseJob.

% player(Job, Level, Level farming, Exp farming, Level fishing, Exp fishing, Level ranching, Exp ranching,Exp, LevelUpExp, Gold,Max job exp)
% player(A  , B    , C            , D          , E            , F          , G             , H           ,I  , J         , K   ,L          )

chooseJob :- write('Choose a Job (1/2/3) :'), read(CC),nl,
(CC =:= 1 -> assertz(player('Farmer', 1, 1, 0, 1, 0, 1, 0, 0, 300, 0, 100)), write('You are a farmer ! Good Luck ') ;
CC =:= 2 -> assertz(player('Rancher', 1, 1, 0, 1, 0, 1, 0, 0, 300, 0, 100)), write('You are a rancher ! Good Luck ')  ;
CC =:= 3 -> assertz(player('Fisher', 1, 1, 0, 1, 0, 1, 0, 0, 300, 0 , 100)), write('You are a fisher ! Good Luck ')  ;
write('No such job ! Choose again'), nl,chooseJob).

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), I > J,
            NewLevel is B + 1,
            NewExp is I - J,
            NewMax is J + 100,
            retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,NewLevel,C,D,E,F,G,H,NewExp,NewMax,K,L)),
            write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
            write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
            write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
            write('You have leveled up ! '), write(B), write('->'), write(NewLevel), nl, levelUp.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), D > (L + (50*C)),  
            NewLevel is C + 1,
            NewExp is D - (L + (50*C)),
            retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,NewLevel,NewExp,E,F,G,H,I,J,K,L)),
            write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
            write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
            write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
            write('Your farming skillz leveled up ! '), write(C), write('->'), write(NewLevel), nl, levelUp.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), F > L + (50*E), 
            NewLevel is E + 1,
            NewExp is F - (L + (50*E)) ,
            retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,NewLevel,NewExp,G,H,I,J,K,L)),
            write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
            write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
            write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
            write('Your fishing skillz leveled up ! '), write(E), write('->'), write(NewLevel), nl, levelUp.

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), H > L + (50*G), 
            NewLevel is G + 1,
            NewExp is H - (L + (50*G)),
            retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,NewLevel,NewExp,I,J,K,L)),
            write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
            write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
            write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
            write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
            write('Your ranching skillz leveled up ! '), write(G), write('->'), write(NewLevel), nl, levelUp.

addGold(X) :- player(A,B,C,D,E,F,G,H,I,J,K,L),
              NewGold is K + X,
              retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,H,I,J,NewGold,L)),
              write('You gained '), write(X), write(' Gold !'), nl ,!.

addExp(X,Y) :- player(A,B,C,D,E,F,G,H,I,J,K,L),  % Y = 0 for general exp, Y = 1 for farming exp, Y=2 for fishing xp, Y =3 for ranching exp
               (Y =:= 0 -> NewExp is I + X, retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,H,NewExp,J,K,L));
                Y =:= 1 -> NewExp is D + X, retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,NewExp,E,F,G,H,I,J,K,L));
                Y =:= 2 -> NewExp is F + X, retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,NewExp,G,H,I,J,K,L));
                Y =:= 3 -> NewExp is H + X, retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), assertz(player(A,B,C,D,E,F,G,NewExp,I,J,K,L))),
                levelUp .
                

restoreEnergy :- energy(_,Max),retract(energy(_,Max)), assertz(energy(Max,Max)), retract(isExhausted).

addEnergy(X) :- energy(A,Max), Anew is A + X,
                (Anew > Max -> restoreEnergy, Anew is Max;
                 retract(energy(_,_)), assertz(energy(Anew, Max)), retract(isExhausted)),
                 write('You now have '), write(Anew), write(' stamina'), nl.
                 
                

depleteEnergy(X) :- energy(A,Max), 
                    (A < X -> write('You don\'t have enough energy to do that !'), nl;
                     A > X -> NewEnergy is A - X, retract(energy(_,Max)), assertz(energy(NewEnergy,Max)), write('You now have '), write(NewEnergy), write(' stamina'), nl;
                     A =:= X -> retract(energy(_,Max)), assertz(energy(0,Max)), assertz(isExhausted), write('You ran out of stamina, you are now exhausted'), nl).
                     
                    