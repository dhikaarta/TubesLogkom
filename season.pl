:- dynamic(currentSeason/1).

currentSeason(spring). %first season is spring

season(spring).
season(summer).
season(fall).
season(winter).

isValidSeason(X) :- 
    season(X).

changeSeason(X) :- 
    isValidSeason(X), retract(currentSeason(_)), assertz(currentSeason(X)), currentSeason(spring), 
    write('Its now Spring ! Flowers are blooming and Animals are more active!'), nl,!.

changeSeason(X) :- 
    isValidSeason(X), retract(currentSeason(_)), assertz(currentSeason(X)), currentSeason(summer), 
    write('Its now Summer ! Days are warmer and hotter , also theres rare fishes in the lake now !'), nl,!.

changeSeason(X) :- 
    isValidSeason(X), retract(currentSeason(_)), assertz(currentSeason(X)), currentSeason(fall), 
    write('Its now Fall ! Temperatures are starting to drop, prepare for winter ! Theres rare seeds in the marketplace now! '), nl,!.

changeSeason(X) :- 
    isValidSeason(X), retract(currentSeason(_)), assertz(currentSeason(X)), currentSeason(winter), 
    write('Its now Winter ! Crops are bad, Animals are less active, and Its harder to Fish ! Hope youve prepared to survive winter.'), nl,!.

changeSeason(X) :-
    \+isValidSeason(X),
    write('No such season !').

whatSeasonIsIt(X) :- 
                   (X =:= 31 -> changeSeason(summer),!;
                    X =:= 61 -> changeSeason(fall),!;
                    X =:= 91 -> changeSeason(winter),!;
                    X =:= 121 -> changeSeason(spring),!;
                    X =:= 151 -> changeSeason(summer),!;
                    X =:= 181 -> changeSeason(fall),!;
                    X =:= 211 -> changeSeason(winter),!;
                    X =:= 241 -> changeSeason(spring),!;
                    X =:= 271 -> changeSeason(summer),!;
                    X =:= 301 -> changeSeason(fall),!;
                    X =:= 331 -> changeSeason(winter),!;
                    X =:= 361 -> changeSeason(spring)),!.

whatSeasonIsIt(_) :- !.