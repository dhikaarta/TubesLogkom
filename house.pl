:- dynamic(isLocked/0).
:- dynamic(day/1).

day(1).
house :- 
    isLocked, write('Your house is locked, write U. to unlock it'),
    read(CC), CC == 'U' -> unlock.
house :- 
    \+ isLocked,
    write('What do you want to do?'),nl,
    write('- sleep'),nl, write('- writeDiary'),nl, write('- readDiary'),nl, 
    write('- exit'),nl,write('- lock'),nl,read(CC),
    (CC == 'sleep' -> sleep;
     CC == 'writeDiary' -> writeDiary;
     CC == 'readDiary' -> readDiary;
     CC == 'lock' -> lock).

houseloop :- 
    write('What do you want to do?'),nl,
    write('- sleep'),nl, write('- writeDiary'),nl, write('- readDiary'),nl, 
    write('- exit'),nl,write('- lock'),nl,read(CC),
    (CC == 'sleep' -> sleep;
     CC == 'writeDiary' -> writeDiary;
     CC == 'readDiary' -> readDiary;
     CC == 'lock' -> lock).

sleep :-
    write('You went to sleep'),nl,
    day(X), Xnew is X+1, retract(day(_)), asserta(day(Xnew)),
    restoreEnergy,(\+isLocked -> robbery).

robbery :- random(1,101,X), (X<10 -> write('Youve been robbed !')).

lock :- \+ isLocked, asserta(isLocked),write('you locked your house'),nl,houseloop.

lock :- isLocked, write('youve already locked the door'),houseloop.

unlock :- \+ isLocked, write('Your house is not locked'),nl,houseloop.

unlock :- isLocked, retract(isLocked),houseloop.


