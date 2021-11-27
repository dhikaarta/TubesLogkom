shopitem('bait',summer,1).
shopitem('bait',spring,1).
shopitem('chicken feed',summer,2).
shopitem('cow feed',summer,3).
shopitem('sheep feed',summer,4).
shopitem('chicken feed',spring,2).
shopitem('cow feed',spring,3).
shopitem('sheep feed',spring,4).
shopitem('chicken feed',fall,1).
shopitem('cow feed',fall,2).
shopitem('sheep feed',fall,3).
shopitem('chicken feed',winter,1).
shopitem('cow feed',winter,2).
shopitem('sheep feed',winter,3).
shopitem('bayam Seed',summer,5).
shopitem('wortel Seed',spring,5).
shopitem('kentang Seed',summer,6).
shopitem('jagung Seed',spring,6).
shopitem('cabe Seed',summer,7).
shopitem('bawang merah Seed',spring,7).
shopitem('bawang putih Seed',summer,8).
shopitem('padi Seed',spring,8).
shopitem('kangkung Seed',summer,9).
shopitem('bayam Seed',fall,4).
shopitem('wortel Seed',winter,4).
shopitem('kentang Seed',fall,5).
shopitem('jagung Seed',winter,5).
shopitem('cabe Seed',fall,6).
shopitem('bawang merah Seed',winter,6).
shopitem('bawang putih Seed',fall,7).
shopitem('padi Seed',winter,7).
shopitem('kangkung Seed',fall,8).
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

shoppotion('fishing potion',1,500).
shoppotion('ranching potion',2,500).
shoppotion('farming potion',3,500).
shoppotion('EXP potion',4,500).
shoppotion('teleport potion',5,500).
shoppotion('Gamble potion',6,500).

alchemist :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    random(0,5,X),
    (X < 3, write('No Alchemist here, comeback later.\n');
    buyalchemist),!.

buyalchemist :-
    write('Hello, i am alchemist, do you want to buy something?(y/n)\n'),
    read(X),
    (X = n -> write('ヽ(ಠ_ಠ)ノ\n');
    X = y -> write('what do you want to buy?\n'), marketpotion(6,1),
    read(X),
    buypotion(X);
    write('No such option, please try again.\n'),buyalchemist), !.

marketpotion(Y,Y) :-
    shoppotion(Name,Y,Price),
    format('~d. ~w (~d golds)\n',[Y,Name,Price]), !.   
    
marketpotion(Y,Iterate) :-
    shoppotion(Name,Iterate,Price),
    format('~d. ~w (~d golds)\n',[Iterate,Name,Price]),
    IterateNow is Iterate+1,
    marketpotion(Y,IterateNow), !.

buypotion(X) :-
    X < 1, !,
    write('You type wrong number.\n'), fail.

buypotion(X) :-
    X > 6, !,
    write('You type wrong number.\n'), fail.

buypotion(X) :-
    player(_,_,_,_,_,_,_,_,_,_,Gold,_),
    shoppotion(_,X,Price),
    Price > Gold, !,
    write('You dont have enough gold, comeback later!\n'), fail.

buypotion(X) :-
    shoppotion(Name,X,Price),
    loseGold(Price),
    write('You have bought ~w.\n',[Name]),
    usepotion(Name), !.

sell :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    totalItems(X),
    X =:= 0,
    write('You dont have item to sell, comeback later!\n'), !.

sell :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    write('What do you want to sell?\n'),
    currentInventory(Inv),
    writeInv(1,Inv),
    write('>>>'),
    read(Y),
    write('amount : '),
    read(Z),
    sellitem(Y,Z), !.

buy :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    currentSeason(X),
    write('What do you want to buy?\n'),
    market(X),
    read(Y),
    write('How many do you want to buy?\n'),
    read(Z),
    buyItem(X,Y,Z), !.

buyequipment :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    currentSeason(X),
    write('What do you want to buy?\n'),
    marketequip(X),
    read(Y),
    buyequip(X,Y), !.

check(X,Y) :-
    aggregate_all(count, shopitem(_,X,_), Y), !. /* INI ERROR */

checkequip(X,Y) :-
    aggregate_all(count, shopequip(_,X,_,_,_), Y), !. /* INI ERROR */

market(X) :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    check(X,Y),
    market(X,Y,1), !.

market(X,Y,Y) :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    shopitem(Name,X,Y),
    priceitems(Name,Z),
    format('~d. ~w (~d golds)\n',[Y,Name,Z]), !.

market(X,Y,Iterate) :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    shopitem(Name,X,Iterate),
    priceitems(Name,Z),
    format('~d. ~w (~d golds)\n',[Iterate,Name,Z]),
    IterateNow is Iterate+1,
    market(X,Y,IterateNow), !.

marketequip(X) :-
    checkequip(X,Y),
    marketequip(X,Y,1), !.

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
    loseGold(PriceTotal),
    /* add To Ranch Inventory */ 
    format('You have bought ~d ~w.\n',[Z,Name]), 
    format('You are charged ~d.\n',[PriceTotal]), !.

buyItem(X,Y,Z) :-
    shopitem(Name,X,Y),
    priceitems(Name,Price),
    PriceTotal is Price*Z,
    loseGold(PriceTotal),
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
    loseGold(Price),
    changePrice(Name,Price),
    Expmax is Lvl*50,
    changeStats(Name,Lvl,Expmax),
    throwItem(Name,1),
    addItem(Name,1),
    format('You have bought 1 ~w.\n',[Name]), 
    format('You are charged ~d.\n',[Price]), !.