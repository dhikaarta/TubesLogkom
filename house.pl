:- dynamic(isLocked/0).
:- dynamic(day/1).
:- dynamic(diary/2).

day(1).

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
    write('What do you want to do next ?'),nl,
    write('- sleep'),nl, write('- writeDiary'),nl, write('- readDiary'),nl, 
    write('- exit'),nl,write('- lock'),nl,write('- unlock'),nl,read(CC),
    (CC == 'sleep' -> sleep;
     CC == 'writeDiary' -> writeDiary;
     CC == 'readDiary' -> readDiary;
     CC == 'lock' -> lock;
     CC == 'exit' -> exit;
     CC == 'unlock' -> unlock).

sleep :-
    write('You went to sleep'),nl,nl,
    day(X), Xnew is X+1, retract(day(_)), assertz(day(Xnew)),
    restoreEnergy,robbery, periTidur,wakeUp.


wakeUp :- day(X),format('Good Morning ! its now day ~d \n', [X]),isBirthday,weatherRandomizer.

robbery :- \+ isLocked,random(1,101,X),write(X),nl, (X<10 -> write('Youve been robbed !\n')),unconsiousGold(100),!.
robbery :- !.
robbery :- isLocked,!.

lock :- \+ isLocked, assertz(isLocked),write('you locked your house'),nl,nl,houseloop.

lock :- isLocked, write('youve already locked the door'),nl,nl,houseloop.

unlock :- \+ isLocked, write('Your house is not locked'),nl,nl,houseloop.

unlock :- isLocked, retract(isLocked),houseloop.

exit :- isLocked, write('Your house is locked, write 1. to unlock it'),nl,nl,
        read(CC), (CC =:= 1 -> retract(isLocked), exit;houseloop).

exit :- \+isLocked, write('You left your house'),nl.

writeDiary :-  day(X), write('Masukkan entri untuk Day '), write(X), nl, read(DiaryInput), assertz(diary(X,DiaryInput)), houseloop.

readDiary :- write('Here are the list of your entries :'), nl,forall(diary(X,_), format('- Day ~d\n', [X])), read(CC),
             diary(CC,Output), nl, write(Output), nl,nl, houseloop.

changeDay(X) :- retractall(day(CurrentDay)), assertz(day(X)). 

periTidur :- random(1,101,X), write(X),X < 10,nl, write('A dream fairy has visited you, you can go anywhere you want for tomorrow, where do you want to go?'),nl,
             write('1. Water'),nl,write('2. Quest'),nl, write('3. Ranch'),nl,
             write('4. Marketplace'), nl,read(CC),
             (CC=:=1 -> write('Wish granted ! Youll wake up beside the water! Go fish\n'),teleport(4,8) ;
              CC =:= 2 -> write('Wish granted ! Youll wake up on the quest tile ! Get some quest\n'),teleport(7,3) ;
              CC =:= 3 -> write('Wish granted ! Youll wake up in your ranch !\n'),teleport(10,5);
              CC =:= 4 -> write('Wish granted ! Youll wake up in the market! SHOPPING SPREE\n'),teleport(10,12)).

periTidur :- !.

unconsious(X) :- write('Youre unconsious! Well, atleast youre resting\n'),
                 day(Day), NewDay is Day + X, retract(day(_)), assertz(day(NewDay)), wakeUp.
                 