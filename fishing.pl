:- dynamic(currentFish/1).

hploss(LevelFish, HPLoss) :- 
    (   LevelFish > 10 -> HPLoss is 10 ;
        HPLoss is 20 - LevelFish  ), !.

fish :- \+ (totalItemsType(Z, bait), Z =:= 0),
    isPlayerTile(A, B),
    isTepiAirTile(A, B),
    \+ isExhausted,
    player(Job, Level, _, _, LevelFish, ExpFish, _, _, _, _, _, _),
    energy(HP, MaxEnergy), hploss(LevelFish, HPLoss), CurHP is HP - HPLoss,
    (CurHP >= 0), nl, 

    throwItem('bait', 1),
    equip('fishing rod', EquipLvl, EquipXPNow, EquipXPMax),
    AddEquipXP is (EquipLvl * 5),
    AddEquipGoldReward is (EquipLvl * 5),

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

    pickfish, currentFish(Type), priceitems(Type, Price),
    (   Type == 'Trash' ->  write('A fish fell prey to your bait, but was able to get away.'), nl,
                            write('However, you managed to land a nice pile of Trash. '), 
                            write('Congrats on keeping the lake clean.'), nl ;
        write('You caught a fish! It\'s '), write(Type), nl, 
        format('You can sell this ~w for ~d Golds in the marketplace', [Type, Price]), nl   ), nl,

    format('Fishing Rod XP +~D', [AddEquipXP]), nl, addGold(AddEquipGoldReward), CurEquipXP is EquipXPNow + AddEquipXP,
    changeStats('fishing rod', EquipLvl, CurEquipXP, EquipXPMax),
    (   CurEquipXP >= EquipXPMax -> nl, levelupTool('fishing rod'), nl, nl ;
        nl, nl ),

    NewExpFish is (10 * (LevelFish)),
    NewExp is (25 * Level),
    CurExpFish is NewExpFish + ExpFish,
    (   Job == 'Fisher' ->  write('You were paid for working as a fisher'), nl,
                            Salary is (LevelFish * 5),
                            addGold(Salary), nl  ;
        nl  ),

    write('Current Stamina: '), write(CurHP), write('/'), write(MaxEnergy), nl,
    write('Current XP Fishing: '), write(CurExpFish), nl,

    addItem(Type, 1),
    addExp(NewExp, 0),
    addExp(NewExpFish,2),
    depleteEnergy(HPLoss),
    retractall(currentFish(Type)), 
    
    random(1, 101, Chance),
    (   Chance > 95 -> nl, nl, fishAccident, nl ;
        nl  ), !.

fish :- (totalItemsType(Z, bait), Z =:= 0),
    write('You don\'t have any bait. Buy it first in the marketplace.'), !.

fish :- 
    isPlayerTile(A, B),
    isTepiAirTile(A, B),
    player(_, _, _, _, LevelFish, _, _, _, _, _, _, _), energy(HP, _), 
    hploss(LevelFish, HPLoss), CurHP is HP - HPLoss, (CurHP < 0), 
    write('Not enough HP.'), !.

% DUMMY FISH TYPES
% unlocked at level 0-3
noobfish :- random(0, 4, X),
        (   X =:= 0 -> assertz(currentFish('Trash')) ;
            X =:= 1 -> assertz(currentFish('Teri Biasa Aja')) ; 
            X =:= 2 -> assertz(currentFish('Teri Mini')) ; 
            X =:= 3 -> assertz(currentFish('Teri Mikroskopis'))     ), !.

% unlocked at level 4-7
avgfish :- random(0, 4, X),
        (   X =:= 0 -> assertz(currentFish('Trash')) ;
            X =:= 1 -> assertz(currentFish('Sarden Badan Licin')) ; 
            X =:= 2 -> assertz(currentFish('Salmon Kulit Crispy Daging Kenyal')) ; 
            X =:= 3 -> assertz(currentFish('Cupang Menggemaskan'))     ), !.

% unlocked at level 8
profish :- random(1, 4, X),  
        (   X =:= 1 -> assertz(currentFish('Cacing Besar Alaska')) ; 
            X =:= 2 -> assertz(currentFish('Ayah Nemo')) ; 
            X =:= 3 -> assertz(currentFish('Geri Si Gurame'))     ), !.

% special fishes 4 cammer
summerfish :- random(0, 7, X),
        (   X < 2 -> assertz(currentFish('Trash')) ;
            X < 4 -> assertz(currentFish('Kakap Corak Batik khas Nusantara')) ;
            X < 6 -> assertz(currentFish('Paus Uwu')) ;
            assertz(currentFish('Lele Raksasa'))      ), !.

nooblevel :- random(0, 4, Z),
        (   Z < 2 -> assertz(currentFish('Trash')) ; noobfish    ), !.

avglevel :- random(0, 6, Z),
        (   Z =:= 0 -> assertz(currentFish('Trash')) ;
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
            (   LevelFish < 4 -> nooblevel ;
                LevelFish < 8 -> avglevel ;
                prolevel    )   ), !.

% winter
pickfish :- currentSeason(X), X == winter,
        player(_, _, _, _, LevelFish, _, _, _, _, _, _, _),
        random(0, 21, ZZ),
        (   ZZ < 13 -> assertz(currentFish('Trash')) ;
            (   LevelFish < 4 -> nooblevel ;
                LevelFish < 8 -> avglevel ;
                prolevel    )   ), !.

% spring & fall
pickfish :- player(_, _, _, _, LevelFish, _, _, _, _, _, _, _),
        (   LevelFish < 4 -> nooblevel ;
            LevelFish < 8 -> avglevel ;
            prolevel     ), !.