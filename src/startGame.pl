/* TO DO */

/* DYNAMICS */
:- dynamic(day/1).
:- dynamic(time/1).
:- dynamic(weather/1).
:- dynamic(season/1).
:- dynamic(endGame/1).
:- dynamic(gameCompleted/1).
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
    asserta(endGame(false)),
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
    playerName(Name),
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
    format('~w\'s stats\n-------------------------\n', [Name]),
    format('Job      : ~w\n', [Job]),
    format('Level    : ~d (~d/~d exp)\n', [Level, Exp, NextExp]),
    format('Fishing  : ~d (~d/~d exp)\n', [LevelFish, ExpFish, NextExpFish]),
    format('Farming  : ~d (~d/~d exp)\n', [LevelFarm, ExpFarm, NextExpFarm]),
    format('Ranching : ~d (~d/~d exp)\n', [LevelRanch, ExpRanch, NextExpRanch]),
    format('Stamina  : ~d/~d\n', [Stamina, MaxStamina]),
    format('Gold     : ~d\n', [Gold]),
    !.
  
/* Time and Season */
startDay:-
  asserta(day(1)).

/* dicek kalo lebih dari 365 end game nya jadi true */
/* harus di cek kalo day nya udah masuk season baru sm randomize weather */

nextDay:-
  day(X),
  X >= 365,
  retractall(endGame(_)),
  asserta(endGame(true)).

nextDay:-
  day(X),
  X < 365,
  Y is X + 1,
  retractall(day(_)),
  asserta(day(Y)).

setDay(Day):-
  retractall(day(_)),
  asserta(day(Day)).

/* anggap mulai 1 Maret beres 28 Februari, biar gampang musimnya */
/* tergantung mau mulai dari musim kaya gimana */
/* ini gw masukinnya dari belahan utara ya berarti 4 season */
/* 1 Maret - 31 Mei - Semi */
/* 1 Juni - 31 Agustus - Panas */
/* 1 September - 30 November - Gugur */
/* 1 Desember - 28 Februari - Dingin */


startSeason:-
  asserta(season(semi)).

%setSeason(Season):-

/* tergantung mau mulai dari cuaca kaya gimana */
/* cuaca harus bisa dirandom belom kepikiran */
/* Buat musim semi: panas, ujan jarang bgt, angin*/
/* Buat musim panas: panas, ujan, angin */
/* Buat musim Gugur: panas, ujan, angin, daun jatuh2 gatau namanya apa */
/* Buat musim Dingin: snow, cold, freeze */

startWeather:-
  asserta(weather(panas)).

%setWeather()

/* bisa aja tambahin status effect kaya kalo dingin gimana kalo panas gimana */
