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
:- include('startGame.pl'). %startGame, start, setPlayerName(X), setStat(X), levelOne, resetStat, status
:- include('map.pl').
:- include('items.pl').
:- include('farming.pl').

/* SISTEM STAMINA */
% Max stamina = 100

minStamina(Smin):-
    /* Mengurangi stamina player sebanyak Smin */
    stamina(S),
    retractall(stamina(_)),
    Snew is S - Smin,
    asserta(stamina(Snew)).

staminaLessThan(Sminimum):-
    /* Mereturn true bila stamina kurang dari Sminimum dan
    menampilkan pesan stamina kurang */
    stamina(S),
    S < Sminimum,
    write('Uh-oh, too little stamina to continue. Time to sleep.\n').

/* SISTEM EXP */


earnExp(ExpPlus):-
    /* Menambah exp player sebanyak ExpPlus */
    exp(Exp),
    retractall(exp(_)),
    ExpNew is Exp + ExpPlus,
    asserta(exp(ExpNew)).

earnExpFish(ExpPlus):-
    /* Menambah exp player sebanyak ExpPlus */
    expFish(Exp),
    retractall(expFish(_)),
    ExpNew is Exp + ExpPlus,
    asserta(expFish(ExpNew)).

earnExpFarm(ExpPlus):-
    /* Menambah exp player sebanyak ExpPlus */
    expFarm(Exp),
    retractall(expFarm(_)),
    ExpNew is Exp + ExpPlus,
    asserta(expFarm(ExpNew)).

earnExpRanch(ExpPlus):-
    /* Menambah exp player sebanyak ExpPlus */
    expRanch(Exp),
    retractall(expRanch(_)),
    ExpNew is Exp + ExpPlus,
    asserta(expRanch(ExpNew)).

/* START GAME */
lesgo :-
    asserta(player_name(charlie)),
    write('Siapa namamu, calon petani?\n'),
    read(Name),
    retractall(player_name(_)),
    setPlayerName(Name),
    fill_map.

