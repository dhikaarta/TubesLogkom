:- include('inventory.pl').

sell :-
    TotalItems(X),
    X =:= 0,
    write('You dont have item to sell, comeback later!\n'), !.

sell :-
    write('What do you want to sell?\n'),
    Linventory(Inv),
    writeInv(1,Inv),
    write('>>>'),
    read(Y),
    write('amount : '),
    read(Z),
    sellitem(Y,Z), !.

sellitem(_,0) :- !.

sellitem(item,amount) :-
    Linventory(Inv),
    \+ member(item,Inv),
    format('You don\'t have ~w !\n', [Item] ), fail.

sellitem(item,amount) :-
    Linventory(Inv),
    delete(item,Inv,InvNow),
    retractall(Linventory(_)),
    asserta(Linventory(InvNow)),
    itemPrice(item,X),
    /* goldPlayer is goldPlayer + X */
    amountNow is amount - 1
    sellitem(item,amountNow), !. 
