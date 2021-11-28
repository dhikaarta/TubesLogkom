:- dynamic(isLocked/0).
:- dynamic(day/1).
:- dynamic(diary/2).

day(1).

house :-
    isPlayerTile(A, B),
    isHouseTile(A, B),
    isLocked, 
    write('Your house is locked, write 1. to unlock it'),
    read(CC), 
    (CC == 1 -> unlock).

house :- 
    isPlayerTile(A, B),
    isHouseTile(A, B),
    \+ isLocked,
    write('What do you want to do?'),nl,
    write('- sleep'),nl, write('- writeDiary'),nl, write('- readDiary'),nl, 
    write('- lock'),nl,read(CC),
    (CC == 'sleep' -> sleep;
     CC == 'writeDiary' -> writeDiary;
     CC == 'readDiary' -> readDiary;
     CC == 'lock' -> lock;
     CC == 'unlock' -> unlock).
sleep :-
    isPlayerTile(A, B),
    isHouseTile(A, B),
    write('It\'s been a long day , You went to sleep'), nl, nl,
    day(X), Xnew is X+1, retract(day(_)), assertz(day(Xnew)),player(_,_,_,_,_,_,_,_,_,_,K,_),loseCondition(Xnew,K),
    restoreEnergy,robbery, periTidur,wakeUp.


wakeUp :- day(X),format('Good Morning ! Its now day ~d \n\n', [X]),isBirthday,whatSeasonIsIt(X),weatherRandomizer,currentSeason(CurSeason),
          currentWeather(CurWeather), format('\nSeason : ~w\nWeather : ~w\n\n', [CurSeason,CurWeather]), checkDeath, countCroppedTile(CountCrop), updateCrop(CountCrop), updateRanch,!.

robbery :- 
    \+ isLocked,random(1,101,X),nl, (X<10 -> write('Youve been robbed !\n')),unconsiousGold(100),!.
robbery :- !.
robbery :- isLocked,!.

lock :- 
    isPlayerTile(A, B),
    isHouseTile(A, B),
    \+ isLocked, assertz(isLocked),write('You locked your house'),nl,nl,!.

lock :- 
    isPlayerTile(A, B),
    isHouseTile(A, B),
    isLocked, write('Youve already locked the door'),nl,nl,!.

unlock :- 
    isPlayerTile(A, B),
    isHouseTile(A, B),
    \+ isLocked, write('Your house is not locked'),nl,nl,!.

unlock :- 
    isPlayerTile(A, B),
    isHouseTile(A, B),
    isLocked, retract(isLocked),!.

writeDiary :-  
    isPlayerTile(A, B),
    isHouseTile(A, B),
    day(X), write('Masukkan entri untuk Day '), write(X), nl, read(DiaryInput), assertz(diary(X,DiaryInput)).

readDiary :- 
    isPlayerTile(A, B),
    isHouseTile(A, B),
    write('Here are the list of your entries :'), nl,forall(diary(X,_), format('- Day ~d\n', [X])), read(CC),
             diary(CC,Output), nl, write(Output), nl,nl.

changeDay(X) :- 
    retractall(day(_)), assertz(day(X)). 

periTidur :- 
    random(1,101,X),X < 3,nl, write('A dream fairy has visited you, you can go anywhere you want for tomorrow, where do you want to go?'),nl,
             write('1. Water'),nl,write('2. Quest'),nl, write('3. Ranch'),nl,
             write('4. Marketplace'), nl,read(CC),
             (CC=:=1 -> write('Wish granted ! Youll wake up beside the water! Go fish\n'),teleport(4,8) ;
              CC =:= 2 -> write('Wish granted ! Youll wake up on the quest tile ! Get some quest\n'),teleport(7,3) ;
              CC =:= 3 -> write('Wish granted ! Youll wake up in your ranch !\n'),teleport(10,5);
              CC =:= 4 -> write('Wish granted ! Youll wake up in the market! SHOPPING SPREE\n'),teleport(10,12)),!.

periTidur :- !.

unconsious(X) :- 
    write('You are unconscious for who knows how long. Well, at least you\'re resting...\n\n'),
                 day(Day), NewDay is Day + X, retract(day(_)), assertz(day(NewDay)), nl, wakeUp.
                 
loseCondition(X,Y) :- X > 365, Y < 20000, 
                    write('It is now day 366, You failed to pay your debts in time, the debt collectors are knocking on your door, who knows what they\'re going to do... '),
                    nl,nl,nl,
                    write('               (\'-.     _   .-\')       (\'-.                           (`-.      (\'-.  _  .-\')   '),nl,
                    write('              ( OO ).-.( \'.( OO )_   _(  OO)                        _(OO  )_  _(  OO)( \\( -O )  '),nl,
                    write('  ,----.      / . --. / ,--.   ,--.)(,------.       .-\'),-----. ,--(_/   ,. \\(,------.,------.  '),nl,
                    write(' \'  .-./-\')   | \\-.  \\  |   `.\'   |  |  .---\'      ( OO\'  .-.  \'\\   \\   /(__/ |  .---\'|   /`. \' '),nl,
                    write(' |  |_( O- ).-\'-\'  |  | |         |  |  |          /   |  | |  | \\   \\ /   /  |  |    |  /  | | '),nl,
                    write(' |  | .--, \\ \\| |_.\'  | |  |\'.\'|  | (|  \'--.       \\_) |  |\\|  |  \\   \'   /, (|  \'--. |  |_.\' | '),nl,
                    write('(|  | \'. (_/  |  .-.  | |  |   |  |  |  .--\'         \\ |  | |  |   \\     /__) |  .--\' |  .  \'.\' '),nl,
                    write(' |  \'--\'  |   |  | |  | |  |   |  |  |  `---.         `\'  \'-\'  \'    \\   /     |  `---.|  |\\  \\  '),nl,
                    write('  `------\'    `--\' `--\' `--\'   `--\'  `------\'           `-----\'      `-\'      `------\'`--\' \'--\' '),nl,nl,nl,
                    write('Would you like to restart the game ? y/n '),nl, read(CC),nl,nl, (CC == 'y' -> [main],start;abort).


loseCondition(_,_) :- !.
