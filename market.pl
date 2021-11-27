:- include('inventory.pl').
:- include('season.pl').

shopitem('bait',summer,1).
shopitem('bait',spring,1).
shopitem('chickenfeed',summer,2).
shopitem('cowfeed',summer,3).
shopitem('sheepfeed',summer,4).
shopitem('chickenfeed',spring,2).
shopitem('cowfeed',spring,3).
shopitem('sheepfeed',spring,4).
shopitem('chickenfeed',fall,1).
shopitem('cowfeed',fall,2).
shopitem('sheepfeed',fall,3).
shopitem('chickenfeed',winter,1).
shopitem('cowfeed',winter,2).
shopitem('sheepfeed',winter,3).
shopitem('bayamSeed',summer,5).
shopitem('wortelSeed',spring,5).
shopitem('kentangSeed',summer,6).
shopitem('jagungSeed',spring,6).
shopitem('cabeSeed',summer,7).
shopitem('bawang_merahSeed',spring,7).
shopitem('bawang_putihSeed',summer,8).
shopitem('padiSeed',spring,8).
shopitem('kangkungSeed',summer,9).
shopitem('bayamSeed',fall,4).
shopitem('wortelSeed',winter,4).
shopitem('kentangSeed',fall,5).
shopitem('jagungSeed',winter,5).
shopitem('cabeSeed',fall,6).
shopitem('bawang_merahSeed',winter,6).
shopitem('bawang_putihSeed',fall,7).
shopitem('padiSeed',winter,7).
shopitem('kangkungSeed',fall,8).
shopitem('sapi',summer,10),
shopitem('sapi',fall,9),
shopitem('sapi',winter,8),
shopitem('sapi',spring,9),
shopitem('ayam',summer,11),
shopitem('ayam',fall,10),
shopitem('ayam',winter,9),
shopitem('ayam',spring,10),
shopitem('kambing',summer,12),
shopitem('kambing',fall,11),
shopitem('kambing',winter,10),
shopitem('kambing',spring,11),

sell :-
    totalItems(X),
    X =:= 0,
    write('You dont have item to sell, comeback later!\n'), !.

sell :-
    write('What do you want to sell?\n'),
    currentInventory(Inv),
    writeInv(1,Inv),
    write('>>>'),
    read(Y),
    write('amount : '),
    read(Z),
    sellitem(Y,Z), !.

buy :-
    currentSeason(X),
    write('What do you want to buy?\n'),
    market(X),
    read(Y),
    write('How many do you want to buy?\n'),
    read(Z),
    buyItem(X,Y,Z), !.

check(X,Y) :-
    aggregate_all(count, shopitem(_,X,_), Y), !.

market(X) :-
    check(X,Y),
    market(X,Y,1), !.

market(X,1,Z) :-
    shopitem(Name,X,1),
    priceitems(Name,Y),
    format('~d. ~w (~d golds)\n',[Z,Name,Y]), !.

market(X,Y,Iterate) :-
    shopitem(Name,X,Y),
    priceitems(Name,Z),
    format('~d. ~w (~d golds)\n',[Iterate,Name,Z]),
    Y1 is Y-1,
    IterateNow is Iterate+1,
    market(X,Y1,IterateNow), !.

buyItem(X,Y,Z) :-
    currentInventory(Inv),
    totalItems(X),
    X + Z > 100, !,
    write('Inventory full.\n'), fail.

buyItem(X,Y,Z) :-
    check(X,Total),
    Total < Y, !,
    write('No Items\n'), fail.

buyItem(X,Y,Z) :-
    shopitem(Name,X,Y),
    priceitems(Name,Price),
    PriceTotal is Price*Z,
    player(A,B,C,D,E,F,G,H,I,J,Gold,L),
    Gold < PriceTotal, !,
    write('You don\'t have enough golds.\n'), fail.

buyItem(X,Y,Z) :-
    shopitem(Name,X,Y),
    items(Type,Name),
    Type = animal,!,
    priceitems(Name,Price),
    PriceTotal is Price*Z,
    player(A,B,C,D,E,F,G,H,I,J,Gold,L),
    GoldNow is Gold-PriceTotal,
    retractall(player(_,_,_,_,_,_,_,_,_,_,_,_)),
    assertz(player(A,B,C,D,E,F,G,H,I,J,GoldNow,L)),
    /* add To Ranch Inventory */ 
    format('You have bought ~d ~w.\n',[Z,Name]), 
    format('You are charged ~d.\n',[PriceTotal]), !.

buyItem(X,Y,Z) :-
    shopitem(Name,X,Y),
    priceitems(Name,Price),
    PriceTotal is Price*Z,
    player(A,B,C,D,E,F,G,H,I,J,Gold,L),
    GoldNow is Gold-PriceTotal,
    retractall(player(_,_,_,_,_,_,_,_,_,_,_,_)),
    assertz(player(A,B,C,D,E,F,G,H,I,J,GoldNow,L)),
    addItem(Name,Z), 
    format('You have bought ~d ~w.\n',[Z,Name]), 
    format('You are charged ~d.\n',[PriceTotal]), !.