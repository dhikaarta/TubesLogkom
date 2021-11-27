:- dynamic(farm/3).

digtile :- \+ (isDiggedTile(_, _)),
    write('Let\'s dig this patch of tile right here!'), nl, nl,
    write('Type <\'DIG DIG DIG\'>  to dig a hole in this tile'), nl,
    write('(P.S.: Don\'t forget to type the apostrophe (\')'), nl,
    repeat, nl, 
    read(Dig), nl,
    % plz ini ascii art jgn diubah keliatannya aja jelek tp di prolog ini jadi bagus ko :D
    (   Dig == 'DIG DIG DIG' -> 
    
        write('  _______   __    _______   _______  __  .__   __.   _______                   '), nl,                  
        write(' |       \\ |  |  /  _____| /  _____||  | |  \\ |  |  /  _____|                  '), nl,
        write(' |   __   ||  | |  |  __  |  |  __  |  | |   \\|  | |  |  __                    '), nl,
        write(' |  |  |  ||  | |  | |_ | |  | |_ | |  | |  . `  | |  | |_ |                   '), nl,
        write(' |  \'--\'  ||  | |  |__| | |  |__| | |  | |  |\\   | |  |__| |  __     __     __ '), nl,
        write(' |_______/ |__|  \\______|  \\______| |__| |__| \\__|  \\______| (__)   (__)   (__)'), nl ;

        write('You\'re gonna end up digging your own grave if you keep digging like that.'), nl,
        write('Try typing <\'DIG DIG DIG\'> again. Do NOT forget the apostrophe.'), nl, fail), nl, nl,
    dig,
    write('Now that this tile is digged, you can plant your seed(s) here by typing <plant> in the main menu.'), !.

digtile :- (isDiggedTile(_, _)),
    write('This tile is already digged. Try <plant> instead.'), !.

plant :- (isDiggedTile(_, _)),
    write('Which seed would you like to plant?'), nl, 
    seeds, farm(Seed, Time, _),
    
    format('You chose ~w. Weird choice, but alright.', [Seed]), nl, nl,
    repeat,
    write('Type <\'PLZ BLESS MY SEED\'> to gain the harvest god\'s blessing.'), nl,
    write('Once again, DO NOT forget the apostrophe (\'). Plz.'), nl,
    nl, read(Plant), nl,
    (   Plant == 'PLZ BLESS MY SEED' -> 

        write('        __               __   __                       '), nl,
        write('._____.|  |.___._._____.|  |_|__|._____._____.         '), nl,
        write('|  _  ||  ||  _  |     ||   _|  ||     |  _  |__ __ __ '), nl,
        write('|   __||__||___._|__|__||____|__||__|__|___  |__|__|__|'), nl,
        write('|__|                                   |_____|         '), nl ;

        write('Are you trying to offend the god of harvest? Please try again.'), nl, nl, fail), nl,
    format('You shouted "~w" at the top of your lungs', [Plant]), nl,
    write('Hopefully the god of harvest will hear your thunderous prayers'), nl, nl,

    sow(Seed), nl, nl, format('Come back in ~d seconds to get your ~w', [Time, Seed]), nl,
    write('You can do this by typing <harvest> in the main menu'), !.

plant :- \+ (isDiggedTile(_, _)),
    write('You have to dig the tiles first before planting your seed. Try <digtile>.'), !.

harvest :- \+ (isDiggedTile(_, _)),
    write('You haven\'t even digged this tile. Try <digtile> followed by <plant>'), !.

harvest :- \+ (isCropTile(_, _, _)), \+ (farm(_, _, _)),
    write('... You do realize you haven\'t planted anything, right?'), !.

harvest :- \+ (isCropTile(_, _, _)),
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

harvest :- reap, nl, farmxpmoney, !.

% nanti nambah XP + XP Farming di harvest yg ini + tambahin di inv
farmxpmoney :- farm(Seed, Time, Price),
    player(Job, Level, LevelFarm, ExpFarm, C, D, E, F, Exp, G, Money, H),
    write('The time has come for you to reap what you sow... Literally.'), nl, 
    write('You gained '), write(Seed), write(' and '), write(Price), write(' Golds.'), nl,

    CurExpFarm is (13 * LevelFarm) + ExpFarm,
    CurExp is (3 * Level) + Exp,
    (   Job == 'Farmer' -> NewMoney is Price + (LevelFarm * 3) ;
        NewMoney is Price ),  
    CurMoney is Money + NewMoney,

    write('Current XP Farming: '), write(CurExpFarm), nl,
    write('Current Money: '), write(CurMoney), write(' (+'), write(NewMoney), write(')'), nl,
    retractall(player(Job, Level, LevelFarm, ExpFarm, C, D, E, F, Exp, G, Money, H)),
    assertz(player(Job, Level, LevelFarm, CurExpFarm, C, D, E, F, CurExp, G, CurMoney, H)),
    retractall(farm(Seed, Time, Price)), !.

% mockup inventory
seeds :- 
    /* testing aja, nanti ceknya dari inventory */
    write('1. AUTO-JADI'), nl, write('2. wortel'), nl, write('3. bayam'), nl,
    read(X),
    (X =:= 1 -> assertz(farm('AUTO-JADI', 0, 20)) ;
    X =:= 2 -> assertz(farm('wortel', 15, 40)) ;
    X =:= 3 -> assertz(farm('bayam', 20, 60))), !.