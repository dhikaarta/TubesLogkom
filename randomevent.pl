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

fishAccident :-  write('While you were trying to cast the reel, you slipped and hit your head !'),nl,unconsious(1), loseExp(50,2),
                unconsiousGold(20) ,!.


ranchAccident :-  write('While you were trying to pet your animals, a giant bird pooped on your head, you fainted from the shock!'),nl,unconsious(1), loseExp(50,3),
                  unconsiousGold(20) ,!.


farmAccident :-  write('Your shovel bounced and hit you on your head, you fainted !'), nl,unconsious(1),loseExp(50,1),
                 unconsiousGold(20),!.






