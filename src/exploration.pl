/* QUERY */
w :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y - 1,
    isWaterTile(XNew, YNew), !,
    write('You can\'t get into water!'), nl.

w :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y - 1,
    isFenceTile(XNew, YNew), !,
    write('You can\'t walk past fence!'), nl.

w :-
    isPlayerTile(X, Y),
    isHouseTile(X, Y), !,
    (isLocked -> write('You are locked in your house! Please unlock your door!'), nl ;
    \+ (isLocked) -> XNew is X, YNew is Y - 1, \+ (isWaterTile(XNew, YNew)), \+ (isFenceTile(XNew, YNew)), retract(playerTile(X, Y)), !, assertz(playerTile(XNew, YNew)), !, write('You moved north.'), nl, printSpecialTile).

w :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y - 1,
    \+ (isWaterTile(XNew, YNew)),
    \+ (isFenceTile(XNew, YNew)),
    retract(playerTile(X, Y)), !,
    assertz(playerTile(XNew, YNew)), !,
    write('You moved north.'), nl,
    printSpecialTile.

a :-
    isPlayerTile(X, Y),
    XNew is X - 1,
    YNew is Y,
    isWaterTile(XNew, YNew), !,
    write('You can\'t get into water!'), nl.

a :-
    isPlayerTile(X, Y),
    XNew is X - 1,
    YNew is Y,
    isFenceTile(XNew, YNew), !,
    write('You can\'t walk past fence!'), nl.

a :-
    isPlayerTile(X, Y),
    isHouseTile(X, Y), !,
    (isLocked -> write('You are locked in your house! Please unlock your door!'), nl ;
    \+ (isLocked) -> XNew is X - 1, YNew is Y, \+ (isWaterTile(XNew, YNew)), \+ (isFenceTile(XNew, YNew)), retract(playerTile(X, Y)), !, assertz(playerTile(XNew, YNew)), !, write('You moved west.'), nl, printSpecialTile).

a :-
    isPlayerTile(X, Y),
    XNew is X - 1,
    YNew is Y,
    \+ (isWaterTile(XNew, YNew)),
    \+ (isFenceTile(XNew, YNew)),
    retract(playerTile(X, Y)), !,
    assertz(playerTile(XNew, YNew)), !,
    write('You moved west.'), nl,
    printSpecialTile.

s :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y + 1,
    isWaterTile(XNew, YNew), !,
    write('You can\'t get into water!'), nl.

s :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y + 1,
    isFenceTile(XNew, YNew), !,
    write('You can\'t walk past fence!'), nl.

s :-
    isPlayerTile(X, Y),
    isHouseTile(X, Y), !,
    (isLocked -> write('You are locked in your house! Please unlock your door!'), nl ;
    \+ (isLocked) -> XNew is X, YNew is Y + 1, \+ (isWaterTile(XNew, YNew)), \+ (isFenceTile(XNew, YNew)), retract(playerTile(X, Y)), !, assertz(playerTile(XNew, YNew)), !, write('You moved south.'), nl, printSpecialTile).

s :-
    isPlayerTile(X, Y),
    XNew is X,
    YNew is Y + 1,
    \+ (isWaterTile(XNew, YNew)),
    \+ (isFenceTile(XNew, YNew)),
    retract(playerTile(X, Y)), !,
    assertz(playerTile(XNew, YNew)), !,
    write('You moved south.'), nl,
    printSpecialTile.

d :-
    isPlayerTile(X, Y),
    XNew is X + 1,
    YNew is Y,
    isWaterTile(XNew, YNew), !,
    write('You can\'t get into water!'), nl.

d :-
    isPlayerTile(X, Y),
    XNew is X + 1,
    YNew is Y,
    isFenceTile(XNew, YNew), !,
    write('You can\'t walk past fence!'), nl.

d :-
    isPlayerTile(X, Y),
    isHouseTile(X, Y), !,
    (isLocked -> write('You are locked in your house! Please unlock your door!'), nl ;
    \+ (isLocked) -> XNew is X + 1, YNew is Y, \+ (isWaterTile(XNew, YNew)), \+ (isFenceTile(XNew, YNew)), retract(playerTile(X, Y)), !, assertz(playerTile(XNew, YNew)), !, write('You moved east.'), nl, printSpecialTile).

d :-
    isPlayerTile(X, Y),
    XNew is X + 1,
    YNew is Y,
    \+ (isWaterTile(XNew, YNew)),
    \+ (isFenceTile(XNew, YNew)),
    retract(playerTile(X, Y)), !,
    assertz(playerTile(XNew, YNew)), !,
    write('You moved east.'), nl,
    printSpecialTile.

teleport(A, B) :-
    isPlayerTile(X, Y),
    retract(playerTile(X, Y)), !,
    assertz(playerTile(A, B)), !,
    write('You teleported.'), nl,
    printSpecialTile.