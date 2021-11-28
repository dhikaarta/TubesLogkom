:- dynamic(cow/2).
:- dynamic(sheep/2).
:- dynamic(chicken/2).
:- dynamic(currentRanch/4).

prodtime('ayam', 3).
prodtime('sapi', 4).
prodtime('kambing', 5).

initLivestock :- assertz(chicken(0, 28)), assertz(cow(0, 35)), assertz(sheep(0, 21)), assertz(currentRanch('NULL', 0, 0, 0)), !.

checkDeath :- 
    chicken(CountChicken, DeathChicken), cow(CountCow, DeathCow), sheep(CountSheep, DeathSheep), 
    NewDeathChicken is DeathChicken - 1, NewDeathCow is DeathCow - 1, NewDeathSheep is DeathSheep - 1,
    (   CountChicken =:= 0 -> abolishChicken ;
                                (NewDeathChicken =:= 0 ->   nl, write('Your chicken(s) died of starvation. This is what you get for not feeding your chicken(s).'), nl,
                                                            abolishChicken ;
                                                            retractall(chicken(CountChicken, DeathChicken)),
                                                            assertz(chicken(CountChicken, NewDeathChicken)))  ),
    (   CountCow =:= 0 -> abolishCow ;
                            (NewDeathCow =:= 0 ->   nl, write('Your cow(s) died of starvation. This is what you get for not feeding your cow(s).'), nl,
                                                    abolishCow ;
                                                    retractall(cow(CountCow, DeathCow)),
                                                    assertz(cow(CountCow, NewDeathCow)))    ),

    (   CountSheep =:= 0 -> abolishSheep ;
                            (NewDeathSheep =:= 0 ->     nl, write('Your sheep(s) died of starvation. This is what you get for not feeding your sheep(s).'), nl,
                                                        abolishSheep ;
                                                        retractall(sheep(CountSheep, DeathSheep)),
                                                        assertz(sheep(CountSheep, NewDeathSheep))) ), !.                       

feed :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    (totalItemsType(Z, feed), Z =:= 0),
    write('You don\'t have any animal food. Buy it first in the marketplace.'), !.

feed :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    inventory(feed), nl,
    write('Which animal food would you like to pick?'), nl,
    repeat,
    write('Type food name inside apostrophes <\'food_name\'>'), nl, nl,
    read(Choice), currentInventory(Inv),
    (   (\+ member(Choice, Inv), \+ items(feed, Choice)) -> write('You don\'t have that. Try again'), nl, fail ;
        nl  ),
    throwItem(Choice, 1), 
    (   Choice == 'chicken feed'  ->  chicken(Count, Death), Animal = 'ayam',
                                    (Death < 24 -> NewDeath is Death + 4 ;
                                    NewDeath is 28 ),
                                    retractall(chicken(Count, Death)),
                                    assertz(chicken(Count, NewDeath)) ;

        Choice == 'cow feed'      ->   cow(Count, Death), Animal = 'sapi',
                                    (Death < 31 -> NewDeath is Death + 4 ;
                                    NewDeath is 35 ),
                                    retractall(cow(Count, Death)),
                                    assertz(cow(Count, NewDeath)) ;

        Choice == 'sheep feed'    ->  sheep(Count, Death), Animal = 'kambing',
                                    (Death < 27 -> NewDeath is Death + 4 ;
                                    NewDeath is 27 ),
                                    retractall(sheep(Count, Death)),
                                    assertz(sheep(Count, NewDeath)) ),
    (   Count =:= 0 -> format('You don\'t own any ~w. You ended up wasting your ~w.', [Animal, Choice]) ; 
        format('You added 4 more days to your ~w(s)\' life.', [Animal]), nl,
        format('Don\'t forget to feed them, for they will die in ~d day(s)', [NewDeath])), !.

ranch :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentRanch(Check, _, _, _), \+ (Check == 'NULL'),
    write('Shouldn\'t you be typing <\'collect\'> instead of <\'ranch\'> ?'), !.

ranch :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentRanch(Check, _, _, _), Check == 'NULL',
    cow(CountCow, _),
    sheep(CountSheep, _),
    chicken(CountChicken, _), 
    All is CountChicken + CountCow + CountSheep,
    \+ (All =:= 0),

    equip('ranch equip', EquipLvl, EquipXPNow, EquipXPMax),
    AddEquipXP is (EquipLvl * 5),
    AddEquipGoldReward is (EquipLvl * 5),

    write('Here are a list of your available livestocks!'), nl, 
    livestock, currentRanch(Livestock, Produce, Time, _), nl,

    format('Great, now let\'s care for it.', [Livestock]), nl, pat, nl,

    format('Ranch Equip XP +~D', [AddEquipXP]), nl, addGold(AddEquipGoldReward), CurEquipXP is EquipXPNow + AddEquipXP,
    changeStats('ranch equip', EquipLvl, CurEquipXP, EquipXPMax),
    (   CurEquipXP >= EquipXPMax -> nl, levelupTool('ranch equip'), nl, nl ;
        nl, nl ),

    format('Come back in ~d day(s) to get your ~w', [Time, Produce]), nl,
    write('You can do this by typing <collect> in the main menu'), 
    
    random(1, 101, Chance),
    (   Chance > 95 -> nl, nl, ranchAccident, nl ;
        nl  ), !.

ranch :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    cow(CountCow, _), sheep(CountSheep, _), chicken(CountChicken, _), 
    All is CountChicken + CountCow + CountSheep, All =:= 0, 
    write('You don\'t have any animals. Try buying it first in the marketplace.'), !.

/*ranch :- */

collect :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentRanch(Check, _, _, _), Check == 'NULL', 
    write('You tried collecting eggs from a nearby chicken...'), nl,
    write('...but all you got was chicken poop.'), nl, nl,
    write('That\'s what you get for not ranching first.'), !.

collect :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentRanch(_, Produce, Time, _), (Time > 0),
    format('Come back in ~d day(s) to get your ~w', [Time, Produce]), !.

collect :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentSeason(X), X == winter, random(0, 10, N), currentRanch(Livestock, _, _, _),
    (   N < 6 -> write('You forgot to give scarfs and hand-warmers to your animal(s).'), nl,
    write('Because of this, your animal(s) were unable to produce.'), nl,
    write('Also, one of your ~w(s) died in the middle of the winter. You lost one ~w', [Livestock, Livestock]), nl, nl,
    (   Livestock == 'ayam' -> deleteChicken(1) ;
        Livestock == 'sapi' -> deleteCow(1) ;
        Livestock == 'kambing' -> deleteSheep(1)    ),
    write('You gained nothing and 0 Gold.'),
    retractall(currentRanch(_, _, _, _)),
    assertz(currentRanch('NULL', 0, 0, 0)) ;
    ranchxpmoney   ), !.

collect :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    ranchxpmoney, !.

ranchxpmoney :- 
    currentRanch(Livestock, Produce, _, Death),
    player(Job, Level, _, _, _, _, LevelRanch, ExpRanch, _, _, _, _), 
    (   Livestock == 'ayam' -> chicken(Count, _) ;
        Livestock == 'sapi' -> cow(Count, _) ;
        Livestock == 'kambing' -> sheep(Count, _)    ),

    write('Finally... It is time.'), nl,  priceitems(Produce, Price),
    (   Death =:= 0 -> format('You gently collected the ~w from the ~w. ', [Produce, Livestock]), Gain is Count ;
        format('With tears in your eyes, you butchered ~d of your ~w(s). ', [Death, Livestock]),
        (   Livestock == 'ayam' -> deleteChicken(Death), Gain is Death ;
            Livestock == 'sapi' -> deleteCow(Death), Gain is Death ;
            Livestock == 'kambing' -> deleteSheep(Death), Gain is Death    )   ),

    format('You gained ~w (~dx)', [Produce, Gain]), nl, nl,
    format('You can sell each ~w for ~d Golds in the marketplace', [Produce, Price]), nl,
    
    NewExpRanch is (20 * (LevelRanch)),
    NewExp is (25 * Level),
    CurExpRanch is NewExpRanch + ExpRanch,
    (   Job == 'Rancher' ->  write('You were paid for working as a rancher'), nl,
                            Salary is (LevelRanch * 5),
                            addGold(Salary), nl ;
        nl  ), 

    write('Current XP Ranching: '), write(CurExpRanch), nl,

    addItem(Produce, Gain),
    addExp(NewExp, 0),
    addExp(NewExpRanch,3),
    retractall(currentRanch(_, _, _, _)), 
    assertz(currentRanch('NULL', 0, 0, 0)), !.

loop(1) :- write('*PAT* '), nl, !.

loop(X) :- write('*PAT* '), Y is X - 1, loop(Y).

pat :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    random(1, 11, N), random(1, 16, G), nl,
    write('========================================================'), nl,
    write('You can take care of your animal by patting it like this'), 
    nl, nl, loop(N), nl, nl,

    write('How many times would you like to pat the animal?'), nl, read(Pat), nl,
    write('You pat the animal '), write(Pat), write(' time(s).'), nl, nl,
    (   Pat =:= N -> write('The animal seems pleased. Somehow, it gave you some gold as a reward. '), addGold(G) ;
        write('The animal seems unbothered by your action. It almost looks uncomfortable.')   ), nl,
    write('========================================================'), nl, !.

% mockup inventory
livestock :- chicken(CountChicken, _), cow(CountCow, _), sheep(CountSheep, _),
    format('1. Ayam (~dx)\n2. Sapi (~dx)\n3. Kambing (~dx)\n', [CountChicken, CountCow, CountSheep]),
    repeat,
    write('Which livestock will you raise?'), nl,
    read(X), nl,
    (   X =:= 1 -> (CountChicken =:= 0 ->   write('You don\'t have any ayam(s).'), nl, fail ;
                                            nl, processChicken) ;
        X =:= 2 -> (CountCow =:= 0 ->   write('You don\'t have any sapi(s).'), nl, fail ;
                                            nl, processCow) ;
        X =:= 3 -> (CountSheep =:= 0 ->   write('You don\'t have any kambing(s).'), nl, fail ;
                                            nl, processSheep) ), !.

processChicken :- write('These are the products you can gain from raising ayam:'), nl,
    write('1. Egg\n2. Chicken Meat\n\nWhich product will you choose?'), nl,
    write('(each ayam you own will produce one product)'), nl,
    prodtime('ayam', Time), read(Choice), chicken(CountChicken, _),
    (   Choice =:= 1 -> retractall(currentRanch(_, _, _, _)), 
                        assertz(currentRanch('ayam', 'egg', Time, 0)) ;
        Choice =:= 2 -> nl, format('How many ayam(s) will you butcher? (Limit: ~d)', [CountChicken]), nl,
                        repeat,
                        read(DeadChicken),
                        (   DeadChicken > CountChicken -> write('That\'s more than what you own. Try again.'), nl, fail ;
                            retractall(currentRanch(_, _, _, _)), 
                            assertz(currentRanch('ayam', 'chicken meat', Time, DeadChicken)))    ), !.

processCow :- write('These are the products you can gain from raising sapi:'), nl,
    write('1. Milk\n2. Cow Meat\n\nWhich product will you choose?'), nl,
    write('(each sapi you own will produce one product)'), nl,
    prodtime('sapi', Time), read(Choice), cow(CountCow, _),
    (   Choice =:= 1 -> retractall(currentRanch(_, _, _, _)), 
                        assertz(currentRanch('sapi', 'milk', Time, 0)) ;
        Choice =:= 2 -> nl, format('How many sapi(s) will you butcher? (Limit: ~d)', [CountCow]), nl,
                        repeat,
                        read(DeadCow),
                        (   DeadCow > CountCow -> write('That\'s more than what you own. Try again.'), nl, fail ;
                            retractall(currentRanch(_, _, _, _)), 
                            assertz(currentRanch('sapi', 'cow meat', Time, DeadCow)))   ), !.

processSheep :- write('These are the products you can gain from raising kambing:'), nl,
    write('1. Wol\n2. Sheep Meat\n\nWhich product will you choose?'), nl,
    write('(each kambing you own will produce one product)'), nl,
    prodtime('kambing', Time), read(Choice), sheep(CountSheep, _),
    (   Choice =:= 1 -> retractall(currentRanch(_, _, _, _)), 
                        assertz(currentRanch('kambing', 'wol', Time, 0)) ;
        Choice =:= 2 -> nl, format('How many kambing(s) will you butcher? (Limit: ~d)', [CountSheep]), nl,
                        repeat,
                        read(DeadSheep),
                        (   DeadSheep > CountSheep -> write('That\'s more than what you own. Try again.'), nl, fail ;
                            retractall(currentRanch(_, _, _, _)), 
                            assertz(currentRanch('kambing', 'sheep meat', Time, DeadSheep)))    ), !.

addChicken(Num) :- chicken(Count, ExpiryDate),
    CurExpiryDate is 28,
    CurCount is Count + Num,
    retractall(chicken(Count, ExpiryDate)),
    assertz(chicken(CurCount, CurExpiryDate)), !.

addCow(Num) :- cow(Count, ExpiryDate),
    CurExpiryDate is 35,
    CurCount is Count + Num,
    retractall(cow(Count, ExpiryDate)),
    assertz(cow(CurCount, CurExpiryDate)), !.

addSheep(Num) :- sheep(Count, ExpiryDate),
    CurExpiryDate is 21,
    CurCount is Count + Num,
    retractall(sheep(Count, ExpiryDate)),
    assertz(sheep(CurCount, CurExpiryDate)), !.

deleteChicken(Num) :- chicken(Count, ExpiryDate),
    CurCount is Count - Num,
    retractall(chicken(Count, ExpiryDate)),
    assertz(chicken(CurCount, ExpiryDate)), !.

deleteCow(Num) :- cow(Count, ExpiryDate),
    CurCount is Count - Num,
    retractall(cow(Count, ExpiryDate)),
    assertz(cow(CurCount, ExpiryDate)), !.

deleteSheep(Num) :- sheep(Count, ExpiryDate),
    CurCount is Count - Num,
    retractall(sheep(Count, ExpiryDate)),
    assertz(sheep(CurCount, ExpiryDate)), !.

abolishChicken :- chicken(Count, ExpiryDate),
    retractall(chicken(Count, ExpiryDate)),
    assertz(chicken(0, 28)), !.

abolishCow :- cow(Count, ExpiryDate),
    retractall(cow(Count, ExpiryDate)),
    assertz(cow(0, 35)), !.

abolishSheep :- sheep(Count, ExpiryDate),
    retractall(sheep(Count, ExpiryDate)),
    assertz(sheep(0, 21)), !.

updateRanch :- currentRanch(Check, Produce, Time, Death), \+ (Check == 'NULL'),
    (   Time =:= 0 -> NewTime is Time ;
        NewTime is Time - 1 ),
    retractall(currentRanch(_, _, _, _)),
    assertz(currentRanch(Check, Produce, NewTime, Death)), !.

updateRanch :- currentRanch(Check, _, _, _), Check == 'NULL'.