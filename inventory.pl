:- dynamic(Linventory/1).

Linventory([]).

/* Count jumlah per item */
totalperItem(_,[],0).

totalperItem(H,[H|T],quantity) :-
    totalItem(H,T,quantity1),
    quantity is quantity1 + 1, !.

totalperItem(H,[_|T],quantity) :-
    totalItem(H,T,quantity), !.

/* util count total item in inventory */
TotalItemsUtil([],0).

TotalItemsUtil([_|T],X) :-
    TotalItemsUtil(T,X1),
    X1 is (1+X), !.

/*count total item in inventory */
TotalItems(X) :-
    Linventory(Inv),
    TotalItemsUtil(Inv,X), !.

/*Write item in Inventorty */
writeInv(1,[]) :-
    write("Inventory is empty.\n"), !.

writeInv(0,[]) :- !.

writeInv(1,[H|T]) :-
    Linventory(Inv),
    totalperItem(H,Inv,quantity),
    format('~w ~wx\n',[quantity,H]),
    writeInvy(0,T),!.

writeInv(0,[H|T]) :-
    Linventory(Inv),
    totalperItem(H,Inv,quantity),
    format('~w ~wx\n',[quantity,H]),
    writeInv(0,T),!.

addInv(_,0) :- !.

addInv(Item,Total):-
    TotalItems(X),
    X =:= 100,
    write("Inventory sudah penuh.\n"), !.

addInv(Item,Total):-
    TotalItems(X),
    Linventory(Inv),
    append(Inv,[Item],InvNow),
    retractall(Linventory(_)),
    asserta(Linventory(InvNow)),
    TotalNow is Total-1,
    addInv(Item,TotalNow), !.

inventory :-
    write('█ █▄░█ █░█ █▀▀ █▄░█ ▀█▀ █▀█ █▀█ █▄█\n'),
    write('█ █░▀█ ▀▄▀ ██▄ █░▀█ ░█░ █▄█ █▀▄ ░█░\n'), nl,
    Linventory(Inv),
    Inv =:= [],
    write("Inventory is Empty.\n"), !.

inventory :-
    write('█ █▄░█ █░█ █▀▀ █▄░█ ▀█▀ █▀█ █▀█ █▄█\n'),
    write('█ █░▀█ ▀▄▀ ██▄ █░▀█ ░█░ █▄█ █▀▄ ░█░\n'), nl,
    write('Your Inventory '),
    Linventory(Inv),
    TotalItems(X),
    format('(~w / ~w\n',X,100),
    sort(Inv),
    writeInv(1,Inv), !.

throwItem(Item,amount) :-
    Linventory(Inv),
    \+ member(Item,Inv), !, 
    format('You don\'t have ~w !', [Item] ), fail.

throwItem(Item,0) :- !.

throwItem(Item,amount) :-
    Linventory(Inv),
    delete(Item,Inv,InvNow),
    retractall(Linventory(_)),
    asserta(Linventory(InvNow)),
    amountNow is amount - 1,
    throwItem(Item,amountNow), !.