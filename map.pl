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

/* INISIALISASI FAKTA */
createMap :-
    asserta(lengthMap(16)),
    asserta(widthMap(19)),
    createEmptyTile(0, 0),
    createMarketplaceTile(10, 12),
    createMarketplaceTile(10, 12),
    createRanchTile(10, 4),
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
    createPlayerTile(8, 7).

createEmptyTile(X, Y) :-
    lengthMap(P),
    widthMap(L),
    X =:= (P - 1),
    Y =:= (L - 1),
    createBaseTile(X, Y), !.

createEmptyTile(X, Y) :-
    lengthMap(P),
    widthMap(L),
    (X =\= (P - 1); Y =\= (L - 1)),
    createBaseTile(X, Y),
    nextTile(X, Y, XNew, YNew), !,
    createEmptyTile(XNew, YNew).

createBaseTile(X, Y) :-
    lengthMap(P),
    widthMap(L),
    X =\= 0, X =\= (P - 1), Y =\= 0, Y =\= (L - 1),
    asserta(normalTile(X, Y)).

createBaseTile(X, Y) :-
    lengthMap(P),
    widthMap(L),
    (X =:= 0; X =:= (P - 1); Y =:= 0; Y =:= (L - 1)),
    asserta(fenceTile(X, Y)).

createMarketplaceTile(X, Y) :-
    /*retract(normalTile(X, Y)),*/
    asserta(marketplaceTile(X, Y)).

createRanchTile(X, Y) :-
    /*retract(normalTile(X, Y)),*/
    asserta(ranchTile(X, Y)).

createHouseTile(X, Y) :-
    /*retract(normalTile(X, Y)),*/
    asserta(houseTile(X, Y)).

createQuestTile(X, Y) :-
    /*retract(normalTile(X, Y)),*/
    asserta(questTile(X, Y)).

createWaterTile(X, Y) :-
    /*retract(normalTile(X, Y)),*/
    asserta(waterTile(X, Y)).

createDiggedTile(X, Y) :-
    /*retract(normalTile(X, Y)),*/
    asserta(diggedTile(X, Y)).

createPlayerTile(X, Y) :-
    asserta(playerTile(X, Y)).

/* INCREMENT */
nextTile(X, Y, XNew, YNew) :-
    lengthMap(P),
    XNew is ((X + 1) mod P),
    YNew is (Y + ((X + 1) div P)).

/* OUTPUT */
printMap(X, Y) :-
    normalTile(X, Y),
    write('-'),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    fenceTile(X, Y),
    lengthMap(P),
    X =\= (P - 1),
    write('#'),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    fenceTile(X, Y),
    lengthMap(P),
    widthMap(L),
    X =:= (P - 1),
    Y =\= (L - 1),
    write('#'), nl,
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    fenceTile(X, Y),
    lengthMap(P),
    widthMap(L),
    X =:= (P - 1),
    Y =:= (L - 1),
    write('#'), nl.

printMap(X, Y) :-
    marketplaceTile(X, Y),
    write('M'),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    ranchTile(X, Y),
    write('R'),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    houseTile(X, Y),
    write('H'),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    questTile(X, Y),
    write('Q'),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    waterTile(X, Y),
    write('o'),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    diggedTile(X, Y),
    write('='),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

printMap(X, Y) :-
    playerTile(X, Y),
    write('P'),
    nextTile(X, Y, XNew, YNew),
    printMap(XNew, YNew).

/* QUERY */
map :-
    printMap(0, 0).