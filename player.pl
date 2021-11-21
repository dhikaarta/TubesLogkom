:- dynamic(player/12).

% character (Job, Level, Level farming, Exp farming, Level fishing, Exp fishing, Level ranching, Exp ranching,Exp, LevelUpExp, Gold,Max job exp)
% character (A  , B    , C            , D          , E            , F          , G             , H           ,I  , J         , K   ,L          )


status :- player(A,B,C,D,E,F,G,H,I,J,K,L),
    write('   _____ _______    _______ _    _  _____ '),nl,
    write('  / ____|__   __|/\|__   __| |  | |/ ____|'),nl,
    write(' | (___    | |  /  \  | |  | |  | | (___  '),nl,
    write('  \___ \   | | / /\ \ | |  | |  | |\___ \ '),nl,
    write('  ____) |  | |/ ____ \| |  | |__| |____) |'),nl,
    write(' |_____/   |_/_/    \_\_|   \____/|_____/ '),nl,nl,
    write('Job            : '), write(A), nl,
    write('Level          : '), write(B), nl,
    write('Level farming  : '), write(C), nl,
    write('Exp farming    : '), write(D), write('/') , write(L + (50*D) ),nl,
    write('Level fishing  : '), write(E), nl,
    write('Exp Fishing    : '), write(F), write('/') , write(L + (50*F)),nl,
    write('Level Ranching : '), write(G), nl,
    write('Exp ranching   : '), write(H), write('/') , write(L + (50*H)),nl,
    write('Exp            : '), write(I), write('/'), write(J) ,nl,
    write('Gold           : '), write(K), nl, !.


initPlayer :- write('Welcome to Strukdat Valley ! List of jobs here:'),nl,
              write('1. Farmer'),nl,
              write('2. Rancher'),nl,
              write('3. Fisher'),nl,
              chooseJob.

chooseJob :- write('Choose a Job (1/2/3) :'), read(CC),nl,
    (CC =:= 1 -> asserta(player('Farmer', 1, 1, 0, 1, 0, 1, 0, 300, 0)) ;
     CC =:= 2 -> asserta(player('Rancher', 1, 1, 0, 1, 0, 1, 0, 300, 0)) ;
     CC =:= 3 -> asserta(player('Fisher', 1, 1, 0, 1, 0, 1, 0, 300, 0)) ;
     write('No such job ! Choose again'), nl, chooseJob).

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), I > K, 
           NewLevel is B + 1,
           NewExp is I mod J,
           NewMax is J + 100,
           retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), asserta(player(A,NewLevel,C,D,E,F,G,H,NewExp,NewMax,K,L)),
           write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
           write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
           write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
           write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
           write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
           write('You have leveled up ! '), write(B), write('->'), write(NewLevel).

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), D > L + (50*D),  
           NewLevel is C + 1,
           NewExp is D mod L + (50*D),
           retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), asserta(player(A,B,NewLevel,NewExp,E,F,G,H,I,J,K,L)),
           write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
           write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
           write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
           write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
           write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
           write('You farming skillz leveled up ! '), write(C), write('->'), write(NewLevel).

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), F > L + (50*F), 
           NewLevel is E + 1,
           NewExp is F mod L + (50*F) ,
           retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), asserta(player(A,B,NewLevel,NewExp,E,F,G,H,I,J,K,L)),
           write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
           write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
           write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
           write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
           write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
           write('Your fishing skillz leveled up ! '), write(E), write('->'), write(NewLevel).

levelUp :- player(A,B,C,D,E,F,G,H,I,J,K,L), H > L + (50*H), 
           NewLevel is G + 1,
           NewExp is H mod L + (50*H),
           retract(player(A,B,C,D,E,F,G,H,I,J,K,L)), asserta(player(A,B,NewLevel,NewExp,E,F,G,H,I,J,K,L)),
           write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
           write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
           write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
           write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
           write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
           write('You ranching skillz leveled up ! '), write(G), write('->'), write(NewLevel).

