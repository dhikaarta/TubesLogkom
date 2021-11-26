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

sellitem(item,amount) :-
    Linventory(Inv),
    \+ member(item,Inv), !,
    format('You don\'t have ~w !\n', [item] ), fail.

sellitem(item,amount) :-
    Linventory(Inv),
    totalperItem(item,Inv,total),
    amount > total, !,
    format('You don\'t have enough ~w !\n', [item] ), fail.]

sellitem(_,0) :- !.

sellitem(item,amount) :-
    Linventory(Inv),
    delete(item,Inv,InvNow),
    retractall(Linventory(_)),
    assertz(Linventory(InvNow)),
    itemPrice(item,X),
    player(A,B,C,D,E,F,G,H,I,J,Gold,L),
    GoldNow is Gold + X,
    retractall(player(_,_,_,_,_,_,_,_,_,_,_,_)),
    assertz(player(A,B,C,D,E,F,G,H,I,J,GoldNow,L)),
    amountNow is amount - 1
    sellitem(item,amountNow), !. 
