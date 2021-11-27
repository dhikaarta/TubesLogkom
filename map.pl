:- dynamic(lengthMap/1).
:- dynamic(widthMap/1).
:- dynamic(normalTile/2).
:- dynamic(fenceTile/2).
:- dynamic(marketplaceTile/2).
:- dynamic(ranchTile/2).
:- dynamic(houseTile/2).
:- dynamic(questTile/2).
:- dynamic(waterTile/2).
:- dynamic(diggedTile/2).
:- dynamic(playerTile/2).
:- dynamic(cropTile/4).

/* FACT */ 
createMap :-
    assertz(lengthMap(16)),
    assertz(widthMap(19)),
    createEmptyMap(0, 0),
    createMarketplaceTile(10, 12),
    createRanchTile(10, 5),
    createHouseTile(7, 6),
    createQuestTile(7, 3),
    createWaterTile(5, 8),
    createWaterTile(6, 8),
    createWaterTile(7, 8),
    createWaterTile(4, 9),
    createWaterTile(5, 9),
    createWaterTile(6, 9),
    createWaterTile(7, 9),
    createWaterTile(8, 9),
    createWaterTile(5, 10),
    createWaterTile(6, 10),
    createWaterTile(7, 10),
    createPlayerTile(8, 7),
    createNormalTile(0, 0).

createEmptyMap(X, Y) :- 
    createEmptyMap(X, Y, []).

createEmptyMap(_, Y, List) :-
    widthMap(L),
    Y =:= L, !,
    maplist(assertz, List), !.

createEmptyMap(X, Y, List) :-
    lengthMap(P),
    widthMap(L),
    X =\= 0, X =\= (P - 1), Y =\= 0, Y =\= (L - 1),
    nextTile(X, Y, XNew, YNew), !,
    createEmptyMap(XNew, YNew, List).

createEmptyMap(X, Y, List) :-
    lengthMap(P),
    widthMap(L),
    (X =:= 0; X =:= (P - 1); Y =:= 0; Y =:= (L - 1)),
    nextTile(X, Y, XNew, YNew), !,
    createEmptyMap(XNew, YNew, [fenceTile(X, Y) | List]).

createNormalTile(X, Y) :-
    createNormalTile(X, Y, []).

createNormalTile(_, Y, List) :-
    widthMap(L),
    Y =:= L, !,
    maplist(assertz, List), !.

createNormalTile(X, Y, List) :-
    (isFenceTile(X, Y); isMarketplaceTile(X, Y); isRanchTile(X, Y); isHouseTile(X, Y); isQuestTile(X, Y); isWaterTile(X, Y); isDiggedTile(X, Y)),
    nextTile(X, Y, XNew, YNew), !,
    createNormalTile(XNew, YNew, List).

createNormalTile(X, Y, List) :-
    \+ (isFenceTile(X, Y)),
    \+ (isMarketplaceTile(X, Y)),
    \+ (isRanchTile(X, Y)),
    \+ (isHouseTile(X, Y)),
    \+ (isQuestTile(X, Y)),
    \+ (isWaterTile(X, Y)),
    \+ (isDiggedTile(X, Y)),
    nextTile(X, Y, XNew, YNew), !,
    createNormalTile(XNew, YNew, [normalTile(X, Y) | List]).

createMarketplaceTile(X, Y) :-
    assertz(marketplaceTile(X, Y)).

createRanchTile(X, Y) :-
    assertz(ranchTile(X, Y)).

createHouseTile(X, Y) :-
    assertz(houseTile(X, Y)).

createQuestTile(X, Y) :-
    assertz(questTile(X, Y)).

createWaterTile(X, Y) :-
    assertz(waterTile(X, Y)).

createPlayerTile(X, Y) :-
    assertz(playerTile(X, Y)).

/* INCREMENT */
nextTile(X, Y, XNew, YNew) :-
    lengthMap(P),
    XNew is ((X + 1) mod P),
    YNew is (Y + ((X + 1) div P)).

/* BOOLEAN */
isNormalTile(X, Y) :-
    normalTile(X, Y), !.

isFenceTile(X, Y) :-
    fenceTile(X, Y), !.

isMarketplaceTile(X, Y) :-
    marketplaceTile(X, Y), !.

isRanchTile(X, Y) :-
    ranchTile(X, Y), !.

isHouseTile(X, Y) :-
    houseTile(X, Y), !.

isQuestTile(X, Y) :-
    questTile(X, Y), !.

isWaterTile(X, Y) :-
    waterTile(X, Y), !.

isDiggedTile(X, Y) :-
    diggedTile(X, Y), !.

isPlayerTile(X, Y) :-
    playerTile(X, Y), !.

isCropTile(X, Y, S, T) :-
    cropTile(X, Y, S, T), !.

/* OUTPUT */
printMap(X, Y) :-
    isNormalTile(X, Y),
    \+ (isPlayerTile(X, Y)),
    write('-'),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    isFenceTile(X, Y),
    lengthMap(P),
    X =\= (P - 1),
    write('#'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isFenceTile(X, Y),
    lengthMap(P),
    widthMap(L),
    X =:= (P - 1),
    Y =\= (L - 1),
    write('#'), nl,
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isFenceTile(X, Y),
    lengthMap(P),
    widthMap(L),
    X =:= (P - 1),
    Y =:= (L - 1),
    write('#'), nl, !.

printMap(X, Y) :-
    isMarketplaceTile(X, Y),
    \+ (isPlayerTile(X, Y)),
    write('M'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isRanchTile(X, Y),
    \+ (isPlayerTile(X, Y)),
    write('R'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isHouseTile(X, Y),
    \+ (isPlayerTile(X, Y)),
    write('H'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isQuestTile(X, Y),
    \+ (isPlayerTile(X, Y)),
    write('Q'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isWaterTile(X, Y),
    \+ (isPlayerTile(X, Y)),
    write('o'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isDiggedTile(X, Y),
    \+ (isPlayerTile(X, Y)),
    write('='),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isPlayerTile(X, Y),
    write('P'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isCropTile(X, Y, S, _),
    \+ (isPlayerTile(X, Y)),
    S == 'bayam Seed',
    Snew = 'bayam',
    retract(cropTile(X, Y, S, T)), !,
    assertz(cropTile(X, Y, Snew, T)), !,
    write('b'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isCropTile(X, Y, S, _),
    \+ (isPlayerTile(X, Y)),
    S == 'wortel Seed',
    Snew = 'wortel',
    retract(cropTile(X, Y, S, T)), !,
    assertz(cropTile(X, Y, Snew, T)), !,    
    write('w'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isCropTile(X, Y, S, _),
    \+ (isPlayerTile(X, Y)),
    S == 'kentang Seed',
    Snew = 'kentang',
    retract(cropTile(X, Y, S, T)), !,
    assertz(cropTile(X, Y, Snew, T)), !, 
    write('k'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isCropTile(X, Y, S, _),
    \+ (isPlayerTile(X, Y)),
    S == 'jagung Seed',
    Snew = 'jagung',
    retract(cropTile(X, Y, S, T)), !,
    assertz(cropTile(X, Y, Snew, T)), !, 
    write('j'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isCropTile(X, Y, S, _),
    \+ (isPlayerTile(X, Y)),
    S == 'cabe Seed',
    Snew = 'cabe',
    retract(cropTile(X, Y, S, T)), !,
    assertz(cropTile(X, Y, Snew, T)), !, 
    write('c'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isCropTile(X, Y, S, _),
    \+ (isPlayerTile(X, Y)),
    S == 'bawang merah Seed',
    Snew = 'bawang merah',
    retract(cropTile(X, Y, S, T)), !,
    assertz(cropTile(X, Y, Snew, T)), !, 
    write('b'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isCropTile(X, Y, S, _),
    \+ (isPlayerTile(X, Y)),
    S == 'bawang putih Seed',
    Snew = 'bawang putih',
    retract(cropTile(X, Y, S, T)), !,
    assertz(cropTile(X, Y, Snew, T)), !, 
    write('b'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isCropTile(X, Y, S, _),
    \+ (isPlayerTile(X, Y)),
    S == 'padi Seed',
    Snew = 'padi',
    retract(cropTile(X, Y, S, T)), !,
    assertz(cropTile(X, Y, Snew, T)), !, 
    write('p'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

printMap(X, Y) :-
    isCropTile(X, Y, S, _),
    \+ (isPlayerTile(X, Y)),
    S == 'kangkung Seed',
    Snew = 'kangkung',
    retract(cropTile(X, Y, S, T)), !,
    assertz(cropTile(X, Y, Snew, T)), !, 
    write('k'),
    nextTile(X, Y, XNew, YNew), !,
    printMap(XNew, YNew).

/* QUERY */
map :-
    printMap(0, 0), !.

/* FARMING */
dig :-
    isPlayerTile(X, Y),
    isNormalTile(X, Y),
    retract(normalTile(X, Y)), !,
    assertz(diggedTile(X, Y)), !,
    write('You digged the tile.'), nl.

sow(S, T) :-
    isPlayerTile(X, Y),
    isDiggedTile(X, Y),
    retract(diggedTile(X, Y)), !,
    assertz(cropTile(X, Y, S, T)), !,
    format('You planted a ~w.', [S]).

reap :-
    isPlayerTile(X, Y),
    isCropTile(X, Y, S, T),
    retract(cropTile(X, Y, S, T)), !,
    assertz(diggedTile(X, Y)), !,
    format('You harvested ~w.', [S]).