:- dynamic(currentInventory/1).

currentInventory([]).

/* Count jumlah per item */
totalperItem(_,[],0).

totalperItem(H,[H|T],quantity) :-
    totalItem(H,T,quantity1),
    quantity is quantity1 + 1, !.

totalperItem(H,[_|T],quantity) :-
    totalItem(H,T,quantity), !.

/* util count total item in inventory */
totalitemsUtil([],0) :- !.

totalitemsUtilotalItemsUtil([_|T],X) :-
    totalitemsUtil(T,X1),
    X1 is (1+X), !.

/*count total item in inventory */
totalItems(X) :-
    currentInventory(Inv),
    totalitemsUtil(Inv,X), !.

/*Write item in Inventorty */
writeInv(1,[]) :-
    write("Inventory is empty.\n"), !.

writeInv(0,[]) :- !.

writeInv(1,[H|T]) :-
    currentInventory(Inv),
    totalperItem(H,Inv,quantity),
    format('~w ~wx\n',[quantity,H]),
    writeInv(0,T),!.

writeInv(0,[H|T]) :-
    currentInventory(Inv),
    totalperItem(H,Inv,quantity),
    format('~w ~wx\n',[quantity,H]),
    writeInv(0,T),!.

addItem(_,0) :- !.

addItem(_,_) :-
    totalItems(X),
    X =:= 100, !,
    write("Inventory sudah penuh.\n"), fail.

addItem(_,Total) :-
    totalItems(X),
    X + Total > 100, !,
    write("Inventory tidak cukup.\n"), fail.

addItem(Item,Total):-
    currentInventory(Inv),
    append(Inv,[Item],InvNow),
    retractall(currentInventory(_)),
    assertz(currentInventory(InvNow)),
    TotalNow is Total-1,
    addItem(Item,TotalNow), !.

inventory :-
    currentInventory(Inv),
    Inv =:= [],
    write("Inventory is Empty.\n"), !.

inventory :-
    write('Your Inventory '),
    currentInventory(Inv),
    totalItems(X),
    format('(~w / ~w\n',X,100),
    sort(Inv),
    writeInv(1,Inv), !.

throwItem(Item,amount) :-
    currentInventory(Inv),
    \+ member(Item,Inv), !, 
    format('You don\'t have ~w !\n', [Item] ), fail.

throwItem(Item,amount) :-
    currentInventory(Inv),
    totalperItem(Item,Inv,total),
    amount > total, !,
    format('You don\'t have enough ~w !\n', [Item] ), fail.

throwItem(_,0) :- !.

throwItem(Item,amount) :-
    currentInventory(Inv),
    delete(Item,Inv,InvNow),
    retractall(currentInventory(_)),
    assertz(currentInventory(InvNow)),
    amountNow is amount - 1,
    throwItem(Item,amountNow), !.

sellitem(item,amount) :-
    currentInventory(Inv),
    \+ member(item,Inv), !,
    format('You don\'t have ~w !\n', [item] ), fail.

sellitem(item,amount) :-
    currentInventory(Inv),
    totalperItem(item,Inv,total),
    amount > total, !,
    format('You don\'t have enough ~w !\n', [item] ), fail.

sellitem(_,0) :- !.

sellitem(item,amount) :-
    currentInventory(Inv),
    delete(item,Inv,InvNow),
    retractall(currentInventory(_)),
    assertz(currentInventory(InvNow)),
    itemPrice(item,X),
    player(A,B,C,D,E,F,G,H,I,J,Gold,L),
    GoldNow is Gold + X,
    retractall(player(_,_,_,_,_,_,_,_,_,_,_,_)),
    assertz(player(A,B,C,D,E,F,G,H,I,J,GoldNow,L)),
    amountNow is amount - 1,
    sellitem(item,amountNow), !. 