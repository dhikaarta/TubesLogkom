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
    write('Available Commands: '), nl,
    write('1. map       : type \"map.\" to display the map of Harvest Star.'), nl,
    write('2. status    : type \"status.\" to display your current status.'), nl,
    write('3. inventory : type \"inventory.\" to display your inventory.'), nl,
    write('4. throwItem : type \"throwItem.\" to throw useless item from inventory.'), nl,
    write('5. w         : type \"w.\" to move north.'), nl,
    write('6. a         : type \"a.\" to move west.'), nl,
    write('7. s         : type \"s.\" to move south.'), nl,
    write('8. d         : type \"d.\" to move east.'), nl,
    write('9. help      : type \"help.\" to view available commands.'), nl,
    write('10. dig      : type \"dig.\" to dig a normal tile.'), nl,
    write('11. plant    : type \"plant.\" to plant seeds into a digged tile.'), nl,
    write('12. harvest  : type \"harvest.\" to harvest grown crop tile.'), nl,
    write('13. fish     : type \"fish.\" to do fishing near the water tile.'), nl,
    write('14. ranch    : type \"ranch.\" to do ranching in ranch tile.'), nl,
    write('15. market   : type \"market.\" to buy, sell, and upgrade items and tools in marketplace tile.'), nl,
    write('16. quest    : type \"quest.\" to view and submit quest.'), nl,
    write('17. house    : type \"house.\" to enter house tile.'), nl,
    write('18. quit     : type \"quit.\" to quit game.'), nl, nl.

quit :-
    halt(0).