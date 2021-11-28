isBirthday :- day(Day), birthday(Birthday), Day =:= Birthday, 
            write('  SSS  U   U RRRR  PPPP  RRRR  III  SSS  EEEE !! '),nl,
            write(' S     U   U R   R P   P R   R  I  S     E    !! '),nl,
            write('  SSS  U   U RRRR  PPPP  RRRR   I   SSS  EEE  !! '),nl,
            write('     S U   U R R   P     R R    I      S E       '),nl,
            write(' SSSS   UUU  R  RR P     R  RR III SSSS  EEEE !! '),nl,nl,
            write('It\'s your birthday !!!'), nl,
            write('A mysterious man knocked on your door'),nl,
            write('The man brought 5 boxes and told you that 4 of them have a prize inside, choose a number between 1-5'),nl,
            read(CC), random(1,6,X), 
            (CC =:= X -> write('BOOM, the box exploded right in front of your face, unlucky even on your birthday huh\n');
             write('The man brought you 150 gold ! HAPPY BIRTHDAY '), nl, addGold(150)).

isBirthday :- day(Day), birthday(Birthday), Day =\= Birthday,  !.

fishAccident :- write('==============================================================================='), nl,
                write('You almost caught another fish, but the fish slapped you in the face and left.'),nl,unconsious(1), loseExp(50,2),
                unconsiousGold(20) ,
                write('==============================================================================='), nl, !.


ranchAccident :- write('======================================================================================================'), nl,  
                write('You went to the storage room only to find that your animals are starting a cult. They anesthetized you.'),nl,unconsious(1), loseExp(50,3),
                unconsiousGold(20) ,
                write('======================================================================================================='), nl, !.


farmAccident :- write('========================================================================='), nl,
                write('Your recklessness caused you to hit yourself with a shovel. You fainted.'), nl,unconsious(1),loseExp(50,1),
                unconsiousGold(20),
                write('========================================================================='), nl, !.






