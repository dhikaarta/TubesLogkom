:- include('season.pl').


:- dynamic(currentWeather/1).

currentWeather(sunny).

weather(rainy).
weather(sunny).
weather(snowing).
weather(flood).
weather(hailstorm).

isValidWeather(X) :- weather(X).

weatherRandomizer :- \+ currentSeason(winter), random(1,101, X),
                     (X < 3 -> retract(currentWeather(_)), assertz(currentWeather(flood)), write('Its flooding today ! You cant go out there, just go back to sleep ! '),nl,sleep;
                      X < 51 -> retract(currentWeather(_)), assertz(currentWeather(rainy)), write('Its raining today ! Be careful out there.'), nl;
                      X > 50 -> retract(currentWeather(_)), assertz(currentWeather(sunny)), write('What a beatiful day ! The sun is shining brightly today !'), nl), !.

weatherRandomizer :-  currentSeason(winter), random(1,101, X),
                      (X < 3 -> retract(currentWeather(_)), assertz(currentWeather(hailstorm)), write('Theres a hailstorm !!! You cant go out, you should just rest inside'), nl,sleep;
                       retract(currentWeather(_)), assertz(currentWeather(snowing)), write('Its snowing! '), nl),!.

changeSeason(X) :- 
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(rainy),!.

changeSeason(X) :- 
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(sunny),!.

changeSeason(X) :- 
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(snowing),!.

changeSeason(X) :- 
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(flood),!.