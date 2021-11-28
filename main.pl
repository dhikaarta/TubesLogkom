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
    introduction,
    createMap,
    initLivestock,
    initPlayer.

introduction :-
    write(' _   _                           _     _____ _             '), nl,
    write('| | | |                         | |   /  ___| |            '), nl,
    write('| |_| | __ _ _ ____   _____  ___| |_  \\ `--.| |_ __ _ _ __ '), nl,
    write('|  _  |/ _` | \'__\\ \\ / / _ \\/ __| __|  `--. \\ __/ _` | \'__|'), nl,
    write('| | | | (_| | |   \\ V /  __/\\__ \\ |_  /\\__/ / || (_| | |   '), nl,
    write('\\_| |_/\\__,_|_|    \\_/ \\___||___/\\__| \\____/ \\__\\__,_|_|   '), nl, nl,
    write('We welcome you to Harvest Star!'), nl,
    write('Let\'s pay our debts with laughter and joy!'), nl, nl,
    help.

help :-
    write('Available Command: '), nl,
    write('1. start     : type \"start.\" to begin your adventure in Harvest Star.'), nl,
    write('2. map       : type \"map.\" to display the map of Harvest Star.'), nl,
    write('3. status    : type \"status\" to display your current status.'), nl,
    write('4. w         : type \"w\" to move north.'), nl,
    write('5. a         : type \"a\" to move west.'), nl,
    write('6. s         : type \"s\" to move south.'), nl,
    write('7. d         : type \"d\" to move east.'), nl, 
    write(''), nl.

quit :-
    halt(0).