:- dynamic(isLocked/0).
:- dynamic(day/1).
:- dynamic(diary/2).

day(1).
diary(1,'hahahahha').
diary(2,'ini dua').
diary(3,'ini tiga').

house :- 
    isLocked, write('Your house is locked, write 1. to unlock it'),
    read(CC), (CC == 1 -> unlock).
house :- 
    \+ isLocked,
    write('What do you want to do?'),nl,
    write('- sleep'),nl, write('- writeDiary'),nl, write('- readDiary'),nl, 
    write('- exit'),nl,write('- lock'),nl,read(CC),
    (CC == 'sleep' -> sleep;
     CC == 'writeDiary' -> writeDiary;
     CC == 'readDiary' -> readDiary;
     CC == 'lock' -> lock;
     CC == 'exit' -> exit;
     CC == 'unlock' -> unlock).

houseloop :- 
    write('What do you want to do?'),nl,
    write('- sleep'),nl, write('- writeDiary'),nl, write('- readDiary'),nl, 
    write('- exit'),nl,write('- lock'),nl,write('- unlock'),nl,read(CC),
    (CC == 'sleep' -> sleep;
     CC == 'writeDiary' -> writeDiary;
     CC == 'readDiary' -> readDiary;
     CC == 'lock' -> lock;
     CC == 'exit' -> exit;
     CC == 'unlock' -> unlock).

sleep :-
    write('You went to sleep'),nl,
    day(X), Xnew is X+1, retract(day(_)), assertz(day(Xnew)),
    restoreEnergy,(\+isLocked -> robbery).

robbery :- random(1,101,X), (X<10 -> write('Youve been robbed !')).

lock :- \+ isLocked, assertz(isLocked),write('you locked your house'),nl,nl,houseloop.

lock :- isLocked, write('youve already locked the door'),nl,nl,houseloop.

unlock :- \+ isLocked, write('Your house is not locked'),nl,nl,houseloop.

unlock :- isLocked, retract(isLocked),houseloop.

exit :- isLocked, write('Your house is locked, write 1. to unlock it'),nl,nl,
        read(CC), (CC =:= 1 -> retract(isLocked), exit;houseloop).

exit :- \+isLocked, write('You left your house'),nl.

writeDiary :-  day(X), write('Masukkan entri untuk Day '), write(X), nl, read(DiaryInput), assertz(diary(X,DiaryInput)).

readDiary :- write('Here are the list of your entries :'), nl,forall(diary(X,_), format('- Day ~d\n', [X])), read(CC),
             diary(CC,Output), write(Output), nl,nl, houseloop.

changeDay(X) :- retractall(day(CurrentDay)), assertz(day(X)). 