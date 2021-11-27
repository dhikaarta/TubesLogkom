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
shopitem('sapi',summer,10).
shopitem('sapi',fall,9).
shopitem('sapi',winter,8).
shopitem('sapi',spring,9).
shopitem('ayam',summer,11).
shopitem('ayam',fall,10).
shopitem('ayam',winter,9).
shopitem('ayam',spring,10).
shopitem('kambing',summer,12).
shopitem('kambing',fall,11).
shopitem('kambing',winter,10).
shopitem('kambing',spring,11).

shopequip('ranch equip',summer,3,150,1).
shopequip('ranch equip',spring,3,150,1).
shopequip('ranch equip',fall,2,100,1).
shopequip('ranch equip',winter,2,100,1).
shopequip('fishing rod',summer,3,150,2).
shopequip('fishing rod',spring,3,150,2).
shopequip('fishing rod',fall,2,100,2).
shopequip('fishing rod',winter,2,100,2).
shopequip('shovel',summer,2,75,3).
shopequip('shovel',spring,2,75,3).
shopequip('shovel',fall,3,125,3).
shopequip('shovel',winter,3,125,3).
shopequip('watering',summer,2,75,4).
shopequip('watering',spring,2,75,4).
shopequip('watering',fall,3,125,4).
shopequip('watering',winter,3,125,4).

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

buyequipment :-
    currentSeason(X),
    write('What do you want to buy?\n'),
    marketequip(X),
    read(Y),
    buyequip(X,Y), !.

check(X,Y) :-
    aggregate_all(count, shopitem(_,X,_), Y), !.

checkequip(X,Y) :-
    aggregate_all(count, shopequip(_,X,_,_,_), Y), !.

market(X) :-
    check(X,Y),
    market(X,Y,1), !.

marketequip(X) :-
    checkequip(X,Y),
    marketequip(X,Y,1), !.

market(X,Y,Y) :-
    shopitem(Name,X,Y),
    priceitems(Name,Z),
    format('~d. ~w (~d golds)\n',[Y,Name,Z]), !.

market(X,Y,Iterate) :-
    shopitem(Name,X,Iterate),
    priceitems(Name,Z),
    format('~d. ~w (~d golds)\n',[Iterate,Name,Z]),
    IterateNow is Iterate+1,
    market(X,Y,IterateNow), !.

marketequip(X,Y,Y) :-
    shopequip(Name,X,Lvl,Price,Y),
    format('~d. level ~d ~w (~d golds)\n',[Y,Lvl,Name,Price]), !.

marketequip(X,Y,Iterate) :-
    shopequip(Name,X,Lvl,Price,Iterate),
    format('~d. level ~d ~w (~d golds)\n',[Iterate,Lvl,Name,Price]),
    IterateNow is Iterate+1,
    marketequip(X,Y,IterateNow), !.

buyItem(X,_,Z) :-
    totalItems(X),
    X + Z > 100, !,
    write('Inventory full.\n'), fail.

buyItem(X,Y,_) :-
    check(X,Total),
    Total < Y, !,
    write('No Items\n'), fail.

buyItem(X,Y,Z) :-
    shopitem(Name,X,Y),
    priceitems(Name,Price),
    PriceTotal is Price*Z,
    player(_,_,_,_,_,_,_,_,_,_,Gold,_),
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

buyequip(X,_) :-
    totalItems(X),
    X = 100, !,
    write('Inventory full.\n'), fail.

buyequip(X,Y) :-
    checkequip(X,Total),
    Total < Y, !,
    write('No Items\n'), fail.

buyequip(X,Y) :-
    shopequip(_,X,_,Price,Y),
    player(_,_,_,_,_,_,_,_,_,_,Gold,_),
    Gold < Price, !,
    write('You don\'t have enough golds.\n'), fail.

buyequip(X,Y) :-
    shopequip(Name,X,Lvl,Price,Y),
    player(A,B,C,D,E,F,G,H,I,J,Gold,L),
    GoldNow is Gold-Price,
    retractall(player(_,_,_,_,_,_,_,_,_,_,_,_)),
    assertz(player(A,B,C,D,E,F,G,H,I,J,GoldNow,L)),
    changePrice(Name,Price),
    Expmax is Lvl*50,
    changeStats(Name,Lvl,Expmax),
    throwItem(Name,1),
    addItem(Name,1),
    format('You have bought 1 ~w.\n',[Name]), 
    format('You are charged ~d.\n',[Price]), !.