:- dynamic(cow/2).
:- dynamic(sheep/2).
:- dynamic(chicken/2).
:- dynamic(currentRanchCow/4).
:- dynamic(currentRanchSheep/4).
:- dynamic(currentRanchChicken/4).

prodtime('ayam', 3).
prodtime('sapi', 4).
prodtime('kambing', 5).

initLivestock :- 
    assertz(cow(0, 35)), 
    assertz(sheep(0, 21)), 
    assertz(chicken(0, 28)), 
    assertz(currentRanchCow('NULL', 0, 0, 0)), 
    assertz(currentRanchSheep('NULL', 0, 0, 0)), 
    assertz(currentRanchChicken('NULL', 0, 0, 0)), !.

ranch :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    write('Here are the available activities you can do in the ranch:'), nl, nl,
    write('- raise    : produce animal products'), nl, 
    write('- collect  : collect finished produce'), nl, 
    write('- lifespan : check lifespan of current livestock(s) '), nl, 
    write('- feed     : feed current livestock(s) to extend lifespan'), nl, nl,
    write('What do you want to do?'), nl,
    repeat,
    read(Choice), nl,
    write('----------------------------------------'), nl,
    (   Choice == 'raise' -> raise, nl ;
        Choice == 'collect' -> collect, nl ;
        Choice == 'feed' -> feed, nl ;
        Choice == 'lifespan' -> lifespan, nl ;
        write('You can\'t do that. Try again'), nl, fail ), !.
    
lifespan :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    cow(CountCow, DeathCow),
    sheep(CountSheep, DeathSheep),
    chicken(CountChicken, DeathChicken),
    write('Here are your livestock\'s current lifespan:'), nl,

    (   CountChicken =:= 0 -> write('You don\'t have any ayam(s)') ;
        format('Ayam (~dx): all will be dead in ~d day(s)', [CountChicken, DeathChicken])   ), nl,
    (   CountSheep =:= 0 -> write('You don\'t have any kambing(s)') ;
        format('Kambing (~dx): all will be dead in ~d day(s)', [CountSheep, DeathSheep])   ), nl,
    (   CountCow =:= 0 -> write('You don\'t have any sapi(s)') ;
        format('Sapi (~dx): all will be dead in ~d day(s)', [CountCow, DeathCow])   ), nl, nl,
    write('Don\'t forget to regularly feed your livestocks to extend their lifespan!'), !. 

checkDeath :- 
    chicken(CountChicken, DeathChicken), cow(CountCow, DeathCow), sheep(CountSheep, DeathSheep), 
    NewDeathChicken is DeathChicken - 1, NewDeathCow is DeathCow - 1, NewDeathSheep is DeathSheep - 1,
    (   CountChicken =:= 0 -> abolishChicken ;
                                (NewDeathChicken =:= 0 ->   nl, write('Your ayam(s) died of starvation. This is what you get for not feeding your chicken(s).'), nl,
                                                            abolishChicken ;
                                                            retractall(chicken(CountChicken, DeathChicken)),
                                                            assertz(chicken(CountChicken, NewDeathChicken)))  ),
    (   CountCow =:= 0 -> abolishCow ;
                            (NewDeathCow =:= 0 ->   nl, write('Your sapi(s) died of starvation. This is what you get for not feeding your cow(s).'), nl,
                                                    abolishCow ;
                                                    retractall(cow(CountCow, DeathCow)),
                                                    assertz(cow(CountCow, NewDeathCow)))    ),

    (   CountSheep =:= 0 -> abolishSheep ;
                            (NewDeathSheep =:= 0 ->     nl, write('Your kambing(s) died of starvation. This is what you get for not feeding your sheep(s).'), nl,
                                                        abolishSheep ;
                                                        retractall(sheep(CountSheep, DeathSheep)),
                                                        assertz(sheep(CountSheep, NewDeathSheep))) ), !.                       

feed :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    totalItemsType(Z, feed),
    write('Your animals have a certain lifespan. Feeding them regularly can help extend their lifespan by up to 4 days.'), nl,
    write('Maximum lifespan for ayam is 28 days, sapi is 35 days, while kambing is 21 days.'), nl, nl,
    (   Z =:= 0 -> write('You currently don\'t have any animal food. Buy it first in the marketplace.') ;
        write('Here is a list of animal food in your inventory:'), nl,
        inventory(feed), nl,
        write('Which animal food would you like to use?'), nl,
        
        repeat,
        write('Type food name inside apostrophe <\'food_name\'>'), nl, nl,
        read(Choice), currentInventory(Inv),
        (   (\+ member(Choice, Inv), \+ items(feed, Choice)) -> write('You don\'t have that. Try again'), nl, fail ;
            nl  ),
        throwItem(Choice, 1),
        (   Choice == 'chicken feed'  ->  chicken(Count, Death), Animal = 'ayam',
                                        (Death < 24 -> NewDeath is Death + 4, Add is 4 ;
                                        NewDeath is 28, Add is 28 - Death ),
                                        retractall(chicken(Count, Death)),
                                        assertz(chicken(Count, NewDeath)) ;

            Choice == 'cow feed'      ->   cow(Count, Death), Animal = 'sapi',
                                        (Death < 31 -> NewDeath is Death + 4, Add is 4 ;
                                        NewDeath is 35, Add is 35 - Death ),
                                        retractall(cow(Count, Death)),
                                        assertz(cow(Count, NewDeath)) ;

            Choice == 'sheep feed'    ->  sheep(Count, Death), Animal = 'kambing',
                                        (Death < 21 -> NewDeath is Death + 4, Add is 4 ;
                                        NewDeath is 21, Add is 21 - Death ),
                                        retractall(sheep(Count, Death)),
                                        assertz(sheep(Count, NewDeath)) ),
        (   Count =:= 0 -> format('You don\'t own any ~w. You ended up wasting your ~w.', [Animal, Choice]) ; 
            format('You added ~d more day(s) to your ~w(s)\' life.', [Add, Animal]), nl,
            format('Don\'t forget to feed them, for they will die in ~d day(s)', [NewDeath]))   ), !.

raise :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    cow(CountCow, _), sheep(CountSheep, _), chicken(CountChicken, _), 
    All is CountChicken + CountCow + CountSheep, All =:= 0, 
    write('You don\'t have any animals. Try buying it first in the marketplace.'), !.

raise :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentRanchCow(Check2, _, _, _), 
    currentRanchSheep(Check3, _, _, _),
    currentRanchChicken(Check1, _, _, _), 
    \+ (Check1 == 'NULL'), \+ (Check2 == 'NULL'), \+ (Check3 == 'NULL'), 
    write('You are already raising all three animals. Try <collect> instead.'), !.


raise :- write('Here are a list of your available livestocks!'), nl,
    chicken(CountChicken, _), cow(CountCow, _), sheep(CountSheep, _),
    format('1. Ayam (~dx)\n2. Sapi (~dx)\n3. Kambing (~dx)\n', [CountChicken, CountCow, CountSheep]),
    repeat,
    write('Which livestock will you raise?'), nl,
    read(X), nl,
    (   X =:= 1 -> (CountChicken =:= 0 ->   write('You don\'t have any ayam(s).'), nl ;
                                            write('----------------------------------------'), nl,
                                            raiseChicken) ;
        X =:= 2 -> (CountCow =:= 0 ->   write('You don\'t have any sapi(s).'), nl ;
                                            write('----------------------------------------'), nl,
                                            raiseCow) ;
        X =:= 3 -> (CountSheep =:= 0 ->   write('You don\'t have any kambing(s).'), nl ;
                                            write('----------------------------------------'), nl,
                                            raiseSheep) ;
        write('That\'s an invalid input. Try either 1, 2, or 3.'), nl, fail ), !.

raiseChicken :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentRanchChicken(Check, _, _, _), 
    player(_, _, _, _, _, _, LevelRanch, _, _, _, _, _), 
    (   Check == 'NULL' ->  write('These are the products you can gain from raising ayam:'), nl,
                            write('1. Egg\n2. Chicken Meat\n\nWhich product will you choose?'), nl,
                            write('(each ayam you own will produce two products)'), nl,
                            prodtime('ayam', Time), read(Choice), chicken(CountChicken, _),
                            (   Choice =:= 1, LevelRanch <5 -> retractall(currentRanchChicken(_, _, _, _)), 
                                                assertz(currentRanchChicken('ayam', 'egg', Time, 0)) ;
                                Choice =:= 1, LevelRanch <10 -> retractall(currentRanchChicken(_, _, _, _)), 
                                                assertz(currentRanchChicken('ayam', 'omega 3 egg', Time, 0)) ;
                                Choice =:= 1, LevelRanch >9 -> retractall(currentRanchChicken(_, _, _, _)), 
                                                assertz(currentRanchChicken('ayam', 'cemani egg', Time, 0)) ;
                                Choice =:= 2 -> nl, format('How many ayam(s) will you butcher? (Limit: ~d)', [CountChicken]), nl,
                                                repeat,
                                                read(DeadChicken),
                                                (   DeadChicken > CountChicken -> write('That\'s more than what you own. Try again.'), nl, fail ;
                                                    retractall(currentRanchChicken(_, _, _, _)), 
                                                    assertz(currentRanchChicken('ayam', 'chicken meat', Time, DeadChicken)))    ),
                            
                            currentRanchChicken(_, Produce, Time, _), ranchxpmoney(Produce, Time)  ;
        write('You already are raising this animal. Try <collect> instead.')    ), !.

raiseCow :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentRanchCow(Check, _, _, _), 
    player(_, _, _, _, _, _, LevelRanch, _, _, _, _, _), 
    (   Check == 'NULL' ->  write('These are the products you can gain from raising sapi:'), nl,
                            write('1. Milk\n2. Cow Meat\n\nWhich product will you choose?'), nl,
                            write('(each sapi you own will produce two products)'), nl,
                            prodtime('sapi', Time), read(Choice), cow(CountCow, _),
                            (   Choice =:= 1,LevelRanch <5 -> retractall(currentRanchCow(_, _, _, _)), 
                                                assertz(currentRanchCow('sapi', 'milk', Time, 0)) ;
                                Choice =:= 1,LevelRanch <10 -> retractall(currentRanchCow(_, _, _, _)), 
                                                assertz(currentRanchCow('sapi', 'protein infused milk', Time, 0)) ;
                                Choice =:= 1,LevelRanch >9 -> retractall(currentRanchCow(_, _, _, _)), 
                                                assertz(currentRanchCow('sapi', 'A5 milk', Time, 0)) ;
                                Choice =:= 2 -> nl, format('How many sapi(s) will you butcher? (Limit: ~d)', [CountCow]), nl,
                                                repeat,
                                                read(DeadCow),
                                                (   DeadCow > CountCow -> write('That\'s more than what you own. Try again.'), nl, fail ;
                                                    retractall(currentRanchCow(_, _, _, _)), 
                                                    assertz(currentRanchCow('sapi', 'cow meat', Time, DeadCow)))   ),
                            
                            currentRanchCow(_, Produce, Time, _), ranchxpmoney(Produce, Time) ;
        write('You already are raising this animal. Try <collect> instead.')    ), !.

raiseSheep :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentRanchSheep(Check, _, _, _), 
    player(_, _, _, _, _, _, LevelRanch, _, _, _, _, _),  
    (   Check == 'NULL' ->  write('These are the products you can gain from raising kambing:'), nl,
                            write('1. Wol\n2. Sheep Meat\n\nWhich product will you choose?'), nl,
                            write('(each kambing you own will produce two products)'), nl,
                            prodtime('kambing', Time), read(Choice), sheep(CountSheep, _),
                            (   Choice =:= 1,LevelRanch < 5 -> retractall(currentRanchSheep(_, _, _, _)), 
                                                assertz(currentRanchSheep('kambing', 'wol', Time, 0)) ;
                                Choice =:= 1,LevelRanch < 10 -> retractall(currentRanchSheep(_, _, _, _)), 
                                                assertz(currentRanchSheep('kambing', 'beluga wol', Time, 0)) ;
                                Choice =:= 1,LevelRanch > 9 -> retractall(currentRanchSheep(_, _, _, _)), 
                                                assertz(currentRanchSheep('kambing', 'super anti villain wol', Time, 0)) ;
                                Choice =:= 2 -> nl, format('How many kambing(s) will you butcher? (Limit: ~d)', [CountSheep]), nl,
                                                repeat,
                                                read(DeadSheep),
                                                (   DeadSheep > CountSheep -> write('That\'s more than what you own. Try again.'), nl, fail ;
                                                    retractall(currentRanchSheep(_, _, _, _)), 
                                                    assertz(currentRanchSheep('kambing', 'sheep meat', Time, DeadSheep)))    ),
                            
                            currentRanchSheep(_, Produce, Time, _), ranchxpmoney(Produce, Time) ;
        write('You already are raising this animal. Try <collect> instead.')    ), !.

ranchxpmoney(Produce, Time) :- 
    equip('ranch equip', EquipLvl, EquipXPNow, EquipXPMax),
    AddEquipXPRanch is (EquipLvl * 10),
    AddEquipXP is (EquipLvl * 13),
    addExp(AddEquipXPRanch, 3),

    CurEquipXP is EquipXPNow + AddEquipXP, changeStats('ranch equip', EquipLvl, CurEquipXP, EquipXPMax),
    nl, write('----------------------------------------'), nl,
    format('[Ranch Equip XP (+~d), XP Ranching (+~d)]', [AddEquipXP, AddEquipXPRanch]), nl, 
    (   CurEquipXP >= EquipXPMax -> nl, levelupTool('ranch equip'), nl, nl ;
        nl, nl ),

    format('Come back in ~d day(s) to get your ~w', [Time, Produce]), nl,
    write('You can do this by typing <collect> in the main menu'), 
    
    random(1, 101, Chance),
    (   Chance > 95 -> nl, nl, ranchAccident, nl ; nl  ), !.

ranchReward(Livestock, Produce, Death, Count) :- 
    player(Job, Level, _, _, _, _, LevelRanch, ExpRanch, _, _, _, _), 
    write('----------------------------------------'), nl,
    write('Finally... It is time.'), nl,  priceitems(Produce, Price),
    (   Death =:= 0 -> format('You gently collected the ~w from the ~w. ', [Produce, Livestock]), Gain is Count ;
        format('With tears in your eyes, you butchered ~d of your ~w(s). ', [Death, Livestock]),
        (   Livestock == 'ayam' -> deleteChicken(Death), Gain is Death ;
            Livestock == 'sapi' -> deleteCow(Death), Gain is Death ;
            Livestock == 'kambing' -> deleteSheep(Death), Gain is Death    )   ), nl, nl,
    format('You gained ~w (~dx)', [Produce, Gain]), nl,
    format('You can sell each ~w for ~d Golds in the marketplace', [Produce, Price]), nl, nl,

    prodtime(Livestock, Time),
    NewExp is ((8 * Level) + 3 + Gain) * Time,
    NewExpRanch is ((10 * LevelRanch) + 2 + Gain) * Time,
    CurExpRanch is NewExpRanch + ExpRanch,
    (   Job == 'Rancher' ->  write('You were paid for working as a rancher'), nl,
                            Salary is (LevelRanch * 5),
                            addGold(Salary), nl ;
        nl  ), 

    write('Current XP Ranching: '), write(CurExpRanch), nl,

    addItem(Produce, Gain),
    addExp(NewExp, 0),
    addExp(NewExpRanch,3), !.

collect :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    cow(CountCow, _), sheep(CountSheep, _), chicken(CountChicken, _), 
    All is CountChicken + CountCow + CountSheep, All =:= 0, 
    write('You don\'t have any animals. Try buying it first in the marketplace.'), !.

collect :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    currentRanchCow(Check2, _, _, _), 
    currentRanchSheep(Check3, _, _, _),
    currentRanchChicken(Check1, _, _, _), 
    (Check1 == 'NULL'), (Check2 == 'NULL'), (Check3 == 'NULL'), 
    write('You don\'t have any on-going products. Try <raise> instead.'), !.

collect :- 
    isPlayerTile(A, B),
    isRanchTile(A, B),
    write('Which livestock would you like to collect?'), nl,
    chicken(CountChicken, _), cow(CountCow, _), sheep(CountSheep, _),
    currentRanchChicken(Check1, Prod1, Time1, _), currentRanchCow(Check2, Prod2, Time2, _), currentRanchSheep(Check3, Prod3, Time3, _),
    format('1. Ayam (~dx)\n2. Sapi (~dx)\n3. Kambing (~dx)\n ', [CountChicken, CountCow, CountSheep]),
    repeat,
    write('Which livestock will you raise?'), nl,
    read(X), nl,
    (   X =:= 1 -> (    CountChicken =:= 0  ->  write('You don\'t have any ayam(s).'), nl ;
                        Check1 == 'NULL'    ->  write('You tried collecting eggs from a nearby chicken...'), nl,
                                                write('...but all you got was chicken poop.'), nl,
                                                write('That\'s what you get for not ranching first.') ;
                        Time1 > 0           ->  format('Come back in ~d day(s) to get your ~w', [Time1, Prod1]) ;
                        collectChicken  ) ;

        X =:= 2 -> (    CountCow =:= 0      ->  write('You don\'t have any sapi(s).'), nl ;
                        Check2 == 'NULL'    ->  write('You tried collecting milk from the cows and ended up getting kicked by the cow'), nl,
                                                write('That\'s what you get for not ranching first.') ;
                        Time2 > 0           ->  format('Come back in ~d day(s) to get your ~w', [Time2, Prod2]) ; 
                        collectCow      ) ;

        X =:= 3 -> (    CountSheep =:= 0    ->  write('You don\'t have any kambing(s).'), nl ;
                        Check3 == 'NULL'    ->  write('You tried to collect wol from the kambings, but then they suddenly stomp on you.'), nl,
                                                write('That\'s what you get for not ranching first.') ;
                        Time3 > 0           ->  format('Come back in ~d day(s) to get your ~w', [Time3, Prod3]) ; 
                        collectSheep)  ;
        write('That\'s an invalid input. Try either 1, 2, or 3.'), nl, fail   ), !.

winterDeath(Livestock) :-
    write('You forgot to give scarfs and hand-warmers to your animal(s).'), nl,
    write('Because of this, your animal(s) were unable to produce.'), nl,
    format('Also, one of your ~w(s) died in the middle of the winter. You lost one ~w.', [Livestock, Livestock]), nl, nl, 
    (   Livestock == 'sapi' -> deleteCow(1) ; 
        Livestock == 'ayam' -> deleteChicken(1) ;
        Livestock == 'kambing' -> deleteSheep(1) ),
    write('You gained nothing and 0 Gold.'), !.

collectChicken :- 
    isPlayerTile(A, B), isRanchTile(A, B),
    currentRanchChicken(Livestock, _, _, _),
    currentSeason(X),
    (   X == winter -> random(0, 10, N) ;
        N is 10 ),
    (   N < 6 -> winterDeath ; 
        currentRanchChicken(Livestock, Produce, _, Death), chicken(Count, _),
        ranchReward(Livestock, Produce, Death, Count)   ), 
    retractall(currentRanchChicken(_, _, _, _)), 
    assertz(currentRanchChicken('NULL', 0, 0, 0)), !.

collectCow :- 
    isPlayerTile(A, B), isRanchTile(A, B),
    currentRanchCow(Livestock, _, _, _),
    currentSeason(X),
    (   X == winter -> random(0, 10, N) ;
        N is 10 ),
    (   N < 6 -> winterDeath(Livestock) ;
        currentRanchCow(Livestock, Produce, _, Death), cow(Count, _),
        ranchReward(Livestock, Produce, Death, Count)   ), 
    retractall(currentRanchCow(_, _, _, _)),
    assertz(currentRanchCow('NULL', 0, 0, 0)), !.

collectSheep :- 
    isPlayerTile(A, B), isRanchTile(A, B),
    currentRanchSheep(Livestock, _, _, _),
    currentSeason(X), 
    (   X == winter -> random(0, 10, N) ;
        N is 10 ),
    (   N < 6 -> winterDeath(Livestock) ;
    currentRanchSheep(Livestock, Produce, _, Death), sheep(Count, _),
    ranchReward(Livestock, Produce, Death, Count)   ),
    retractall(currentRanchSheep(_, _, _, _)),
    assertz(currentRanchSheep('NULL', 0, 0, 0)), !.

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

setTime(LevelRanch, Time, NewTime) :- 
    (   LevelRanch > 10 -> Subtract is 2 ;
        Subtract is 1   ),

    (   Time =:= 0 -> TimeSubtracted is Time ;
        TimeSubtracted is Time - Subtract  ),
    
    (   TimeSubtracted < 0 -> NewTime is 0 ;
        NewTime is TimeSubtracted   ), !.

updateRanchChicken :- currentRanchChicken(Check, Produce, Time, Death), \+ (Check == 'NULL'),
    player(_, _, _, _, _, _, LevelRanch, _, _, _, _, _), setTime(LevelRanch, Time, NewTime),
    retractall(currentRanchChicken(_, _, _, _)),
    assertz(currentRanchChicken(Check, Produce, NewTime, Death)), !.

updateRanchChicken :- currentRanchChicken(Check, _, _, _), Check == 'NULL'.

updateRanchCow :- currentRanchCow(Check, Produce, Time, Death), \+ (Check == 'NULL'),
    player(_, _, _, _, _, _, LevelRanch, _, _, _, _, _), setTime(LevelRanch, Time, NewTime),
    retractall(currentRanchCow(_, _, _, _)),
    assertz(currentRanchCow(Check, Produce, NewTime, Death)), !.

updateRanchCow :- currentRanchCow(Check, _, _, _), Check == 'NULL'.

updateRanchSheep :- currentRanchSheep(Check, Produce, Time, Death), \+ (Check == 'NULL'),
    player(_, _, _, _, _, _, LevelRanch, _, _, _, _, _), setTime(LevelRanch, Time, NewTime),
    retractall(currentRanchSheep(_, _, _, _)),
    assertz(currentRanchSheep(Check, Produce, NewTime, Death)), !.

updateRanchSheep :- currentRanchSheep(Check, _, _, _), Check == 'NULL'.