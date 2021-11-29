/* FACT item shop */
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

/*Fact equipment item shop*/
shopequip('ranch equip',summer,X,Y,1) :-
    equip('ranch equip',Lvl,_,_),
    X is Lvl + 2,
    Y is (2*Lvl+1)*30.
shopequip('ranch equip',spring,X,Y,1) :-
    equip('ranch equip',Lvl,_,_),
    X is Lvl + 2,
    Y is (2*Lvl+1)*30.
shopequip('ranch equip',fall,X,Y,1) :-
    equip('ranch equip',Lvl,_,_),
    X is Lvl + 1,
    Y is Lvl*30.
shopequip('ranch equip',winter,X,Y,1) :-
    equip('ranch equip',Lvl,_,_),
    X is Lvl + 1,
    Y is Lvl*30.
shopequip('fishing rod',summer,X,Y,2) :-
    equip('fishing rod',Lvl,_,_),
    X is Lvl + 2,
    Y is (2*Lvl+1)*30.
shopequip('fishing rod',spring,X,Y,2) :-
    equip('fishing rod',Lvl,_,_),
    X is Lvl + 2,
    Y is (2*Lvl+1)*30.
shopequip('fishing rod',fall,X,Y,2) :-
    equip('fishing rod',Lvl,_,_),
    X is Lvl + 1,
    Y is Lvl*30.
shopequip('fishing rod',winter,X,Y,2) :-
    equip('fishing rod',Lvl,_,_),
    X is Lvl + 1,
    Y is Lvl*30.
shopequip('shovel',summer,X,Y,3) :-
    equip('shovel',Lvl,_,_),
    X is Lvl + 1,
    Y is Lvl*15.
shopequip('shovel',spring,X,Y,3) :-
    equip('shovel',Lvl,_,_),
    X is Lvl + 1,
    Y is Lvl*15.
shopequip('shovel',fall,X,Y,3) :-
    equip('shovel',Lvl,_,_),
    X is Lvl + 2,
    Y is (2*Lvl+1)*15.
shopequip('shovel',winter,X,Y,3) :-
    equip('shovel',Lvl,_,_),
    X is Lvl + 2,
    Y is (2*Lvl+1)*15.
shopequip('watering',summer,X,Y,4) :-
    equip('watering',Lvl,_,_),
    X is Lvl + 1,
    Y is Lvl*15.
shopequip('watering',spring,X,Y,4) :-
    equip('watering',Lvl,_,_),
    X is Lvl + 1,
    Y is Lvl*15.
shopequip('watering',fall,X,Y,4) :-
    equip('watering',Lvl,_,_),
    X is Lvl + 2,
    Y is (2*Lvl+1)*15.
shopequip('watering',winter,X,Y,4) :-
    equip('watering',Lvl,_,_),
    X is Lvl + 2,
    Y is (2*Lvl+1)*15.

/*Fact potion shop*/
shoppotion('fishing potion',1,500).
shoppotion('ranching potion',2,500).
shoppotion('farming potion',3,500).
shoppotion('EXP potion',4,500).
shoppotion('teleport potion',5,500).
shoppotion('Gamble potion',6,500).

/*Command Market*/
market :- 
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    write('What do you want to do?'),nl,
    write('- alchemist(meet alchemist if u lucky)'),nl, write('- sell(sell item in your inventory)'),nl, write('- buy(buy item from marketplace)'),nl, 
    write('- upgradeEquipment(upgrade your equipment)'),nl,read(CC),
    (CC == 'alchemist' -> alchemist;
     CC == 'sell' -> sell;
     CC == 'buy' -> buy;
     CC == 'upgradeEquipment' -> upgradeEquipment).

/*Command to meet Alchemist*/
alchemist :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    random(0,5,X),
    ( X < 3 -> write('No Alchemist here, comeback later.\n');
    buyalchemist),!.

/*Buy Item from alchemist*/
buyalchemist :-
    write('Hello, i am alchemist, what do you want to buy?\n'),
    marketpotion(6,1),
    write('Plz Write Number.\n'),
    read(X),
    buypotion(X), !.

/*Function to write Potion in Shop*/
marketpotion(Y,Y) :-
    shoppotion(Name,Y,Price),
    format('~d. ~w (~d golds)\n',[Y,Name,Price]), !.   
    
marketpotion(Y,Iterate) :-
    shoppotion(Name,Iterate,Price),
    format('~d. ~w (~d golds)\n',[Iterate,Name,Price]),
    IterateNow is Iterate+1,
    marketpotion(Y,IterateNow), !.

/*Function to buy potion*/
buypotion(X) :-
    X < 1,!,
    write('You type wrong number.\n'), fail.

buypotion(X) :-
    X > 6,!,
    write('You type wrong number.\n'), fail.

buypotion(X) :-
    player(_,_,_,_,_,_,_,_,_,_,Gold,_),
    shoppotion(_,X,Price),
    Price > Gold,!,
    write('You dont have enough gold, comeback later!\n'), fail.

buypotion(X) :-
    shoppotion(Name,X,Price),
    loseGold(Price),
    format('You have bought ~w.\n',[Name]),
    usepotion(Name), !.

/*Command to Sell Item */
sell :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    totalItems(X),
    X =:= 4,!,
    write('You dont have item to sell, comeback later!\n'), !.

sell :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    currentInventory(Inv),
    write('What do you want to sell?\n'),
    sort(Inv,Inv2), 
    writeInvSell(1,Inv2), 
    write('Plz write in format <\'Name Item\'>\n'),
    read(Y), 
    write('amount : \n'), 
    read(Z),
    sellitem(Y,Z),!.

/* Command to buy item */
buy :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    currentSeason(X),
    write('What do you want to buy?\n'),
    market(X),
    write('Plz Write Number.\n'),
    read(Y),
    write('How many do you want to buy?\n'),
    read(Z),
    buyItem(X,Y,Z), !.

/* Command to buy equipment */
upgradeEquipment :-
    isPlayerTile(A, B),
    isMarketplaceTile(A, B),
    currentSeason(X),
    write('What do you want to upgrade?\n'),
    marketequip(X),
    write('Plz Write Number.\n'),
    read(Y),
    buyequip(X,Y), !.

/* Utility to count how much item/equip in shop per season*/ 
check(X,Y) :-
    findall(1, shopitem(_,X,_), List), length(List, Y).

checkequip(X,Y) :-
    findall(1,shopequip(_,X,_,_,_),List), length(List,Y).

/*Write all item available for shop per season */
market(X) :-
    check(X,Y),
    market(X,Y,1), !.

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

/*Write all equipment available for shop per season */
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

/* Function to buy Item */
buyItem(_,_,Z) :-
    totalItems(Total),
    Total + Z > 100,!,
    write('Inventory full.\n'), fail.

buyItem(X,Y,_) :-
    check(X,Total),
    Total < Y,!,
    write('No Items\n'), fail.

buyItem(X,Y,Z) :-
    shopitem(Name,X,Y),
    priceitems(Name,Price),
    PriceTotal is Price*Z,
    player(_,_,_,_,_,_,_,_,_,_,Gold,_),
    Gold < PriceTotal,!,
    write('You don\'t have enough golds.\n'), fail.

buyItem(X,Y,Z) :-
    shopitem(Name,X,Y),
    items(Type,Name),
    Type == animal,!,
    priceitems(Name,Price),
    PriceTotal is Price*Z,
    loseGold(PriceTotal),
    (   Name == 'ayam' -> addChicken(Z) ;
        Name == 'sapi' -> addCow(Z) ;
        Name == 'kambing' -> addSheep(Z)),
    format('You have bought ~d ~w.\n',[Z,Name]), !.

buyItem(X,Y,Z) :-
    shopitem(Name,X,Y),
    priceitems(Name,Price),
    PriceTotal is Price*Z,
    loseGold(PriceTotal),
    addItem(Name,Z), 
    format('You have bought ~d ~w.\n',[Z,Name]), !.

/*Function to buy equipment */
buyequip(_,_) :-
    totalItems(X),
    X == 100, !,
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
    equip(Name,LvlNow,_,_),
    priceitems(Name,PriceNow),
    loseGold(Price),
    PriceUpgrade is (PriceNow*Lvl)/LvlNow,
    changePrice(Name,PriceUpgrade),
    Expmax is Lvl*50,
    changeStats(Name,Lvl,0,Expmax),
    throwItem(Name,1),
    addItem(Name,1),
    format('You have upgraded ~w.\n',[Name]), !.