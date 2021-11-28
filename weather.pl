:- dynamic(currentWeather/1).

currentWeather(sunny).

weather(rainy).
weather(sunny).
weather(snowing).

isValidWeather(X) :- weather(X).

weatherRandomizer :- \+ currentSeason(winter),\+ currentSeason(summer), random(1,101, X),
                     (X < 51 -> retract(currentWeather(_)), assertz(currentWeather(rainy)), write('Its raining today ! Be careful out there.'), nl;
                      X > 50 -> retract(currentWeather(_)), assertz(currentWeather(sunny)), write('What a beatiful day ! The sun is shining brightly today !'), nl), !.

weatherRandomizer :- currentSeason(summer), random(1,101, X),
                     (X < 31 -> retract(currentWeather(_)), assertz(currentWeather(rainy)), write('Its raining today ! Be careful out there.'), nl;
                      X > 30 -> retract(currentWeather(_)), assertz(currentWeather(sunny)), write('What a beatiful day ! The sun is shining brightly today !'), nl), !.

weatherRandomizer :-  currentSeason(winter), random(1,101, X),
                      (X < 20 ->retract(currentWeather(_)), assertz(currentWeather(sunny)), write('What a beatiful day ! The sun is shining brightly today !'), nl;
                       retract(currentWeather(_)), assertz(currentWeather(snowing)), write('Its snowing! '), nl),!.

changeWeather(X) :-
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(rainy),!.

changeWeather(X) :- 
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(sunny),!.

changeWeather(X) :- 
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(snowing),!.

changeWeather(X) :-
    isValidWeather(X), retract(currentWeather(_)), assertz(currentWeather(X)), currentWeather(flood),!.