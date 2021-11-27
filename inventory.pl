:- include('items.pl').

:- dynamic(currentInventory/1).

currentInventory(['ranch equip','shovel','watering','fishing rod']).

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

countInvUtilType([],_,0).
countInvUtilType([H|T],Type,X) :-
    items(Type2,H),
    Type2 \= Type, !,
    countInvUtilType(T,Type,X), !.

countInvUtilType([H|T],Type,X) :-
    items(Type2,H),
    Type2 = Type, !,
    countInvUtilType(T,Type,Y),
    X is (1+Y),!.

totalItemsType(X,Type) :-
    currentInventory(Inv),
    countInvUtilType(Inv,Type,X),!.

/*Write item in Inventorty */
writeInv(1,[]) :-
    write('Inventory is empty.\n'), !.

writeInv(0,[]) :- !.

writeInv(1,[H|T]) :-
    currentInventory(Inv),
    items(Type,H),
    Type \= equip,
    totalperItem(H,Inv,Quantity),
    format('~w ~w\n',[Quantity,H]),
    writeInv(0,T),!.

writeInv(1,[H|T]) :-
    currentInventory(_),
    items(Type,H),
    Type == equip,
    equip(H,Lvl,_,_),
    format('~w Level ~w ~w\n',[1,Lvl,H]),
    writeInv(0,T),!.

writeInv(0,[H|T]) :-
    currentInventory(Inv),
    items(Type,H),
    Type \= equip,
    totalperItem(H,Inv,Quantity),
    format('~w ~w\n',[Quantity,H]),
    writeInv(0,T),!.

writeInv(0,[H|T]) :-
    currentInventory(_),
    items(Type,H),
    Type == equip,
    equip(H,Lvl,_,_),
    format('~w Level ~w ~w\n',[1,Lvl,H]),
    writeInv(0,T),!.

writeInvType(1,_,[]) :-
    write('Inventory is empty.\n'), !.

writeInvType(0,_,[]) :- !.

writeInvType(1,Type,[H|T]) :-
    currentInventory(Inv),
    items(Type1,H),
    Type1 == Type,
    totalperItem(H,Inv,Quantity),
    format('~w ~w\n',[Quantity,H]),
    writeInvType(0,Type,T),!.

writeInvType(0,Type,[H|T]) :-
    currentInventory(Inv),
    items(Type1,H),
    Type1 == Type,
    totalperItem(H,Inv,Quantity),
    format('~w ~w\n',[Quantity,H]),
    writeInvType(0,Type,T),!.

writeInvType(1,Type,[H|T]) :-
    items(Type1,H),
    Type1 \= Type,
    writeInvType(0,Type,T),!.

writeInvType(0,Type,[H|T]) :-
    items(Type1,H),
    Type1 \= Type,
    writeInvType(0,Type,T),!.

writeInvSell(1,[]) :-
    write('Inventory is empty.\n'), !.

writeInvSell(0,[]) :- !.

writeInvSell(1,[H|T]) :-
    currentInventory(Inv),
    items(Type1,H),
    Type1 \= equip,
    totalperItem(H,Inv,Quantity),
    format('~w ~w\n',[Quantity,H]),
    writeInvSell(0,T),!.

writeInvSell(0,[H|T]) :-
    currentInventory(Inv),
    items(Type1,H),
    Type1 \= equip,
    totalperItem(H,Inv,Quantity),
    format('~w ~w\n',[Quantity,H]),
    writeInvSell(0,T),!.

writeInvSell(1,[H|T]) :-
    items(Type1,H),
    Type1 == equip,
    writeInvSell(0,T),!.

writeInvSell(0,[H|T]) :-
    items(Type1,H),
    Type1 == equip,
    writeInvSell(0,T),!.

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
    items(_,Item),!,
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

inventory(_) :-
    currentInventory(Inv),
    Inv = [],
    write('Inventory is Empty.\n'), !.

inventory(Type) :-
    write('Your Inventory\n'),
    currentInventory(Inv),
    sort(Inv,Inv2),
    writeInvType(1,Type,Inv2), !.

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

sellitem(_,0).

sellitem(Item,_) :-
    currentInventory(Inv),
    \+ member(Item,Inv), !,
    format('You don\'t have ~w !\n', [Item] ), fail.

sellitem(Item,Amount) :-
    currentInventory(Inv),
    totalperItem(Item,Inv,Total),
    Amount > Total, !,
    format('You don\'t have enough ~w !\n', [Item] ), fail.

sellitem(Item,Amount) :-
    currentInventory(Inv),
    remover(Item,Inv,InvNow),
    retractall(currentInventory(_)),
    assertz(currentInventory(InvNow)),
    priceitems(Item,X),
    AmountNow is Amount - 1,
    sellitemRec(Item,AmountNow),
    TotalGold is X*Amount,
    addGold(TotalGold), !. 

sellitemRec(_,0).

sellitemRec(Item,Amount) :-
    currentInventory(Inv),
    remover(Item,Inv,InvNow),
    retractall(currentInventory(_)),
    assertz(currentInventory(InvNow)),
    AmountNow is Amount - 1,
    sellitemRec(Item,AmountNow), !. 