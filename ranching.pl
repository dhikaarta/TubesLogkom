% kalo mo nyoba, compile fishing.pl trs <start.> biar musim sm char nya keassert

:- dynamic(ranch/4).    

% nanti tambahin kasus inventory kosong
ranching :- \+ ranch(_, _, _, _),
    write('Here are a list of your available livestocks!'), nl, 
    livestock, ranch(Livestock, Produce, Time, _),

    format('You chose ~w. Great, now let\'s care for it.', [Livestock]), nl, nl, pat,
    format('Come back in ~d seconds to get your ~w', [Time, Produce]), nl,
    write('You can do this by typing <collect> in the main menu'), !.

ranching :- ranch(_, _, _, _),
    write('Shouldn\'t you be typing <\'collect\'> instead of <\'ranching\'> ?'), !.

collect :- \+ ranch(_, _, _, _), 
    write('You tried collecting eggs from a nearby chicken...'), nl,
    write('...but all you got was chicken poop.'), nl, nl,
    write('That\'s what you get for not ranching first.'), !.

collect :- ranch(_, Produce, Time, _), (Time > 0),
    write('Come back in ~d seconds to get your ~w', [Time, Produce]), !.

% winter = syulit farming
collect :- currentSeason(X), X == winter, random(0, 10, N),
    (   N < 6 -> write('You forgot to give scarfs and hand-warmers to the animal.'), nl,
    write('It died peacefully in the midst of the cold winter.'), nl, nl,
    write('You gained nothing and 0 Gold.'),
    retractall(ranch(_, _, _, _)) ;
    ranchxpmoney   ), !.

collect :- ranchxpmoney, !.

% nanti nambah XP + XP Ranching disini + tambahin di inventory
ranchxpmoney :- ranch(Livestock, Produce, Time, Price),
    player(Job, Level, C, D, E, F, LevelRanch, ExpRanch, Exp, G, Money, H),
    write('Finally... It is time.'), nl, write('You gained '), write(Produce), nl, 
    format('You can sell this ~w for ~d Golds in the marketplace', [Produce, Price]), nl,

    NewExpRanch is (13 * (LevelRanch)),
    NewExp is (3 * Level),
    CurExp is NewExp + Exp,
    CurExpFarm is NewExpRanch + ExpRanch,
    (   Job == 'Rancher' ->  write('You were paid for working as a rancher'), nl,
                            Salary is (LevelRanch * 5),
                            addGold(Salary)     ), nl,

    write('Current XP Ranching: '), write(CurExpRanch), nl,

    addItem(Produce, 1),
    addExp(NewExp, 0),
    addExp(NewExpRanch,2),
    retractall(ranch(_, _, _, _)), !.

% mockup inventory
livestock :- 
    /* testing aja, nanti ceknya dari inventory */
    write('1. AUTO-JADI --> daging auto-jadi'), nl, write('2. ayam --> telor ayam'), nl, write('3. sapi --> susu segar'), nl, write('4. domab --> wol'), nl,
    write('Which livestock will you raise?'), nl,
    read(X),
    (   X =:= 1 -> assertz(ranch('AUTO-JADI', 'daging auto-jadi', 0, 20)) ;
        X =:= 2 -> assertz(ranch('ayam', 'telor ayam', 25, 35)) ;
        X =:= 3 -> assertz(ranch('sapi', 'susu segar', 30, 40)) ;
        X =:= 4 -> assertz(ranch('dombab', 'wol', 35, 60))  ), !.

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
        assertz(ranch(Livestock, Produce, Time, CurPrice)) ; 
        write('The animal seems unbothered by your action. Do better next time.')   ), nl, !.