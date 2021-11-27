:- dynamic(fish/1).

hploss(LevelFish, HPLoss) :- 
    (   LevelFish > 10 -> HPLoss is 10 ;
        HPLoss is 20 - LevelFish  ), !.

fishing :- \+ isExhausted,
    player(Job, Level, _, _, LevelFish, ExpFish, _, _, _, _, _, _),
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

    pickfish, fish(Type), priceitems(Type, Price),
    (   Type == 'Trash' ->  write('A fish fell prey to your bait, but was able to get away.'), nl,
                            write('However, you managed to land a nice pile of Trash.'), 
                            write('Congrats on keeping the lake clean.'), nl ;
        write('You caught a fish! It\'s '), write(Type), nl, 
        format('You can sell this ~w for ~d Golds in the marketplace', [Type, Price]), nl   ), nl,

    NewExpFish is (10 * (LevelFish)),
    NewExp is (2 * Level),
    CurExpFish is NewExpFish + ExpFish,
    (   Job == 'Fisher' ->  write('You were paid for working as a fisher'), nl,
                            Salary is (LevelFish * 5),
                            addGold(Salary)     ), nl,

    write('Current Stamina: '), write(CurHP), write('/'), write(MaxEnergy), nl,
    write('Current XP Fishing: '), write(CurExpFish), nl,

    addItem(Type, 1),
    addExp(NewExp, 0),
    addExp(NewExpFish,2),
    depleteEnergy(HPLoss),
    retractall(fish(Type)), !.

fishing :- player(_, _, _, _, LevelFish, _, _, _, _, _, _, _), energy(HP, _), 
    hploss(LevelFish, HPLoss), CurHP is HP - HPLoss, (CurHP < 0), 
    write('Not enough HP.'), !.

% DUMMY FISH TYPES
% unlocked at level 0-30
noobfish :- random(0, 4, X),
        (   X =:= 0 -> assertz(fish('Trash')) ;
            X =:= 1 -> assertz(fish('Teri Biasa Aja')) ; 
            X =:= 2 -> assertz(fish('Teri Mini')) ; 
            X =:= 3 -> assertz(fish('Teri Mikroskopis'))     ), !.

% unlocked at level 31-70
avgfish :- random(0, 4, X),
        (   X =:= 0 -> assertz(fish('Trash')) ;
            X =:= 1 -> assertz(fish('Sarden Badan Licin')) ; 
            X =:= 2 -> assertz(fish('Salmon Kulit Crispy Daging Kenyal')) ; 
            X =:= 3 -> assertz(fish('Cupang Menggemaskan'))     ), !.

% unlocked at level 71
profish :- random(1, 4, X),  
        (   X =:= 1 -> assertz(fish('Cacing Besar Alaska')) ; 
            X =:= 2 -> assertz(fish('Ayah Nemo')) ; 
            X =:= 3 -> assertz(fish('Geri Si Gurame'))     ), !.

% special fishes 4 cammer
summerfish :- random(0, 7, X),
        (   X < 2 -> assertz(fish('Trash')) ;
            X < 4 -> assertz(fish('Kakap Corak Batik khas Nusantara')) ;
            X < 6 -> assertz(fish('Paus Uwu')) ;
            assertz(fish('Lele Raksasa'))      ), !.

nooblevel :- random(0, 4, Z),
        (   Z < 2 -> assertz(fish('Trash')) ; noobfish    ), !.

avglevel :- random(0, 6, Z),
        (   Z =:= 0 -> assertz(fish('Trash')) ;
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
        (   ZZ < 13 -> assertz(fish('Trash')) ;
            (   LevelFish < 8 -> nooblevel ;
                LevelFish < 15 -> avglevel ;
                prolevel    )   ), !.

% spring & fall
pickfish :- player(_, _, _, _, LevelFish, _, _, _, _, _, _, _),
        (   LevelFish < 8 -> nooblevel ;
            LevelFish < 15 -> avglevel ;
            prolevel     ), !.