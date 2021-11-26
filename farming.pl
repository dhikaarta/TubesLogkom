:- dynamic(farm/3).

farming :- \+ farm(_, _, _),
    write('Which seed would you like to plant?'), nl, 
    seeds, farm(Seed, Time, _),
    
    format('You chose ~w. Weird choice, but alright.', [Seed]), nl, nl,
    write('======================================================'), nl,
    write('First things first, we have to dig this patch of tile!'), nl, nl,
    write('Type <\'DIG DIG DIG\'> to dig a hole'), nl,
    write('Don\'t forget the apostrophe (\') !'), nl,
    repeat,
    nl, read(Dig), nl,
    (   Dig == 'DIG DIG DIG' -> format('Nice. Now let\'s fill this hole with your ~w seed', [Seed]), nl ; 
        write('If you keep digging like that you\'re gonna end up digging your own grave.'), nl, nl, 
        write('You have to type <\'DIG DIG DIG\'> to dig a hole. Try again.'), nl, fail ), nl, nl,
    
    repeat,
    write('Type <\'PLZ BLESS MY SEED\'> to plant the seed and gain the harvest god\'s blessing.'), nl,
    write('Once again, DO NOT forget the apostrophe (\'). Plz.'), nl,
    nl, read(Plant), nl,
    format('You shouted "~w" at the top of your lungs', [Plant]), nl,
    (   Plant == 'PLZ BLESS MY SEED' -> write('Bet that was loud enough to wake the god of harvest.'), nl ;
        write('...which was not the correct mantra. Please try again.'), nl, nl, fail), nl, nl,
    
    format('Finally, you\'ve succeeded in planting a(n) ~w seed!', [Seed]), nl, nl,
    format('Come back in ~d seconds to get your ~w', [Time, Seed]), nl,
    write('You can do this by typing <harvest> in the main menu'), !.

farming :- farm(_, _, _),
    write('You should harvest your crop before farming again.'), !.

harvest :- \+ farm(_, _, _), 
    write('... You do realize you haven\'t planted anything, right?'), !.

harvest :- farm(Seed, Time, _), (Time > 0),
    write('Come back in ~d seconds to get your ~w', [Time, Seed]), !.

% winter = bad crop
harvest :- currentSeason(X), X == winter, random(0, 10, N),
    (   N < 6 -> write('You come back to find your crops have turned into blocks of ice.'), nl,
    write('What did you expect, farming in the middle of the winter?'), nl, nl,
    write('You gained nothing and 0 Gold.'),
    retractall(farm(_, _, _, _)) ;
    farmxpmoney   ), !.

harvest :- farmxpmoney, !.

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