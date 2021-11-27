:- include('items.pl').
:- include('player.pl').

:- dynamic(currentInventory/1).

currentInventory([]).

/* Count jumlah per item */
totalperItem(_,[],0).

totalperItem(H,[H|T],Quantity) :-
    totalperItem(H,T,Quantity1),
    Quantity is Quantity1 + 1, !.

totalperItem(H,[_|T],Quantity) :-
    totalperItem(H,T,Quantity), !.

/* util count total item in inventory */
countInvUtil([],0).
countInvUtil([_|T],X) :-
    countInvUtil(T,Y),
    X is (1+Y),!.

totalItems(X) :-
    currentInventory(Inv),
    countInvUtil(Inv,X),!.

/*Write item in Inventorty */
writeInv(1,[]) :-
    write('Inventory is empty.\n'), !.

writeInv(0,[]) :- !.

writeInv(1,[H|T]) :-
    currentInventory(Inv),
    totalperItem(H,Inv,Quantity),
    format('~w ~w\n',[Quantity,H]),
    writeInv(0,T),!.

writeInv(0,[H|T]) :-
    currentInventory(Inv),
    totalperItem(H,Inv,Quantity),
    format('~w ~w\n',[Quantity,H]),
    writeInv(0,T),!.

addItem(_,0).

addItem(_,_) :-
    totalItems(X),
    X =:= 100, !,
    write('Inventory sudah penuh.\n'), fail.

addItem(_,Total) :-
    totalItems(X),
    X + Total > 100, !,
    write('Inventory tidak cukup.\n'), fail.

addItem(Item,Total):-
    currentInventory(Inv),
    append(Inv,[Item],InvNow),
    retractall(currentInventory(_)),
    assertz(currentInventory(InvNow)),
    TotalNow is Total-1,
    addItem(Item,TotalNow), !.

inventory :-
    currentInventory(Inv),
    Inv = [],
    write('Inventory is Empty.\n'), !.

inventory :-
    write('Your Inventory '),
    currentInventory(Inv),
    totalItems(X),
    format('(~w / ~w)\n',[X,100]),
    sort(Inv,Inv2),
    writeInv(1,Inv2), !.

remover(_, [], []).
remover(R, [R|T], T).
remover(R, [H|T], [H|T2]) :- H \= R, remover( R, T, T2).

throwItem(_,0).

throwItem(Item,_) :-
    currentInventory(Inv),
    \+ member(Item,Inv), !, 
    format('You don\'t have ~w !\n', [Item] ), fail.

throwItem(Item,Amount) :-
    currentInventory(Inv),
    totalperItem(Item,Inv,Total),
    Amount > Total, !,
    format('You don\'t have enough ~w !\n', [Item] ), fail.

throwItem(Item,Amount) :-
    currentInventory(Inv),
    remover(Item,Inv,InvNow),
    retractall(currentInventory(_)),
    assertz(currentInventory(InvNow)),
    AmountNow is Amount - 1,
    throwItem(Item,AmountNow), !.

sellitem(Item,_) :-
    currentInventory(Inv),
    \+ member(Item,Inv), !,
    format('You don\'t have ~w !\n', [Item] ), fail.

sellitem(Item,Amount) :-
    currentInventory(Inv),
    totalperItem(Item,Inv,Total),
    Amount > Total, !,
    format('You don\'t have enough ~w !\n', [Item] ), fail.

sellitem(_,0) :- !.

sellitem(Item,Amount) :-
    currentInventory(Inv),
    remover(Item,Inv,InvNow),
    retractall(currentInventory(_)),
    assertz(currentInventory(InvNow)),
    priceitems(Item,X),
    player(A,B,C,D,E,F,G,H,I,J,Gold,L),
    GoldNow is Gold + X,
    retractall(player(_,_,_,_,_,_,_,_,_,_,_,_)),
    assertz(player(A,B,C,D,E,F,G,H,I,J,GoldNow,L)),
    AmountNow is Amount - 1,
    sellitem(Item,AmountNow), !. 