% kalo mo nyoba, compile fishing.pl trs <start.> biar musim sm char nya keassert

:- dynamic(farm/3).

farming :- \+ farm(_, _, _),
    write('Which seed would you like to plant?'), nl, seeds, farm(Seed, Time, _),
    write('You chose '), write(Seed), write('. Weird choice, but alright.'), nl, nl,

    write('First things first, we have to dig this patch of tile!'), nl, 
    write('Type <\'DIG DIG DIG\'> to dig a hole.'), nl,
    repeat,
    nl, read(Dig), nl,
    (   Dig == 'DIG DIG DIG' -> write('Nice. Now let\'s fill this hole with your '), write(Seed), write(' seed.'), nl ;
        write('If you keep digging like that you\'re gonna end up digging your own grave.'), nl, 
        write('You have to type <\'DIG DIG DIG\'> to dig a hole. Try again.'), nl, fail), 
    
    repeat,
    write('Type <\'PLZ BLESS MY SEED\'> to plant the seed and gain the harvest god\'s blessing.'), nl,
    nl, read(Plant), nl,
    write('You shouted '), write('"'), write(Plant), write('"'), write(' at the top of your lungs'), nl,
    (   Plant == 'PLZ BLESS MY SEED' -> write('The god of harvest will most certainly hear your prayers.'), nl ;
        write('...which was not the correct mantra. Please try again.'), nl, nl, fail), nl,
    
    write('You have successfully planted the '), write(Seed), write(' seed.'), nl,
    write('Come back in '), write(Time), write(' seconds to get your '), write(Seed), write(' by typing <harvest> in the main menu'), !.

farming :- write('You should harvest your crop before farming again.'), !.

harvest :- \+ farm(_, _, _), write('... You do realize you haven\'t planted anything, right?'), !.

harvest :- farm(Seed, Time, _), (Time > 0),
    write('Come back in '), write(Time), write(' seconds to get your '), write(Seed), !.

% winter = bad crop
harvest :- currentSeason(X), X == winter, random(0, 10, N),
    (   N < 6 -> write('You come back to find your crops have turned into blocks of ice.'), nl,
    write('What did you expect, farming in the middle of the winter?'), nl, nl,
    write('You gained nothing and 0 Gold.'),
    retractall(farm(_, _, _, _)) ;
    farmxpmoney   ), !.

harvest :- farmxpmoney, !.

% nanti nambah XP + XP Farming di harvest yg ini + tambahin di inv
farmxpmoney :- farm(Seed, Time, Price), character(A, B, Exp, Money),
    write('The time has come for you to reap what you sow... Literally.'), nl, 
    write('You gained '), write(Seed), write(' and '), write(Price), write(' Golds.'), nl,
    CurMoney is Money + Price, CurExp is Exp + 4, retract(character(A, B, Exp, Money)), assertz(character(A, B, CurExp, CurMoney)), 
    retractall(farm(Seed, Time, Price)), !.

% mockup inventory
seeds :- 
    /* testing aja, nanti ceknya dari inventory */
    write('1. AUTO-JADI'), nl, write('2. wortel'), nl, write('3. bayam'), nl,
    read(X),
    (X =:= 1 -> assertz(farm('AUTO-JADI', 0, 20)) ;
    X =:= 2 -> assertz(farm('wortel', 15, 40)) ;
    X =:= 3 -> assertz(farm('bayam', 20, 60))), !.