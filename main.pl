:- include('map.pl').
:- include('exploration.pl').
:- include('player.pl').

:- include('season.pl').
:- include('weather.pl').

:- include('items.pl').
:- include('inventory.pl').
:- include('market.pl').

:- include('randomevent.pl').
:- include('house.pl'). /* BUG: Terkadang masih suka return no saat sleep */

:- include('quest.pl').

:- include('farming.pl').
:- include('fishing.pl').
:- include('ranching.pl').

start :-
    createMap,
    initPlayer.

quit :-
    halt(0).