:- include('inventory.pl').
:- include('weather.pl').
:- include('items.pl').

shopitem('bait',sunny).
shopitem('bait',flood).


sell :-
    totalItems(X),
    X =:= 0,
    write('You dont have item to sell, comeback later!\n'), !.

sell :-
    write('What do you want to sell?\n'),
    currentInventory(Inv),
    writeInv(1,Inv),
    write('>>>'),
    read(Y),
    write('amount : '),
    read(Z),
    sellitem(Y,Z), !.

buy :-
    currentWeather(X),
    market(X),
    write('What do you want to buy?\n'),
    read(Y),
    write('How many do you want to buy?\n'),
    read(Z),

