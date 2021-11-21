% ges utk skrg waktunya hardcode dl soalnya batesannya disuruh tinggalin tidur ya kan ya :V
% kalo mo nyoba harvest, pilih taneman AUTO-JADI 
% btw apa pas ngedig ada chance dia ktm gold ya? lol :V

:- dynamic(farm/3).

farm :- \+ farm(_, _, _),
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
    (   Plant == 'PLZ BLESS MY SEED' -> write('That was easy. Now is the hardest part: waiting.'), nl ;
        write('...Try again. Please.'), nl, fail), 
    write('Come back in '), write(Time), write(' seconds to get your '), write(Seed), write(' by typing <harvest> in the main menu'), !.

farm :- write('You should harvest your crop before farming again.'), !.

harvest :- \+ farm(_, _, _), write('... You do realize you haven\'t planted anything, right?'), !.

harvest :- 
    farm(Seed, Time, _), (Time > 0),
    write('Come back in '), write(Time), write(' seconds to get your '), write(Seed), !.

% nanti nambah XP + XP Farming di harvest yg ini
harvest :-
    farm(Seed, Time, Price),
    write('The time has come for you to reap what you sow... Literally.'), nl,
    write('You gained '), write(Seed), write(' and '), write(Price), write(' Golds.'), 
    retractall(farm(Seed, Time, Price)), !.

% mockup inventory
seeds :- 
    write('1. AUTO-JADI'), nl, write('2. wortel'), nl, write('3. bayam'), nl,
    read(X),
    (X =:= 1 -> asserta(farm('AUTO-JADI', 0, 20)) ;
    X =:= 2 -> asserta(farm('wortel', 15, 40)) ;
    X =:= 3 -> asserta(farm('bayam', 20, 60))), !.