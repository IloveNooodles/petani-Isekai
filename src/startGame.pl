/* TO DO */
% fix status window: add time and weather, fix exp level up requirement

:- dynamic(job/1).
:- dynamic(exp/1). /* General */
:- dynamic(expFish/1).
:- dynamic(expFarm/1).
:- dynamic(expRanch/1).
:- dynamic(level/1).
:- dynamic(levelFish/1).
:- dynamic(levelFarm/1).
:- dynamic(levelRanch/1).
:- dynamic(stamina/1).
:- dynamic(gold/1).

/* START GAME (WELCOME SCREEN) */
startGame:- 
    write('             x\n  .-. _______|\n  |=|/     /  \\ \n  | |_____|_""_|\n  |_|_[X]_|____|\n\n'), /* ASCII ART */
    write('Harvest Galaxy S22!!!\n'),
    write('Let\'s play and pay our debts together!\n\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                           ~Harvest Galaxy S22~                               %\n'),
    write('% 1. start.  : untuk memulai petualanganmu                                     %\n'),
    write('% 2. map.    : menampilkan peta                                                %\n'),
    write('% 3. status. : menampilkan kondisimu terkini                                   %\n'),
    write('% 4. w.      : gerak ke utara 1 langkah                                        %\n'),
    write('% 5. s.      : gerak ke selatan 1 langkah                                      %\n'),
    write('% 6. d.      : gerak ke ke timur 1 langkah                                     %\n'),
    write('% 7. a.      : gerak ke barat 1 langkah                                        %\n'),
    write('% 8. help.   : menampilkan bantuan                                             %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n'),
    write('PENTING!!! Akhiri semua perintah atau inputmu dengan titik (.)\n'), !.

/* START */
start:-
    % Clear all stats
    resetStat,
    % Choose job
    write('Welcome to Harvest Galaxy S22! Please choose your specialty (1-3):\n'),
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
    write('Let\'s start farming!\n').

/* BASE STATS */    
setStat(fisherman):-
    asserta(job(fisherman)),
    asserta(expFish(20)),
    asserta(expFarm(0)),
    asserta(expRanch(0)).

setStat(farmer):-
    asserta(job(farmer)),
    asserta(expFish(0)),
    asserta(expFarm(20)),
    asserta(expRanch(0)).

setStat(rancher):-
    asserta(job(rancher)),
    asserta(expFish(0)),
    asserta(expFarm(0)),
    asserta(expRanch(20)).

levelOne:-
    asserta(exp(0)),
    asserta(level(1)),
    asserta(levelFish(1)),
    asserta(levelFarm(1)),
    asserta(levelRanch(1)),
    asserta(stamina(100)),
    asserta(gold(500)).

/* RESET STATS */
resetStat:-
    retractall(job(_)),
    retractall(exp(_)),
    retractall(expFish(_)),
    retractall(expFarm(_)),
    retractall(expRanch(_)),
    retractall(level(_)),
    retractall(levelFish(_)),
    retractall(levelFarm(_)),
    retractall(levelRanch(_)),
    retractall(stamina(_)),
    retractall(gold(_)).

/* STATUS */
status:-
    job(Job),
    level(Level),
    levelFish(LevelFish),
    expFish(ExpFish),
    levelFarm(LevelFarm),
    expFarm(ExpFarm),
    levelRanch(LevelRanch),
    expRanch(ExpRanch),
    exp(Exp),
    stamina(Stamina),
    gold(Gold),
    % Print
    write('~Your Status~\n-------------------------\n'),
    format('Job      : ~w\n', [Job]),
    format('Level    : ~d (~d/100)\n', [Level, Exp]),
    format('Fishing  : ~d (~d/100)\n', [LevelFish, ExpFish]),
    format('Farming  : ~d (~d/100)\n', [LevelFarm, ExpFarm]),
    format('Ranching : ~d (~d/100)\n', [LevelRanch, ExpRanch]),
    format('Stamina  : ~d/100\n', [Stamina]),
    format('Gold     : ~d\n', [Gold]).