:- dynamic(items/2).
:- dynamic(equip/4).
:- dynamic(priceitems/2).

/* SEED */
items(seed,'bayam Seed').
items(seed,'wortel Seed').
items(seed,'kentang Seed').
items(seed,'jagung Seed').
items(seed,'cabe Seed').
items(seed,'bawang merah Seed').
items(seed,'bawang putih Seed').
items(seed,'padi Seed').
items(seed,'kangkung Seed').

/* HASIL PANEN */
items(harvest,'bayam').
items(harvest,'wortel').
items(harvest,'kentang').
items(harvest,'jagung').
items(harvest,'cabe').
items(harvest,'bawang merah').
items(harvest,'bawang putih').
items(harvest,'padi').
items(harvest,'kangkung').

/* ITEM RANCHING */
items(feed,'chicken feed').
items(feed,'cow feed').
items(feed,'sheep feed').

/* HEWAN TERNAK */
items(animal,'ayam').
items(animal,'sapi').
items(animal,'kambing').

/* HASIL RANCHING */
items(ranching,'egg').
items(ranching,'milk').
items(ranching,'wol').
items(ranching,'cow meat').
items(ranching,'sheep meat').
items(ranching,'chicken meat').

/* ITEM FISHING */
items(bait,'bait').

/* HASIL FISHING */
items(fish,'Lele Raksasa').
items(fish,'Paus Uwu').
items(fish,'Teri Mikroskopis').
items(fish,'Ayah Nemo').
items(fish,'Sarden Badan Licin').
items(fish,'Cupang Menggemaskan').
items(fish,'Kakap Corak Batik khas Nusantara').
items(fish,'Geri Si Gurame').
items(fish,'Teri Mini').
items(fish,'Salmon Kulit Crispy Daging Kenyal').
items(fish,'Cacing Besar Alaska').
items(fish,'Teri Biasa Aja').
items(fish,'Trash').

/* ITEM POTION */
items(potion,'fishing potion').
items(potion,'ranching potion').
items(potion,'farming potion').
items(potion,'EXP potion').
items(potion,'teleport potion').
items(potion,'Gamble potion').

/* EQUIPMENT ada tambahan level sama exp equipment, dan max exp per level*/
items(equip,'fishing rod').
items(equip,'watering').
items(equip,'shovel').
items(equip,'ranch equip').
equip('fishing rod',1,0,50).
equip('watering',1,0,50).
equip('shovel',1,0,50).
equip('ranch equip',1,0,50).

/* Function to use potion */
usepotion('fishing potion') :-
    addExp(300,2).

usepotion('ranching potion') :-
    addExp(300,3).

usepotion('farming potion') :-
    addExp(300,1).

usepotion('EXP potion') :-
    addExp(300,0).

usepotion('teleport potion') :-
    write('where do you want to teleport?\n'),
    write('X coordinate(1-16)\n'),
    read(X),
    write('Y coordinate(1-19)\n'),
    read(Y),
    teleport(X,Y),!.

usepotion('Gamble potion') :-
    random(0,2,X),
    write('Choose head or tail? (1 for head, 0 for tail)\n'),
    read(Y),
    ( X \= Y, unconsiousGold(1000);
    addGold(2000)), !.


/* PRICE ITEM */
priceitems('bayam Seed',10).
priceitems('wortel Seed',20).
priceitems('kentang Seed',40).
priceitems('jagung Seed',30).
priceitems('cabe Seed',25).
priceitems('bawang merah Seed',35).
priceitems('bawang putih Seed',25).
priceitems('padi Seed',15).
priceitems('kangkung Seed',45).
priceitems('bayam',50).
priceitems('wortel',70).
priceitems('kentang',150).
priceitems('jagung',125).
priceitems('cabe',100).
priceitems('bawang merah',175).
priceitems('bawang putih',125).
priceitems('padi',50).
priceitems('kangkung',175).
priceitems('chicken feed',2).
priceitems('cow feed',10).
priceitems('sheep feed',5).
priceitems('egg',25).
priceitems('milk',75).
priceitems('wol',50).
priceitems('cow meat',250).
priceitems('sheep meat',200).
priceitems('chicken meat',150).
priceitems('ayam',50).
priceitems('sapi',150).
priceitems('kambing',100).
priceitems('bait',2).
priceitems('Lele Raksasa',300).
priceitems('Paus Uwu',200).
priceitems('Teri Mikroskopis',5).
priceitems('Ayah Nemo',90).
priceitems('Sarden Badan Licin',75).
priceitems('Cupang Menggemaskan',50).
priceitems('Kakap Corak Batik khas Nusantara',200).
priceitems('Geri Si Gurame',150).
priceitems('Teri Mini',10).
priceitems('Salmon Kulit Crispy Daging Kenyal',60).
priceitems('Cacing Besar Alaska',135).
priceitems('Teri Biasa Aja',15).
priceitems('Trash',0).
priceitems('fishing rod',50).
priceitems('watering',25).
priceitems('shovel',25).
priceitems('ranch equip',50).

/* Level Up TOOL */
levelupTool(Name) :- 
    equip(Name,Lvl,Expnow,Expmax),
    Expnow >= Expmax,
    Lvlup is Lvl + 1,
    Newexp is Expnow - Expmax,
    Newmax is Expmax + 50,
    priceitems(Name,Price),
    PriceNow is (Price*Lvlup)/Lvl,
    changePrice(Name,PriceNow),
    changeStats(Name,Lvlup,Newexp,Newmax),
    write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
    write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
    write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
    write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
    write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
    format('Your ~w have leveled up ! ',[Name]), write(Lvl), write('->'), write(Lvlup), nl, levelupTool(Name), !.

levelupTool(_) :- !.
/* Function to change Price */
changePrice(Item,Price) :-
    items(_,Item), !,
    retractall(priceitems(Item,_)),
    assertz(priceitems(Item,Price)).

/*Function to change Stats Equipment*/
changeStats(Item,Lvl,ExpNow,Expmax) :-
    retractall(equip(Item,_,_,_)),
    assertz(equip(Item,Lvl,ExpNow,Expmax)).

/*Function to check Level Equipment*/
checkLevel(Item,X) :-
    equip(Item,X,_,_).