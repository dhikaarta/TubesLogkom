:- dynamic(character/4).
:- dynamic(fish/2).
:- dynamic(currentSeason/1).

% simulasi HP, XP, MONEY dan SEASON
start :- asserta(character(100, 100, 0, 0)), asserta(currentSeason(winter)).

fish :- 
    /* validasi fishing rod + bait dan HP */
    character(Health, _, _, _), (Health - 2 >= 0), nl,
    write('Attaching bait to fishing rod...  '), nl,
    write('Casting the fishing rod!          '), nl, nl,
    write('Reeling in...                     '), nl,
    write('                     |            '), nl,
    write('~~~~~~~~~~~~~~~~~~~~~|~~~~        '), nl,
    write('Fishy-fish...   ~    |            '), nl,
    write('                     |  ~         '), nl,
    write('         ~           |            '), nl,
    write('  ~                  o            '), nl,
    write('             ~                    '), nl,
    write('Plz don\'t break @ fishing pole...'), nl, nl,
    write('      ~             ~             '), nl,
    write('==========================        '), nl,

    pickfish, fish(Type, Price), (Type == 'Trash' -> 
        write('A fish fell prey to your bait, but was able to get away.'), 
        nl, write('However, you managed to land a nice pile of Trash. Congrats on keeping the lake clean.'), nl ;
        write('You caught a fish! It\'s '), write(Type), nl, 
        write('You got '), write(Price), write(' Golds'), nl), nl,

    fishxpmoney, !.

fish :- 
    write('Not enough HP (atau belom ngetik <start>, untuk sementara harus ketik <start> dulu sekali baru bisa <fish>)'), !.

fishxpmoney :- fish(Type, Price), character(Health, MaxHealth, Lvl, Money),
    CurLvl is Lvl + 2,
    CurMoney is Money + Price,
    CurHealth is Health - 2,
    retract(character(Health, MaxHealth, Lvl, Money)),
    asserta(character(CurHealth, MaxHealth, CurLvl, CurMoney)), nl,
    
    write('Current HP: '), write(CurHealth), write('/'), write(MaxHealth), nl,
    write('Current XP Fishing: '), write(CurLvl), nl,
    write('Current Money: '), write(CurMoney), write(' (+'), write(Price), write(')'), nl,
    retractall(fish(Type, Price)), !.

% DUMMY FISH TYPES

% unlocked at level 0-30
noobfish :- random(0, 4, X),
        (   X =:= 0 -> asserta(fish('Trash', 0)) ;
            X =:= 1 -> asserta(fish('Teri Biasa Aja', 15)) ; 
            X =:= 2 -> asserta(fish('Teri Mini', 5)) ; 
            X =:= 3 -> asserta(fish('Teri Mikroskopis', 2))     ), !.

% unlocked at level 31-70
avgfish :- random(0, 4, X),
        (   X =:= 0 -> asserta(fish('Trash', 0)) ;
            X =:= 1 -> asserta(fish('Sarden Badan Licin', 65)) ; 
            X =:= 2 -> asserta(fish('Salmon Kulit Crispy Daging Kenyal', 45)) ; 
            X =:= 3 -> asserta(fish('Cupang Menggemaskan', 30))     ), !.

% unlocked at level 71
profish :- random(1, 4, X),  
        (   X =:= 1 -> asserta(fish('Cacing Besar Alaska', 90)) ; 
            X =:= 2 -> asserta(fish('Ayah Nemo', 75)) ; 
            X =:= 3 -> asserta(fish('Geri Si Gurame', 105))     ), !.

% special fishes 4 cammer
summerfish :- random(0, 7, X),
        (   X < 2 -> asserta(fish('Trash', 0)) ;
            X < 4 -> asserta(fish('Kakap Corak Batik khas Nusantara', 150)) ;
            X < 6 -> asserta(fish('Paus Uwu', 170)) ;
            asserta(fish('Lele Raksasa', 250))      ), !.

nooblevel :- random(0, 4, Z),
        (   Z < 2 -> asserta(fish('Trash', 0)) ; noobfish    ), !.

avglevel :- random(0, 6, Z),
        (   Z =:= 0 -> asserta(fish('Trash', 0)) ;
            Z < 3 -> noobfish ;
            avgfish     ), !.

prolevel :- random(0, 10, Z),
        (   Z < 3 -> noobfish ;
            Z < 7 -> avgfish ;
            profish     ), !.

% summer
pickfish :- currentSeason(X), X == summer, character(_, _, Lvl, _),
        random(0, 21, ZZ),
        (   ZZ > 17 -> summerfish ;
            (   Lvl < 31 -> nooblevel ;
                Lvl < 71 -> avglevel ;
                prolevel    )   ), !.

% winter
pickfish :- currentSeason(X), X == winter, character(_, _, Lvl, _),
        random(0, 21, ZZ),
        (   ZZ < 13 -> asserta(fish('Trash', 0)) ;
            (   Lvl < 31 -> nooblevel ;
                Lvl < 71 -> avglevel ;
                prolevel    )   ), !.

% spring & fall
pickfish :- character(_, _, Lvl, _),
        (   Lvl < 31 -> nooblevel ;
            Lvl < 71 -> avglevel ;
            prolevel     ), !.