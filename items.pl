:- dynamic(items/5).

/* SEED */
items(seed,bayamSeed).
items(seed,wortelSeed).
items(seed,kentangSeed).
items(seed,jagungSeed).
items(seed,cabeSeed).
items(seed,bawang_merahSeed).
items(seed,bawang_putihSeed).
items(seed,padiSeed).
items(seed,kangkungSeed).

/* HASIL PANEN */
items(harvest,bayam).
items(harvest,wortel).
items(harvest,kentang).
items(harvest,jagung).
items(harvest,cabe).
items(harvest,bawang_merah).
items(harvest,bawang_putih).
items(harvest,padi).
items(harvest,kangkung).

/* ITEM RANCHING */
items(feed,chickenfeed).
items(feed,cowfeed).
items(feed,sheepfeed).

/* HASIL RANCHING */
items(ranching,egg).
items(ranching,milk).
items(ranching,wol).
items(ranching,cowmeat).
items(ranching,sheepmeat).
items(ranching,chickenmeat).

/* ITEM FISHING */
items(bait,bait).

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

/* EQUIPMENT ada tambahan level sama exp equipment, dan max exp per level*/
assertz(items(equip,fishingrod,1,0,50)).
assertz(items(equip,watering,1,0,50)).
assertz(items(equip,shovel,1,0,50)).
assertz(items(equip,ranchequip,1,0,50)).

/* PRICE ITEM */
priceitems(bayamSeed,5).
priceitems(wortelSeed,10).
priceitems(kentangSeed,20).
priceitems(jagungSeed,15).
priceitems(cabeSeed,12).
priceitems(bawang_merahSeed,17).
priceitems(bawang_putihSeed,12).
priceitems(padiSeed,7).
priceitems(kangkungSeed,22).
priceitems(bayam,20).
priceitems(wortel,35).
priceitems(kentang,75).
priceitems(jagung,63).
priceitems(cabe,50).
priceitems(bawang_merah,87).
priceitems(bawang_putih,63).
priceitems(padi,25).
priceitems(kangkung,87).
priceitems(chickenfeed,5).
priceitems(cowfeed,10).
priceitems(sheepfeed,8).
priceitems(egg,35).
priceitems(milk,40).
priceitems(wol,60)
priceitems(cowmeat,250).
priceitems(sheepmeat,170).
priceitems(chickenmeat,90).
priceitems(bait,1).
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
priceitems(fishingrod,50).
priceitems(watering,25).
priceitems(shovel,25).
priceitems(ranchequip,50).

/* Level Up TOOL */
levelupTool(Name) :- 
    items(equip,Name,lvl,expnow,expmax), !,
    expnow > expmax,
    lvlup is lvl + 1,
    newexp is expnow mod expmax,
    newmax is expmax + 50,
    retractall(items(equip,Name,lvl,expnow,expmax)),
    assertz(items(equip,Name,lvlup,newexp,newmax)).

/* USE ITEM */
useItem(Name) :-
    item(type,Name), !, _dosomething