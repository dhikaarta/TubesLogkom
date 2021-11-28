:- dynamic(isQuest/1).
:- dynamic(questNeeded/6).

quest :-
    isPlayerTile(A, B),
    isQuestTile(A, B),
    \+ isQuest(_),
    write('Welcome! Here are your available quests!'), nl, listQuest, nl, 
    repeat,
    write('Which quest would you like to do today?'), nl,
    read(Choice), nl,
    (   Choice =:= 1 -> quest1, assertz(isQuest(1)), nl ;
        Choice =:= 2 -> quest2, assertz(isQuest(2)), nl ;
        Choice =:= 3 -> quest3, assertz(isQuest(3)), nl ;
        write('You think that\'s funny? Try again.', nl, fail)  ), !.

quest :-
    isPlayerTile(A, B),
    isQuestTile(A, B),
    isQuest(X), write(X),
    questNeeded(CountFarm, Farm, CountFish, Fish, CountRanch, Ranch),
    currentInventory(Inv),
    totalperItem(Farm, Inv, QuantityFarm), QuantityFarm >= CountFarm, 
    totalperItem(Fish, Inv, QuantityFish), QuantityFish >= CountFish,
    totalperItem(Ranch, Inv, QuantityRanch), QuantityRanch >= CountRanch, 

    (   isQuest(1) -> endingQuest1 ;
        isQuest(2) -> endingQuest2 ;
        isQuest(3) -> endingQuest3 ),

    player(_, Level, _, _, _, _, _, _, _, _, _, _),
    priceitems(Farm, PriceFarm),
    priceitems(Fish, PriceFish),
    priceitems(Ranch, PriceRanch),
    NewGold is (PriceFarm * (CountFarm + 1) + (PriceFish * (CountFish + 1)) + (PriceRanch * (CountRanch + 1)) + 20),
    NewExp is ((5 * Level) * (CountFarm + CountFish + CountRanch)),
    addGold(NewGold),
    addExp(NewExp, 0),

    throwItem(Farm, CountFarm), 
    throwItem(Fish, CountFish), 
    throwItem(Ranch, CountRanch),
    retractall(questNeeded(_, _, _, _, _, _)), 
    retractall(isQuest(_)), !.

quest :- 
    isPlayerTile(A, B),
    isQuestTile(A, B),
    write('You have an on-going quest which lacks:'), nl,
    questNeeded(CountFarm, Farm, CountFish, Fish, CountRanch, Ranch),
    currentInventory(Inv),
    totalperItem(Farm, Inv, QuantityFarm), 
    totalperItem(Fish, Inv, QuantityFish), 
    totalperItem(Ranch, Inv, QuantityRanch),
    (QuantityFarm < CountFarm -> format('~w: ~w/~w', [Farm, QuantityFarm, CountFarm]), nl),
    (QuantityFish < CountFish -> format('~w: ~w/~w', [Fish, QuantityFish, CountFish]), nl),
    (QuantityRanch < CountRanch -> format('~w: ~w/~w', [Ranch, QuantityRanch, CountRanch]), nl), nl,
    write('Finish your quest first before adding new ones!'), !.

listQuest :- write('1. Menaklukkan Sapi Gila'), nl, write('2. Menunggang Lele Raksasa'), nl, write('3. Menanam Bunga Sangat Imut'), nl, !.

quest1 :- 
    random(1, 4, CountFarm), 
    random(1, 4, CountFish), 
    random(1, 4, CountRanch),
    assertz(questNeeded(CountFarm, 'bayam', CountFish, 'Cupang Menggemaskan', CountRanch, 'wol')), 
    write('A crazy cow has been wreaking havoc in the village.'), nl,
    write('It is said that the cow had been affected by a deadly virus'), nl,
    write('that makes it crave human flesh.'), nl, nl,
    write('The only way to stop this crazy cow from going all berserk-zombie mode is to create'), nl,
    write('a certain potion which requires:'), nl,
    format('~w Bayam(s)\n~w Cupang Menggemaskan(s)\n~w Wol(s)\n', [CountFarm, CountFish, CountRanch]), nl, nl,
    write('Find those items and type <quest> to turn in the necessary items.'), nl, !.

quest2 :- 
    random(1, 4, CountFarm), 
    random(1, 4, CountFish), 
    random(1, 4, CountRanch),
    assertz(questNeeded(CountFarm, 'wortel', CountFish, 'Sarden Badan Licin', CountRanch, 'egg')), 
    write('Legend has it that deep within the village lake lies a giant lele fish.'), nl,
    write('Brave souls have tried searching for this beast to no avail.'), nl,
    write('However, there has been a recent discovery of an ancient scroll which contains'), nl,
    write('an instruction on how to find and tame the wild beast.'), nl, nl,
    write('It is said that the lele fish would only appear by offering:'), nl,
    format('~w Wortel(s)\n~w Sarden Badan Licin(s)\n~w Egg(s)\n', [CountFarm, CountFish, CountRanch]), nl,
    write('Find those items and type <quest> to turn in the necessary items.'), nl, !.

quest3 :- 
    random(1, 4, CountFarm), 
    random(1, 4, CountFish), 
    random(1, 4, CountRanch),
    assertz(questNeeded(CountFarm, 'kentang', CountFish, 'Teri Biasa Aja', CountRanch, 'milk')), 
    write('Children of the village are slowly dying.'), nl,
    write('Doctors have said that this tragedy is happening due to'), nl,
    write('the UWU Virus (Unstoppable Wacko Untreatable Virus).'), nl,
    write('The only way to stop the children from dying is to give them'), nl,
    write('a special elixir made out of the primordial Anti-UWU Flower.'), nl, nl,
    write('These are the ingredients needed to plant the flower and create the elixir: '), nl,
    format('~w Kentang(s)\n~w Teri Biasa Aja(s)\n~w Milk\n', [CountFarm, CountFish, CountRanch]), nl, nl,
    write('Find those items and type <quest> to turn in the necessary items.'), nl, !.

endingQuest1 :-
    write('You brew the potions quickly and shoved it into the cow\'s mouth.'), nl,
    write('It immediately started chewing grass again. Phew, nice work.'), nl, nl, !.

endingQuest2 :-
    write('You threw the offerings onto the sea while shouting "YAYOYOYAYE", just like what the scroll said.'), nl,
    write('Not long after, a giant lele fish appeared before you. You ride the fish to the middle of the ocean.'), nl, nl, !.

endingQuest3 :-
    write('The Anti-UWU Flower you planted was more than enough to create an elixir for the entire village.'), nl,
    write('At last, peace has been restored. Begone, UWU Virus.'), nl, nl, !.