:- include('map.pl').
:- include('exploration.pl').

start :-
    createMap.

quit :-
    halt(0).