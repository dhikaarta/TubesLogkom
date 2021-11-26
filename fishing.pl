:- dynamic(fish/2).

hploss(LevelFish, HPLoss) :- 
    (   LevelFish > 10 -> HPLoss is 10 ;
        HPLoss is 20 - LevelFish  ), !.

fishing :- \+ isExhausted,
    player(Job, Level, C, D, LevelFish, ExpFish, E, F, Exp, G, Money, H),
    energy(HP, MaxEnergy), hploss(LevelFish, HPLoss), CurHP is HP - HPLoss,
    (CurHP >= 0), nl, 
    /* validasi fishing rod + bait */
    write('Attaching bait to fishing rod...  '), nl,
    write('Casting the fishing rod!          '), nl, nl,
    write('Reeling in...                     '), nl,
    write('                     |            '), nl,
    write('~~~~~~~~~~~~~~~~~~~~~|~~~~~       '), nl,
    write('                     |            '), nl,
    write('Fishy-fish...   ~    |            '), nl,
    write('                     |  ~         '), nl,
    write('         ~           |            '), nl,
    write('  ~                  o            '), nl,
    write('             ~                    '), nl,
    write('Plz don\'t break @ fishing pole...'), nl, nl,
    write('      ~             ~             '), nl,
    write('===========================       '), nl,

    pickfish, fish(Type, Price), (Type == 'Trash' -> 
        write('A fish fell prey to your bait, but was able to get away.'), 
        nl, write('However, you managed to land a nice pile of Trash. Congrats on keeping the lake clean.'), nl ;
        write('You caught a fish! It\'s '), write(Type), nl, 
        write('You got '), write(Price), write(' Golds'), nl), nl,

    CurExpFish is (10 * (LevelFish)) + ExpFish,
    CurExp is (2 * Level) + Exp,
    (   Job == 'Fisher' -> NewMoney is (Price + (LevelFish * 5)) ;
        NewMoney is Price ),
    CurMoney is Money + NewMoney,

    write('Current Stamina: '), write(CurHP), write('/'), write(MaxEnergy), nl,
    write('Current XP Fishing: '), write(CurExpFish), nl,
    write('Current Money: '), write(CurMoney), write(' (+'), write(NewMoney), write(')'), nl,
    retractall(player(Job, Level, C, D, LevelFish, ExpFish, E, F, Exp, G, Money, H)),
    assertz(player(Job, Level, C, D, LevelFish, CurExpFish, E, F, CurExp, G, CurMoney, H)),
    depleteEnergy(HPLoss),
    retractall(fish(Type, Price)), !.

fishing :- player(_, _, _, _, LevelFish, _, _, _, _, _, _, _), energy(HP, _), 
    hploss(LevelFish, HPLoss), CurHP is HP - HPLoss, (CurHP < 0), 
    write('Not enough HP.'), !.

% DUMMY FISH TYPES
% unlocked at level 0-30
noobfish :- random(0, 4, X),
        (   X =:= 0 -> assertz(fish('Trash', 0)) ;
            X =:= 1 -> assertz(fish('Teri Biasa Aja', 15)) ; 
            X =:= 2 -> assertz(fish('Teri Mini', 5)) ; 
            X =:= 3 -> assertz(fish('Teri Mikroskopis', 2))     ), !.

% unlocked at level 31-70
avgfish :- random(0, 4, X),
        (   X =:= 0 -> assertz(fish('Trash', 0)) ;
            X =:= 1 -> assertz(fish('Sarden Badan Licin', 65)) ; 
            X =:= 2 -> assertz(fish('Salmon Kulit Crispy Daging Kenyal', 45)) ; 
            X =:= 3 -> assertz(fish('Cupang Menggemaskan', 30))     ), !.

% unlocked at level 71
profish :- random(1, 4, X),  
        (   X =:= 1 -> assertz(fish('Cacing Besar Alaska', 90)) ; 
            X =:= 2 -> assertz(fish('Ayah Nemo', 75)) ; 
            X =:= 3 -> assertz(fish('Geri Si Gurame', 105))     ), !.

% special fishes 4 cammer
summerfish :- random(0, 7, X),
        (   X < 2 -> assertz(fish('Trash', 0)) ;
            X < 4 -> assertz(fish('Kakap Corak Batik khas Nusantara', 150)) ;
            X < 6 -> assertz(fish('Paus Uwu', 170)) ;
            assertz(fish('Lele Raksasa', 250))      ), !.

nooblevel :- random(0, 4, Z),
        (   Z < 2 -> assertz(fish('Trash', 0)) ; noobfish    ), !.

avglevel :- random(0, 6, Z),
        (   Z =:= 0 -> assertz(fish('Trash', 0)) ;
            Z < 3 -> noobfish ;
            avgfish     ), !.

prolevel :- random(0, 10, Z),
        (   Z < 3 -> noobfish ;
            Z < 7 -> avgfish ;
            profish     ), !.

% summer
pickfish :- currentSeason(X), X == summer, 
        player(_, _, _, _, LevelFish, _, _, _, _, _, _, _),
        random(0, 21, ZZ),
        (   ZZ > 17 -> summerfish ;
            (   LevelFish < 8 -> nooblevel ;
                LevelFish < 15 -> avglevel ;
                prolevel    )   ), !.

% winter
pickfish :- currentSeason(X), X == winter,
        player(_, _, _, _, LevelFish, _, _, _, _, _, _, _),
        random(0, 21, ZZ),
        (   ZZ < 13 -> assertz(fish('Trash', 0)) ;
            (   LevelFish < 8 -> nooblevel ;
                LevelFish < 15 -> avglevel ;
                prolevel    )   ), !.

% spring & fall
pickfish :- player(_, _, _, _, LevelFish, _, _, _, _, _, _, _),
        (   LevelFish < 8 -> nooblevel ;
            LevelFish < 15 -> avglevel ;
            prolevel     ), !.