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
                    write('Would you like to restart the game ? y/n '),nl, read(CC),nl,nl, (CC == 'y' -> start;abort).


loseCondition(X,Y) :- !.
