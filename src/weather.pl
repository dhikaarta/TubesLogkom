:- dynamic(currentWeather/1).

currentWeather(sunny).

weather(rainy).
weather(sunny).
weather(snowing).

isValidWeather(X) :- weather(X).

weatherRandomizer :- \+ currentSeason(winter),\+ currentSeason(summer), random(1,101, X),
                     (X < 51 -> retract(currentWeather(_)), assertz(currentWeather(rainy)), write('Its raining today ! Be careful out there.'),nl,rainingArt,nl, nl;
                      X > 50 -> retract(currentWeather(_)), assertz(currentWeather(sunny)), write('What a beatiful day ! The sun is shining brightly today !'),nl,sunrise,nl, nl), !.

weatherRandomizer :- currentSeason(summer), random(1,101, X),
                     (X < 31 -> retract(currentWeather(_)), assertz(currentWeather(rainy)), write('Its raining today ! Be careful out there.'), nl,rainingArt,nl, nl;
                      X > 30 -> retract(currentWeather(_)), assertz(currentWeather(sunny)), write('What a beatiful day ! The sun is shining brightly today !'), nl,sunrise,nl, nl), !.

weatherRandomizer :-  currentSeason(winter), random(1,101, X),
                      (X < 20 ->retract(currentWeather(_)), assertz(currentWeather(sunny)), write('What a beatiful day ! The sun is shining brightly today !'), nl,sunrise,nl, nl;
                       retract(currentWeather(_)), assertz(currentWeather(snowing)), write('Its snowing! '),nl,snowing,nl, nl),!.

changeWeather(X) :-
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(rainy),!.

changeWeather(X) :- 
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(sunny),!.

changeWeather(X) :- 
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(snowing),!.

changeWeather(X) :-
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(flood),!.

sunrise :-
write('            .   :  ;   ,          ___               '),nl,
write('""------.__  \\.      ,/    .----\'"   ""`--.       '),nl,
write('____.------\'-   ,--.  -    ""-------\'""""         '),nl,
write('\\_______-_-=___/____\\__=-_-_______/";\\.____      '),nl,
write('`\\.              --           .--\'   \\"-.        '),nl,
write('. `\\._          "" --          """\\""/""          '),nl,
write(' `    `"--..    _--                "                '),nl,
write('     --\',.---\'   - "                              '),nl,
write('----\'"""         "_-                               '),nl,    
write('  /                                ____,,....__     '),nl,
write('/                   ___..------\'"""            `"" '),nl.

rainingArt :-
write('      ------               _____          '),nl,   
write('       /      \\ ___\\     ___/    ___    '),nl,   
write('    --/-  ___  /    \\/  /  /    /   \\   '),nl,   
write('   /     /           \\__     //_     \\  '),nl,   
write('  /                     \\   / ___     |  '),nl,   
write('  |           ___       \\/+--/        /  '),nl,   
write('   \\__           \\       \\           / '),nl,   
write('      \\__                 |          /   '),nl,     
write('     \\     /____      /  /       |   /   '),nl,        
write('      _____/         ___       \\/  /\\   '),nl,       
write('           \\__      /      /    |    |   '),nl,     
write('         /    \\____/   \\       /   //   '),nl,                                 
write('     // / / // / /\\    /-_-/\\//-__-     '),nl,                 
write('      /  /  // /   \\__// / / /  //       '),nl,   
write('     //   / /   //   /  // / // /         '),nl,   
write('      /// // / /   /  //  / //            '),nl,   
write('   //   //       //  /  // / /            '),nl.  

snowing :-
write('.      *    *           *.       *   .                      *     .      '),nl,
write('               .   .                   __   *    .     * .     *         '),nl,
write('    *       *         *   .     .    _|__|_        *    __   .       *   '),nl,
write('  .  *  /\\       /\\          *        (\'\')    *       _|__|_     .   '),nl,
write('       /  \\   * /  \\  *          .  <( . )> *  .       (\'\')   *   *  '),nl,
write('  *    /  \\     /  \\   .   *       _(__.__)_  _   ,--<(  . )>  .    .  '),nl,
write('      /    \\   /    \\          *   |       |  )),`   (   .  )     *    '),nl,
write('   *   `||` ..  `||`   . *.   ... ===========\'`   ... \'--`-` ... *  .  '),nl.