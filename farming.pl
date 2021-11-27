:- dynamic(farm/3).

dig :- isPlayerTile(X, Y), \+ (isDiggedTile(X, Y)), \+ (isCropTile(X, Y, _, _)),
    write('Let\'s dig this patch of tile right here!'), nl, nl,
    write('Type <\'PLZ DIG\'>  to dig a hole in this tile'), nl,
    write('(P.S.: Don\'t forget to type the apostrophe (\')'), nl,
    repeat, nl, 
    read(Dig), nl,
    % plz ini ascii art jgn diubah keliatannya aja jelek tp di prolog ini jadi bagus ko :D
    (   Dig == 'PLZ DIG' -> 

        write('  _______   __    _______   _______  __  .__   __.   _______                         '), nl,                  
        write(' |       \\ |  |  /  _____| /  _____||  | |  \\ |  |  /  _____|                      '), nl,
        write(' |   __   ||  | |  |  __  |  |  __  |  | |   \\|  | |  |  __                         '), nl,
        write(' |  |  |  ||  | |  | |_ | |  | |_ | |  | |  . `  | |  | |_ |                         '), nl,
        write(' |  \'--\'  ||  | |  |__| | |  |__| | |  | |  |\\   | |  |__| |  __     __     __    '), nl,
        write(' |_______/ |__|  \\______|  \\______| |__| |__| \\__|  \\______| (__)   (__)   (__)  '), nl ;

        write('You\'re gonna end up digging your own grave if you keep digging like that.'), nl,
        write('Try typing <\'PLZ DIG\'> again. Do NOT forget the apostrophe.'), nl, fail), nl, nl,
    digtile,
    write('Phew, that was a lot of work. You lost 10 stamina while digging the hole.'), depleteEnergy(10), nl, nl,
    write('Now that this tile is digged, you can plant your seed(s) here by typing <plant> in the main menu.'), !.

dig :- isPlayerTile(X, Y), isCropTile(X, Y, _, _),
    write('This is a cropped tile! Are you trying to ruin it?'), !.

dig :- isPlayerTile(X, Y), (isDiggedTile(X, Y)),
    write('This tile is already digged. Try <plant> instead.'), !.

plant :- \+ (totalItemsType(Z, seed), Z =:= 0), isPlayerTile(X, Y), (isDiggedTile(X, Y)), 
    write('Here are a list of seeds in your inventory: '), nl, 
    nl, seeds, farm(Seed, Time, _),
 
    repeat,
    write('Type <\'PLZ BLESS\'> to gain the harvest god\'s blessing.'), nl,
    write('Once again, DO NOT forget the apostrophe (\'). Plz.'), nl,
    nl, read(Plant), nl,
    (   Plant == 'PLZ BLESS' -> 

        write('        __               __   __                       '), nl,
        write('._____.|  |.___._._____.|  |_|__|._____._____.         '), nl,
        write('|  _  ||  ||  _  |     ||   _|  ||     |  _  |__ __ __ '), nl,
        write('|   __||__||___._|__|__||____|__||__|__|___  |__|__|__|'), nl,
        write('|__|                                   |_____|         '), nl ;

        write('Are you trying to offend the god of harvest? Please try again.'), nl, nl, fail), nl,
    format('You shouted "~w" at the top of your lungs', [Plant]), nl,
    write('Hopefully the god of harvest will hear your thunderous prayers'), nl, nl,
    
    write('While planting, you lost 5 stamina.'), depleteEnergy(5), nl, nl, sow(Seed, 0), 
    nl, nl, format('Come back in ~d seconds to get your ~w', [Time, Seed]), nl,
    write('You can do this by typing <harvest> in the main menu'), !.

plant :- (totalItemsType(X, seed), X =:= 0),
    write('You don\'t have any seed in your inventory. Buy seeds in marketplace first.'), !.

plant :- isPlayerTile(X, Y), isCropTile(X, Y, _, _),
    write('You have already cropped this tile. Type <harvest> to harvest your crop(s)'), !.

plant :- isPlayerTile(X, Y), \+ (isDiggedTile(X, Y)), \+ (isCropTile(X, Y, _, _)),
    write('You have to dig the tiles first before planting your seed. Try <dig>.'), !.

harvest :- isPlayerTile(X, Y), \+ isCropTile(X, Y, _, _), \+ (isDiggedTile(X, Y)),
    write('You haven\'t even digged this tile. Try <dig> followed by <plant>'), !.

harvest :- isPlayerTile(X, Y), \+ (isCropTile(X, Y, _, _)), isDiggedTile(X, Y),
    write('You haven\'t planted anything in this digged tile. Try <plant>.'), !.

harvest :- farm(Seed, Time, _), (Time > 0),
    write('Come back in ~d seconds to get your ~w', [Time, Seed]), !.

% winter = bad crop
harvest :- currentSeason(X), X == winter, random(0, 10, N), reap, nl,
    (   N < 6 -> write('You come back to find your crops have turned into blocks of ice.'), nl,
    write('What did you expect, farming in the middle of the winter?'), nl, nl,
    write('You gained nothing and 0 Gold.'),
    retractall(farm(_, _, _, _)) ;
    farmxpmoney   ), !.

harvest :- farmxpmoney, reap, nl, !.

% nanti nambah XP + XP Farming di harvest yg ini + tambahin di inv
farmxpmoney :- playerTile(X, Y), isCropTile(X, Y, Seed, _), priceitems(Seed, Price),
    player(Job, Level, LevelFarm, ExpFarm, _, _, _, _, Exp, _, Money, _),
    write('The time has come for you to reap what you sow... Literally.'), nl, nl,
    write('You got '), write(Seed), nl,
    format('You can sell this ~w for ~d Golds in the marketplace', [Seed, Price]), nl,

    NewExpFarm is (13 * (LevelFarm)),
    NewExp is (3 * Level),
    CurExp is NewExp + Exp,
    CurExpFarm is NewExpFarm + ExpFarm,
    (   Job == 'Farmer' ->  write('You were paid for working as a farmer'), nl,
                            Salary is (LevelFarm * 5),
                            addGold(Salary), nl ;
        nl ),
    write('Current XP Farming: '), write(CurExpFarm), nl,
    addItem(Seed, 1),
    addExp(NewExp, 0),
    addExp(NewExpFarm,2),
    retractall(farm(_, _, _)), !.

% mockup inventory
seeds :- 
    inventory(seed), nl,
    write('Which seed would you like to pick?'), nl,
    repeat,
    write('Type seed name inside apostrophes <\'seed_name\'>'), nl, nl,
    read(Seed), currentInventory(Inv),
    (   \+ member(Seed, Inv) -> write('That\'s not a valid seed name. Try again'), nl, fail ;
        format('You chose ~w. Weird choice, but alright.', [Seed]), nl, nl  ),
    throwItem(Seed, 1), priceitems(Seed, Price),
    assertz(farm(Seed, 0, Price)), !.
