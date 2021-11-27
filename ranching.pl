:- dynamic(currentRanch/4).

:- dynamic(cow/2).
:- dynamic(sheep/2).
:- dynamic(chicken/2).

initLivestock :- assertz(chicken(2, 28)), assertz(cow(2, 35)), assertz(sheep(0, 21)), !.

/*checkDeath :- chicken(_, DeathChicken), cow(_, DeathCow), sheep(_, DeathSheep),
    ()*/

feed :- \+ (totalItemsType(Z, feed), Z =:= 0),
    write('You don\'t have any animal food. Buy it first in the marketplace.'), !.

/*feed :- inventory(feed), nl,
    write('Which animal food would you like to pick?'), nl,
    repeat,
    write('Type food name inside apostrophes <\'food_name\'>'), nl, nl,
    read(Feed), currentInventory(Inv),
    (   \+ member(Feed, Inv) -> write('That\'s not a valid food name. Try again'), nl, fail ;
        format('You chose ~w. Weird choice, but alright.', [Feed]), nl, nl  ),
    throwItem(Feed, 1), 
    
    (   Feed == 'chicken feed' -> ;
        Feed == 'cow feed' -> ;
        Feed == 'sheep feed' -> ), !.*/

/*ranch :- currentRanch(_, _, _, _),
    write('Shouldn\'t you be typing <\'collect\'> instead of <\'ranch\'> ?'), !.*/

ranch :- 
    cow(CountCow, DeathCow),
    sheep(CountSheep, DeathSheep),
    chicken(CountChicken, DeathChicken), 
    All is CountChicken + CountCow + CountSheep,
    \+ (All =:= 0),

    write('Here are a list of your available livestocks!'), nl, 
    livestock, currentRanch(Livestock, Produce, _, _),

    format('You chose ~w. Great, now let\'s care for it.', [Livestock]), nl, nl, pat,
    format('Come back tomorrow to get your ~w', [Produce]), nl,
    write('You can do this by typing <collect> in the main menu'), !.

ranch :- cow(CountCow, DeathCow), sheep(CountSheep, DeathSheep), chicken(CountChicken, DeathChicken), 
    All is CountChicken + CountCow + CountSheep, All =:= 0, 
    write('You don\'t have any animals. Try buying it first in the marketplace.'), !.

/*ranch :- */

collect :- \+ currentRanch(_, _, _, _), 
    write('You tried collecting eggs from a nearby chicken...'), nl,
    write('...but all you got was chicken poop.'), nl, nl,
    write('That\'s what you get for not ranching first.'), !.

collect :- currentRanch(_, Produce, Time, _), (Time =:= 0),
    write('Come back in tomorrow to get your ~w', [Produce]), !.

collect :- currentSeason(X), X == winter, random(0, 10, N), currentRanch(Livestock, _, _, _),
    (   N < 6 -> write('You forgot to give scarfs and hand-warmers to the animal.'), nl,
    write('It died peacefully in the midst of the cold winter.'), nl, nl,
    (   Livestock == 'ayam' -> deleteChicken(1) ;
        Livestock == 'sapi' -> deleteCow(1) ;
        Livestock == 'kambing' -> deleteSheep(1)    ),
    write('You gained nothing and 0 Gold.'),
    retractall(currentRanch(_, _, _, _)) ;
    ranchxpmoney   ), !.

collect :- ranchxpmoney, !.

ranchxpmoney :- currentRanch(Livestock, Produce, Time, Death),
    player(Job, Level, _, _, _, _, LevelRanch, ExpRanch, _, _, Money, _), 
    write('Finally... It is time.'), nl,  priceitems(Produce, Price),
    (    Death =:= 0 -> format('You gently collected the ~w from the ~w.', [Produce, Livestock]) ;
        Death =:= 1 ->  format('You butchered the ~w swiftly. You cried.', [Livestock]),
                    (   Livestock == 'ayam' -> deleteChicken(1) ;
                        Livestock == 'sapi' -> deleteCow(1) ;
                        Livestock == 'kambing' -> deleteSheep(1)    )   ),

    write('You gained '), write(Produce), nl, 
    format('You can sell this ~w for ~d Golds in the marketplace', [Produce, Price]), nl,
    
    NewExpRanch is (13 * (LevelRanch)),
    NewExp is (3 * Level),
    CurExpRanch is NewExpRanch + ExpRanch,
    (   Job == 'Rancher' ->  write('You were paid for working as a rancher'), nl,
                            Salary is (LevelRanch * 5),
                            addGold(Salary), nl ;
        nl  ), 

    write('Current XP Ranching: '), write(CurExpRanch), nl,

    addItem(Produce, 1),
    addExp(NewExp, 0),
    addExp(NewExpRanch,2),
    retractall(currentRanch(_, _, _, _)), !.

loop(1) :- write('*PAT* '), nl, !.

loop(X) :- write('*PAT* '), Y is X - 1, loop(Y).

pat :- currentRanch(Livestock, Produce, Time, Price),
    write('You can take care of your animal by patting it like this'), nl, nl,
    random(1, 11, N), loop(N), nl, 
    random(1, 16, G),

    write('Now, how many times would you like to pat the animal?'), nl, read(Pat), nl,
    write('You pat the animal '), write(Pat), write(' time(s).'), nl, nl,
    (   Pat =:= N -> addGold(G), write(' That\'s what you get for treating animals with love'), nl ;
        write('The animal seems unbothered by your action. It almost looks uncomfortable.')   ), nl, !.

% mockup inventory
livestock :- chicken(CountChicken, DeathChicken), cow(CountCow, DeathCow), sheep(CountSheep, DeathSheep),
    format('1. Ayam (~dx)\n2. Sapi (~dx)\n3. Kambing (~dx)\n', [CountChicken, CountCow, CountSheep]),
    repeat,
    write('Which livestock will you raise?'), nl,
    read(X), nl,
    (   X =:= 1 -> (CountChicken =:= 0 ->   write('You don\'t have any ayam(s).'), nl, nl, fail ;
                                            nl, processChicken) ;
        X =:= 2 -> (CountCow =:= 0 ->   write('You don\'t have any sapi(s).'), nl, nl, fail ;
                                            nl, processCow) ;
        X =:= 3 -> (CountSheep =:= 0 ->   write('You don\'t have any kambing(s).'), nl, nl, fail ;
                                            nl, processSheep) ), !.

processChicken :- write('These are the products you can gain from raising ayam:'), nl, nl,
    write('1. Egg\n2. Chicken Meat\n\nWhich product will you choose?'), nl,
    read(Choice),
    (   Choice =:= 1 -> assertz(currentRanch('ayam', 'egg', 0, 0)) ;
        Choice =:= 2 -> assertz(currentRanch('ayam', 'chicken meat', 1, 1))
    ), !.

processCow :- write('These are the products you can gain from raising sapi:'), nl, nl,
    write('1. Milk\n2. Cow Meat\n\nWhich product will you choose?'), nl,
    read(Choice),
    (   Choice =:= 1 -> assertz(currentRanch('sapi', 'milk', 0, 0)) ;
        Choice =:= 2 -> assertz(currentRanch('sapi', 'cow meat', 0, 1))
    ), !.

processSheep :- write('These are the products you can gain from raising kambing:'), nl, nl,
    write('1. Wol\n2. Sheep Meat\n\nWhich product will you choose?'), nl,
    read(Choice),
    (   Choice =:= 1 -> assertz(currentRanch('kambing', 'wol', 0, 0)) ;
        Choice =:= 2 -> assertz(currentRanch('kambing', 'sheep meat', 0, 1))
    ), !.

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

abolishChicken(Num) :- chicken(Count, ExpiryDate),
    retractall(chicken(Count, ExpiryDate)),
    assertz(chicken(CurCount, 28)), !.

abolishCow(Num) :- cow(Count, ExpiryDate),
    retractall(cow(Count, ExpiryDate)),
    assertz(cow(CurCount, 35)), !.

abolishSheep(Num) :- sheep(Count, ExpiryDate),
    retractall(sheep(Count, ExpiryDate)),
    assertz(sheep(0, 21)), !.