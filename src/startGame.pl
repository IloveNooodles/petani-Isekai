/* TO DO */

/* DYNAMICS */
:- dynamic(job/1).

/* exp(type: [general, fish, farm, ranch], value) */
:- dynamic(exp/2). 

/* level(type: [general, fish, farm, ranch], value) */
:- dynamic(level/2).
:- dynamic(stamina/1).
:- dynamic(maxStamina/1).
:- dynamic(gold/1).
:- dynamic(playerName/1).

/* START GAME (WELCOME SCREEN) */
startGame:- 
    write('             x\n  .-. _______|\n  |=|/     /  \\ \n  | |_____|_""_|\n  |_|_[X]_|____|\n\n'), /* ASCII ART */
    write('Harvest Galaxy S22!!!\n'),
    write('Let\'s play and pay our debts together!\n\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                           ~Harvest Galaxy S22~                               %\n'),
    write('% 1. start.  : untuk memulai petualanganmu                                     %\n'),
    write('% 2. help.   : menampilkan bantuan                                             %\n'),
    write('% 3. exit.   : keluar dari game                                                %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n'),
    write('PENTING!!! Akhiri semua perintah atau inputmu dengan titik (.)\n'), !.

/* START */
start:-
    % Clear all stats
    resetStat,
    resetTime,
    retractall(endGame(_)),
    asserta(endGame(false)),
    startTime,
    startDay,
    startSeason,
    startWeather,
    % Choose job
    write('Welcome to Harvest Galaxy S22! What\'s your name?\n> '),
    read(Name),
    setPlayerName(Name),
    format('Hello, ~w! Please choose your specialty (1-3):\n', [Name]),
    write('1. Fisherman\n'),
    write('2. Farmer\n'),
    write('3. Rancher\n'),
    write('> '),
    read(Job),
    ((
        Job = 1,
        setStat(fisherman),
        write('You chose fisherman. ')
    );(
        Job = 2,
        setStat(farmer),
        write('You chose farmer. ')
    );(
        Job = 3,
        setStat(rancher),
        write('You chose rancher. ')
    )),
    % Assert level one stats
    levelOne,
    fill_map,
    write('Let\'s start farming!\nHint: you can now check your status ;)\n').

/* PLAYER NAME AND BASE STATS */
setPlayerName(Name) :-
    retractall(playerName(_)),
    asserta(playerName(Name)).

setStat(fisherman):-
    asserta(job(fisherman)),
    asserta(exp(fish, 20)),
    asserta(exp(farm, 0)),
    asserta(exp(ranch, 0)).

setStat(farmer):-
    asserta(job(farmer)),
    asserta(exp(fish, 0)),
    asserta(exp(farm, 20)),
    asserta(exp(ranch, 0)).

setStat(rancher):-
    asserta(job(rancher)),
    asserta(exp(fish, 0)),
    asserta(exp(farm, 0)),
    asserta(exp(ranch, 20)).

levelOne:-
    asserta(exp(general, 0)),
    asserta(level(general, 1)),
    asserta(level(fish, 1)),
    asserta(level(farm, 1)),
    asserta(level(ranch, 1)),
    asserta(stamina(100)),
    asserta(maxStamina(100)),
    asserta(gold(500)).

/* RESET STATS */
resetStat:-
    retractall(job(_)),
    retractall(exp(_,_)),
    retractall(level(_,_)),
    retractall(stamina(_)),
    retractall(maxStamina(_)),
    retractall(gold(_)).

/* STATUS */
status:-
    day(Day),
    weather(Weather),
    season(Season),
    job(Job),
    level(general, Level),
    naikLevel(Level, NextExp, general),
    level(fish, LevelFish),
    exp(fish, ExpFish),
    naikLevel(LevelFish, NextExpFish, fish),
    level(farm, LevelFarm),
    exp(farm, ExpFarm),
    naikLevel(LevelFarm, NextExpFarm, farm),
    level(ranch, LevelRanch),
    exp(ranch, ExpRanch),
    naikLevel(LevelRanch, NextExpRanch, ranch),
    exp(general, Exp),
    stamina(Stamina),
    maxStamina(MaxStamina),
    gold(Gold),
    % Print
    printTime,
    format('   📆 ~d   ⛅️ ~w   🌲 ~w\n\n', [Day, Weather, Season]),
    greeting,
    write('-------------------------\n'),
    format('Job      : ~w\n', [Job]),
    format('Level    : ~d (~d/~d exp)\n', [Level, Exp, NextExp]),
    format('Fishing  : ~d (~d/~d exp)\n', [LevelFish, ExpFish, NextExpFish]),
    format('Farming  : ~d (~d/~d exp)\n', [LevelFarm, ExpFarm, NextExpFarm]),
    format('Ranching : ~d (~d/~d exp)\n', [LevelRanch, ExpRanch, NextExpRanch]),
    format('Stamina  : ~d/~d\n', [Stamina, MaxStamina]),
    format('Gold     : ~d\n', [Gold]),
    !.

printTime:-
    time(H, M),
    M < 10,
    format('🕑 ~d:0~d', [H, M]),
    !.

printTime:-
    time(H, M),
    format('🕑 ~d:~d', [H, M]).

greeting:-
    playerName(Name),
    time(Hour, _),
    Hour >= 0, Hour =< 12,
    format('Good morning, ~w!\n', [Name]).

greeting:-
    playerName(Name),
    time(Hour, _),
    Hour > 12, Hour =< 18,
    format('Good afternoon, ~w!\n', [Name]).

greeting:-
    playerName(Name),
    time(Hour, _),
    Hour > 18, Hour =< 23,
    format('Good evening, ~w!\n', [Name]).