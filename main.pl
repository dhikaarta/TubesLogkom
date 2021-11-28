:- include('map.pl').
:- include('exploration.pl').
:- include('player.pl').
:- include('season.pl').
:- include('weather.pl').
:- include('items.pl').
:- include('inventory.pl').
:- include('market.pl').
:- include('randomevent.pl').
:- include('house.pl').
:- include('quest.pl').
:- include('farming.pl').
:- include('fishing.pl').
:- include('ranching.pl').

start :-
    createMap,
    initLivestock,
    initPlayer.

quit :-
    halt(0).