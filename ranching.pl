% ges utk skrg waktunya hardcode dl soalnya batesannya disuruh tinggalin tidur ya kan ya :V
% kalo mo nyoba collect, pilih taneman AUTO-JADI 

:- dynamic(ranch/4).

ranch :- \+ ranch(_, _, _, _),
    write('Here are a list of your available livestocks!'), nl, livestock, ranch(Livestock, Produce, Time, _),
    write('You chose '), write(Livestock), write('. Great. Now let\'s care for it.'), nl, nl, care,
    write('Come back in '), write(Time), write(' seconds to get your '), write(Produce), write(' by typing <collect> in the main menu'), !.

ranch :- write('Shouldn\'t you be typing <\'collect\'> instead of <\'ranch\'> ?'), !.

collect :- \+ ranch(_, _, _, _), write('You tried collecting eggs from your chicken, but all you got was chicken poop.'), nl, write('Ranch first.'), !.

collect :- 
    ranch(_, Produce, Time, _), (Time > 0),
    write('Come back in '), write(Time), write(' seconds to get your '), write(Produce), !.

% nanti nambah XP + XP Ranching disini
collect :-
    ranch(Livestock, Produce, Time, Price),
    write('Finally... It is time.'), nl,
    write('You gained '), write(Produce), write(' and '), write(Price), write(' Golds.'), 
    retractall(ranch(Livestock, Produce, Time, Price)), !.

% mockup inventory
livestock :- 
    write('1. AUTO-JADI --> daging auto-jadi'), nl, write('2. ayam --> telor ayam'), nl, write('3. sapi --> susu segar'), nl,
    write('Which livestock will you raise?'), nl,
    read(X),
    (X =:= 1 -> asserta(ranch('AUTO-JADI', 'daging auto-jadi', 0, 20)) ;
    X =:= 2 -> asserta(ranch('ayam', 'telor ayam', 15, 40)) ;
    X =:= 3 -> asserta(ranch('sapi', 'susu segar', 20, 60))), !.

% mockup to-dos
care :- random(1, 11, Choice), ranch(Livestock, Produce, Time, Price), nl,
    write('Choosing the right action can boost the quality of your produce and raise its price.'), nl,
    write('1. Feed it'), nl, write('2. Pat it'), nl, write('3. Laugh at it'), nl, write('4. Discuss politics with it'), nl, 
    write('Which action will you choose? '), read(Action),
    (Choice == Action -> write('Seems like it\'s happy with your actions!'), P is Price + 10,
    retract(ranch(Livestock, Produce, Time, Price)), asserta(ranch(Livestock, Produce, Time, P)) ;
    write('It seems unbothered by your actions. Oh well.')), nl, nl, !.