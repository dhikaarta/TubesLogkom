% kalo mo nyoba, compile fishing.pl trs <start.> biar musim sm char nya keassert

:- dynamic(ranch/4).    

ranch :- \+ ranch(_, _, _, _),
    write('Here are a list of your available livestocks!'), nl, livestock, ranch(Livestock, Produce, Time, _),
    write('You chose '), write(Livestock), write('. Great. Now let\'s care for it.'), nl, nl, pat, 
    write('Come back in '), write(Time), write(' seconds to get your '), write(Produce), write(' by typing <collect> in the main menu'), !.

ranch :- write('Shouldn\'t you be typing <\'collect\'> instead of <\'ranch\'> ?'), !.

collect :- \+ ranch(_, _, _, _), write('You tried collecting eggs from a nearby chicken, but all you got was chicken poop.'), nl, write('Ranch first.'), !.

collect :- ranch(_, Produce, Time, _), (Time > 0),
    write('Come back in '), write(Time), write(' seconds to get your '), write(Produce), !.

% winter = syulit farming
collect :- currentSeason(X), X == winter, random(0, 10, N),
    (   N < 6 -> write('You forgot to give scarfs and hand-warmers to the animal.'), nl,
    write('It died peacefully in the midst of the cold winter.'), nl, nl,
    write('You gained nothing and 0 Gold.'),
    retractall(ranch(_, _, _, _)) ;
    ranchxpmoney   ), !.

collect :- ranchxpmoney, !.

% nanti nambah XP + XP Ranching disini + tambahin di inventory
ranchxpmoney :- ranch(Livestock, Produce, Time, Price), character(A, B, Exp, Money),
    write('Finally... It is time.'), nl, write('You gained '), write(Produce), write(' and '), write(Price), write(' Golds.'), nl,
    CurMoney is Money + Price, CurExp is Exp + 4, retract(character(A, B, Exp, Money)), asserta(character(A, B, CurExp, CurMoney)), 
    retractall(ranch(Livestock, Produce, Time, Price)), !.

% mockup inventory
livestock :- 
    /* testing aja, nanti ceknya dari inventory */
    write('1. AUTO-JADI --> daging auto-jadi'), nl, write('2. ayam --> telor ayam'), nl, write('3. sapi --> susu segar'), nl, write('4. domab --> wol'), nl,
    write('Which livestock will you raise?'), nl,
    read(X),
    (   X =:= 1 -> asserta(ranch('AUTO-JADI', 'daging auto-jadi', 0, 20)) ;
        X =:= 2 -> asserta(ranch('ayam', 'telor ayam', 25, 35)) ;
        X =:= 3 -> asserta(ranch('sapi', 'susu segar', 30, 40)) ;
        X =:= 4 -> asserta(ranch('dombab', 'wol', 35, 60))  ), !.

loop(1) :- write('*PAT* '), nl, !.

loop(X) :- write('*PAT* '), Y is X - 1, loop(Y).

pat :- ranch(Livestock, Produce, Time, Price),
    write('The price of your produce will surge if the quality is good.'), nl, 
    write('You can maintain quality by patting the animal like this'), nl, nl,
    random(1, 11, N), loop(N), nl, 

    write('Now, how many times would you like to pat the animal?'), nl, read(Pat), nl,
    write('You pat the animal '), write(Pat), write(' time(s).'), nl, nl,
    (   Pat =:= N -> write('Seems like it\'s working. Good job.'), CurPrice is Price + 7,
        retract(ranch(Livestock, Produce, Time, Price)), 
        asserta(ranch(Livestock, Produce, Time, CurPrice)) ; 
        write('The animal seems unbothered by your action. Do better next time.')   ), nl, !.