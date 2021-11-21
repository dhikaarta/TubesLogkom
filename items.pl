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
items(bait,bait1).
items(bait,bait2).
items(bait,bait3).
items(bait,bait4).
items(bait,bait5).

/* HASIL FISHING */
items(fish,salmon).
items(fish,tuna).
items(fish,sardine).
items(fish,cod).
items(fish,catfish).
items(fish,mackerel).
items(fish,swordfish).
items(fish,herring).
items(fish,trout).
items(fish,eel).
items(fish,octopus).
items(fish,squid).
items(fish,shark).
items(fish,trash).

/* EQUIPMENT ada tambahan level sama exp equipment, dan max exp per level*/
asserta(items(equip,fishingrod,1,0,50)).
asserta(items(equip,watering,1,0,50)).
asserta(items(equip,shovel,1,0,50)).
asserta(items(equip,ranchequip,1,0,50)).

/* PRICE ITEM */
priceitems(bayamSeed,20).
priceitems(wortelSeed,40).
priceitems(kentangSeed,80).
priceitems(jagungSeed,60).
priceitems(cabeSeed,50).
priceitems(bawang_merahSeed,70).
priceitems(bawang_putihSeed,50).
priceitems(padiSeed,30).
priceitems(kangkungSeed,90).
priceitems(bayam,80).
priceitems(wortel,140).
priceitems(kentang,300).
priceitems(jagung,250).
priceitems(cabe,200).
priceitems(bawang_merah,350).
priceitems(bawang_putih,250).
priceitems(padi,100).
priceitems(kangkung,350).
priceitems(chickenfeed,50).
priceitems(cowfeed,100).
priceitems(sheepfeed,75).
priceitems(egg,65).
priceitems(milk,80).
priceitems(wol,110)
priceitems(cowmeat,350).
priceitems(sheepmeat,270).
priceitems(chickenmeat,150).
priceitems(bait1,10).
priceitems(bait2,20).
priceitems(bait3,30).
priceitems(bait4,40).
priceitems(bait5,50).
priceitems(salmon,300).
priceitems(tuna,250).
priceitems(sardine,120).
priceitems(cod,220).
priceitems(catfish,200).
priceitems(mackerel,175).
priceitems(swordfish,260).
priceitems(herring,240).
priceitems(trout,140).
priceitems(eel,180).
priceitems(octopus,230).
priceitems(squid,150).
priceitems(shark,0).
priceitems(trash,0).
priceitems(fishingrod,500).
priceitems(watering,250).
priceitems(shovel,250).
priceitems(ranchequip,500).

/* Level Up TOOL */
levelupTool(Name) :- 
    items(equip,Name,lvl,expnow,expmax), !,
    expnow > expmax,
    lvlup is lvl + 1,
    newexp is expnow mod expmax,
    newmax is expmax + 50,
    retractall(items(equip,Name,lvl,expnow,expmax)),
    asserta(items(equip,Name,lvlup,newexp,newmax)).

/* USE ITEM */
useItem(Name) :-
    item(type,Name), !, _dosomething