:- dynamic(isQuest/1).

% farm, fish, ranch
:- dynamic(quest/3).
:- dynamic(needed/3).

quest :- \+ isQuest(_), asserta()
    write('Welcome! Here are your available daily quests!'), nl, listDailyQuest, nl, 
    repeat,
    write('Which quest would you like to do today?'), nl,
    read(Choice), nl,
    (Choice =:= 1 -> daily1, nl ;
    Choice =:= 2 -> daily2, nl ;
    Choice =:= 3 -> daily3, nl ;
    write('You think that\'s funny? Try again.', nl, fail)), !.

quest :- isQuest(_), quest(A, B, C), needed(D, E, F),
    A >= D, B >= E, C >= F,
    write('Congrats. Nice work.'), nl, 
    retractall(quest(A, B, C)), retractall(needed(D, E, F)), !.

quest :- write('You have an on-going quest. Finish that first!'), !.

listDailyQuest :- write('1. Menaklukkan Sapi Gila'), nl, write('2. Menunggang Lele Raksasa'), nl, write('3. Menanam Bunga Sangat Imut'), nl, !.

daily1 :- asserta(needed(2, 2, 3)), 
    write('A crazy cow has been wreaking havoc in the village.'), nl,
    write('The only way to stop this crazy cow from going loco is to give'), nl,
    write('2 wortels, 2 teri mini, and 3 susu segar.'), nl,
    write('Find those items and type <quest> to turn in the necessary items.'), nl, !.

daily2 :- asserta(needed(2, 3, 2)), !.

daily3 :- asserta(needed(3, 2, 2)), !.

ultimatequest1 :- write("MENAKLUKKAN SAPI GILA")