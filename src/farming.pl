croptime('bayam Seed', 'bayam', 1).
croptime('wortel Seed', 'wortel', 1).
croptime('padi Seed', 'padi', 1).
croptime('cabe Seed', 'cabe', 2).
croptime('bawang putih Seed', 'bawang putih', 2).
croptime('jagung Seed', 'jagung', 2).
croptime('bawang merah Seed', 'bawang merah', 3).
croptime('kangkung Seed', 'kangkung', 3).
croptime('kentang Seed', 'kentang', 3).

dig :- isPlayerTile(X, Y), isNormalTile(X, Y), \+ (isDiggedTile(X, Y)), \+ (isCropTile(X, Y, _, _)),
    
    equip('shovel', EquipLvl, EquipXPNow, EquipXPMax),
    AddEquipXPFarm is (EquipLvl * 5), 
    AddEquipXP is (EquipLvl * 5),
    addExp(AddEquipXPFarm, 1), 

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

    CurEquipXP is EquipXPNow + AddEquipXP, changeStats('shovel', EquipLvl, CurEquipXP, EquipXPMax),
    format('[Shovel XP (+~d), XP Farming (+~d)]', [AddEquipXP, AddEquipXPFarm]), nl,
    (   CurEquipXP >= EquipXPMax -> nl, levelupTool('shovel'), nl, nl ;
        nl, nl ),
    write('Phew, that was a lot of work. You lost 10 stamina while digging the hole. '), depleteEnergy(10), nl,
    write('Now that this tile is digged, you can plant your seed(s) here by typing <plant> in the main menu'), nl,

    
    random(1, 101, Chance),
    (   Chance > 95 -> nl, nl, farmAccident, nl ;
        nl  ), !.

dig :- isPlayerTile(X, Y), isCropTile(X, Y, _, _),
    write('This is a cropped tile! Are you trying to ruin it?'), !.

dig :- isPlayerTile(X, Y), (isDiggedTile(X, Y)),
    write('This tile is already digged. Try <plant> instead.'), !.

dig :- isPlayerTile(X, Y), \+ isNormalTile(X, Y),
    write('You can\'t dig in special tiles.'), !.

plant :- \+ (totalItemsType(Z, seed), Z =:= 0), isPlayerTile(X, Y), (isDiggedTile(X, Y)), 
    
    equip('watering', EquipLvl, EquipXPNow, EquipXPMax),
    AddEquipXPFarm is (EquipLvl * 8),
    AddEquipXP is (EquipLvl * 15),
    addExp(AddEquipXPFarm, 1), 

    write('Here are a list of seeds in your inventory: '), nl, 
    write('================='), nl, inventory(seed), write('================='), nl,
    write('Which seed would you like to pick?'), nl,

    repeat,
    write('Type seed name inside apostrophe <\'seed_name\'>'), nl, nl,
    read(Seed), currentInventory(Inv),
    (   \+ member(Seed, Inv) -> write('You don\'t have that. Try again'), nl, fail ;
        format('You chose ~w. Weird choice, but alright.', [Seed]), nl, nl  ),
    throwItem(Seed, 1),
 
    repeat,
    write('Let\'s water the plant. Type <\'PLZ BLESS\'> to gain the harvest god\'s blessing. '),
    write('Once again, DO NOT forget the apostrophe (\'). Plz.'), nl,
    nl, read(Plant), nl, nl,
    (   Plant == 'PLZ BLESS' -> 
        write('=============================================================='), nl,
        write('        __               __   __                       '), nl,
        write('._____.|  |.___._._____.|  |_|__|._____._____.         '), nl,
        write('|  _  ||  ||  _  |     ||   _|  ||     |  _  |__ __ __ '), nl,
        write('|   __||__||___._|__|__||____|__||__|__|___  |__|__|__|'), nl,
        write('|__|                                   |_____|         '), nl ;

        write('Are you trying to offend the god of harvest? Please try again.'), nl, nl, fail), nl,
    format('You watered the plant while shouting "~w" at the top of your lungs', [Plant]), nl,
    write('Hopefully the god of harvest will hear your thunderous prayers'), nl,
    write('=============================================================='), nl, nl,
    
    croptime(Seed, Produce, Time), sow(Seed, Time), nl,

    CurEquipXP is EquipXPNow + AddEquipXP, changeStats('watering', EquipLvl, CurEquipXP, EquipXPMax),
    format('[Watering XP (+~d), XP Farming (+~d)]', [AddEquipXP, AddEquipXPFarm]), 
    (   CurEquipXP >= EquipXPMax -> nl, levelupTool('watering'), nl, nl ;
        nl, nl ),

    write('While planting, you lost 5 stamina. '), depleteEnergy(5), nl, nl, 
    format('Come back in ~d day(s) to get your ~w', [Time, Produce]), nl,
    write('You can do this by typing <harvest> in the main menu'), !.

plant :- (totalItemsType(X, seed), X =:= 0),
    write('You don\'t have any seed in your inventory. Buy seeds in marketplace first.'), !.

plant :- playerTile(X, Y), isCropTile(X, Y, _, _),
    write('You have already cropped this tile. Type <harvest> to harvest your crop(s)'), !.

plant :- isPlayerTile(X, Y), \+ (isDiggedTile(X, Y)), \+ (isCropTile(X, Y, _, _)),
    write('You have to dig the tiles first before planting your seed. Try <dig>.'), !.

harvest :- isPlayerTile(X, Y), \+ isCropTile(X, Y, _, _), \+ (isDiggedTile(X, Y)),
    write('You haven\'t even digged this tile. Try <dig> followed by <plant>'), !.

harvest :- isPlayerTile(X, Y), \+ (isCropTile(X, Y, _, _)), isDiggedTile(X, Y),
    write('You haven\'t planted anything in this digged tile. Try <plant>.'), !.

harvest :- isPlayerTile(X, Y), isCropTile(X, Y, Seed, Time), (Time > 0),
    format('Come back in ~d day(s) to get your ~w', [Time, Seed]), !.

harvest :- currentSeason(X), X == winter, random(0, 10, N), reap, nl,
    (   N < 6 -> write('You come back to find your crops have turned into blocks of ice.'), nl,
    write('What did you expect, farming in the middle of the winter?'), nl, nl,
    write('You gained nothing and 0 Gold.') ;
    farmxpmoney   ), !.

harvest :- farmxpmoney, reap, nl, !.

% nanti nambah XP + XP Farming di harvest yg ini + tambahin di inv
farmxpmoney :- isPlayerTile(X, Y), isCropTile(X, Y, Seed, _), priceitems(Seed, Price),
    croptime(_, Seed, Time),
    player(Job, Level, LevelFarm, ExpFarm, _, _, _, _, _, _, _, _),
    write('The time has come for you to reap what you sow... Literally.'), nl, nl,
    write('You got '), write(Seed), nl,
    format('You can sell this ~w for ~d Golds in the marketplace', [Seed, Price]), nl,

    NewExpFarm is ((15 * LevelFarm) + 10) * Time,
    NewExp is ((15 * Level) + 20) * Time,
    CurExpFarm is NewExpFarm + ExpFarm,
    (   Job == 'Farmer' ->  write('You were paid for working as a farmer'), nl,
                            Salary is (LevelFarm * 5),
                            addGold(Salary), nl ;
        nl ),
    write('Current XP Farming: '), write(CurExpFarm), nl,
    addItem(Seed, 1),
    addExp(NewExp, 0),
    addExp(NewExpFarm, 1), !.

