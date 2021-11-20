/* DYNAMICS */
:- dynamic(state/1).
/* FROM STARTGAME.PL
:- dynamic(job/1).
:- dynamic(exp/1).
:- dynamic(expFish/1).
:- dynamic(expFarm/1).
:- dynamic(expRanch/1).
:- dynamic(level/1).
:- dynamic(levelFish/1).
:- dynamic(levelFarm/1).
:- dynamic(levelRanch/1).
:- dynamic(stamina/1).
:- dynamic(gold/1).
*/

/* INCLUDES */
:- include('startGame.pl'). %startGame, start, setStat(X), levelOne, resetStat, status
:- include('map.pl').

/* START GAME */
lesgo :-
    asserta(player_name(charlie)),
    write('Siapa namamu, calon petani?\n'),
    read(Name),
    retractall(player_name(_)),
    setPlayerName(Name),
    fill_map.