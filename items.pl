:- dynamic(items/2).

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

/* ITEM TERNAK */
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

:- dynamic(equip/4).
equip('fishing rod',1,0,50).
equip('watering',1,0,50).
equip('shovel',1,0,50).
equip('ranch equip',1,0,50).

usepotion('fishing potion') :-
    addExp(200,2).

usepotion('ranching potion') :-
    addExp(200,3).

usepotion('farming potion') :-
    addExp(200,1).

usepotion('EXP potion') :-
    addExp(200,0).

usepotion('teleport potion') :-
    teleport(5,5).

usepotion('Gamble potion') :-
    random(0,2,X),
    ( X =:= 0, loseGold(500);
    addGold(1000)), !.


/* PRICE ITEM */
:- dynamic(priceitems/2).
priceitems('bayam Seed',5).
priceitems('wortel Seed',10).
priceitems('kentang Seed',20).
priceitems('jagung Seed',15).
priceitems('cabe Seed',12).
priceitems('bawang merah Seed',17).
priceitems('bawang putih Seed',12).
priceitems('padi Seed',7).
priceitems('kangkung Seed',22).
priceitems('bayam',20).
priceitems('wortel',35).
priceitems('kentang',75).
priceitems('jagung',63).
priceitems('cabe',50).
priceitems('bawang merah',87).
priceitems('bawang putih',63).
priceitems('padi',25).
priceitems('kangkung',87).
priceitems('chicken feed',5).
priceitems('cow feed',10).
priceitems('sheep feed',8).
priceitems('egg',35).
priceitems('milk',40).
priceitems('wol',60).
priceitems('cow meat',250).
priceitems('sheep meat',170).
priceitems('chicken meat',90).
priceitems('ayam',80).
priceitems('sapi',320).
priceitems('kambing',240).
priceitems('bait',1).
priceitems('Lele Raksasa',250).
priceitems('Paus Uwu',170).
priceitems('Teri Mikroskopis',2).
priceitems('Ayah Nemo',75).
priceitems('Sarden Badan Licin',60).
priceitems('Cupang Menggemaskan',30).
priceitems('Kakap Corak Batik khas Nusantara',150).
priceitems('Geri Si Gurame',105).
priceitems('Teri Mini',5).
priceitems('Salmon Kulit Crispy Daging Kenyal',45).
priceitems('Cacing Besar Alaska',90).
priceitems('Teri Biasa Aja',15).
priceitems('Trash',0).
priceitems('fishing rod',50).
priceitems('watering',25).
priceitems('shovel',25).
priceitems('ranch equip',50).

/* Level Up TOOL */
levelupTool(Name) :- 
    equip(Name,Lvl,Expnow,Expmax), !,
    Expnow > Expmax, !,
    Lvlup is Lvl + 1,
    Newexp is Expnow mod Expmax,
    Newmax is Expmax + 50,
    priceitems(Name,Price),
    PriceNow is Price+50,
    changePrice(Name,PriceNow),
    retract(equip(Name,Lvl,Expnow,Expmax)),
    assertz(equip(Name,Lvlup,Newexp,Newmax)),
    write('LL      EEEEEEE VV     VV EEEEEEE LL         UU   UU PPPPPP     !!! !!!'),nl,
    write('LL      EE      VV     VV EE      LL         UU   UU PP   PP    !!! !!!'),nl,
    write('LL      EEEEE    VV   VV  EEEEE   LL         UU   UU PPPPPP     !!! !!!'),nl,
    write('LL      EE        VV VV   EE      LL         UU   UU PP                '),nl,
    write('LLLLLLL EEEEEEE    VVV    EEEEEEE LLLLLLL     UUUUU  PP         !!! !!!'),nl,nl,
    write('You have leveled up ! '), write(Lvl), write('->'), write(Lvlup), nl, levelupTool(Name), !.

changePrice(Item,Price) :-
    items(_,Item), !,
    retractall(priceitems(Item,_)),
    assertz(priceitems(Item,Price)).

changeStats(Item,Lvl,Expmax) :-
    retractall(equip(Item,_,_,_)),
    assertz(equip(Item,Lvl,0,Expmax)).

checkLevel(Item,X) :-
    equip(Item,X,_,_).