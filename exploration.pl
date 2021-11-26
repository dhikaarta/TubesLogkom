/* QUERY */
w :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y - 1,
    isWaterTile(XNew, YNew),
    write('You cant get into water!'), nl.

w :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y - 1,
    isFenceTile(XNew, YNew),
    write('You cant walk past fence!'), nl.

w :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y - 1,
    \+ (isWaterTile(XNew, YNew)),
    \+ (isFenceTile(XNew, YNew)),
    retract(playerTile(X, Y)), !,
    assertz(playerTile(XNew, YNew)), !,
    write('You moved north.'), nl.

a :-
    isPlayerTile(X, Y),
    XNew is X - 1,
    YNew is Y,
    isWaterTile(XNew, YNew),
    write('You cant get into water!'), nl.

a :-
    isPlayerTile(X, Y),
    XNew is X - 1,
    YNew is Y,
    isFenceTile(XNew, YNew),
    write('You cant walk past fence!'), nl.

a :-
    isPlayerTile(X, Y),
    XNew is X - 1,
    YNew is Y,
    \+ (isWaterTile(XNew, YNew)),
    \+ (isFenceTile(XNew, YNew)),
    retract(playerTile(X, Y)), !,
    assertz(playerTile(XNew, YNew)), !,
    write('You moved west.'), nl.

s :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y + 1,
    isWaterTile(XNew, YNew),
    write('You cant get into water!'), nl.

s :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y + 1,
    isFenceTile(XNew, YNew),
    write('You cant walk past fence!'), nl.

s :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y + 1,
    \+ (isWaterTile(XNew, YNew)),
    \+ (isFenceTile(XNew, YNew)),
    retract(playerTile(X, Y)), !,
    assertz(playerTile(XNew, YNew)), !,
    write('You moved south.'), nl.

d :-
    isPlayerTile(X, Y),
    XNew is X + 1,
    YNew is Y,
    isWaterTile(XNew, YNew),
    write('You cant get into water!'), nl.

d :-
    isPlayerTile(X, Y),
    XNew is X + 1,
    YNew is Y,
    isFenceTile(XNew, YNew),
    write('You cant walk past fence!'), nl.

d :-
    isPlayerTile(X, Y),
    XNew is X + 1,
    YNew is Y,
    \+ (isWaterTile(XNew, YNew)),
    \+ (isFenceTile(XNew, YNew)),
    retract(playerTile(X, Y)), !,
    assertz(playerTile(XNew, YNew)), !,
    write('You moved east.'), nl.

dig :-
    isPlayerTile(X, Y),
    isNormalTile(X, Y),
    retract(normalTile(X, Y)), !,
    assertz(diggedTile(X, Y)), !,
    write('You digged the tile.'), nl.