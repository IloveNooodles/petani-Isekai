/* DYNAMICS */
:- dynamic(state/1).
/* FROM STARTGAME.PL
:- dynamic(job/1).
   % exp(type: [general, fish, farm, ranch], value) 
:- dynamic(exp/2). 
   % level(type: [general, fish, farm, ranch], value)
:- dynamic(level/2).
:- dynamic(stamina/1).
:- dynamic(maxStamina/1).
:- dynamic(gold/1).
:- dynamic(playerName/1).
*/

/* INCLUDES */
:- include('startGame.pl'). % startGame, start, setPlayerName(X), setStat(X), levelOne, resetStat, status
:- include('help.pl'). % help
:- include('time.pl').
:- include('level.pl'). % config facts, maxedOut, newLevel, levelUpMessage
:- include('map.pl').
:- include('house.pl').
:- include('items.pl').
:- include('inventory.pl').
:- include('fishing.pl').
:- include('farming.pl'). % dig, plant, harvest, checkRipe(X,Y), and other functions.

/* SPECIALS */
:- include('kappa.pl').

/* EXIT */
exit:-
    write('Thank you for playing, see you later!\n'),
    halt.

/* SISTEM STAMINA */
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
% newLevel(X) ada di level.pl
earnExp(Type, ExpPlus):-
    /* Menambah exp player sebanyak ExpPlus 
    dan naik level bila exp cukup */
    level(Type, Level),
    exp(Type, Exp),
    ExpNew is Exp + ExpPlus,
    newLevel(Type, ExpNew),
    % Tulis pesan level up
    levelUpMessage(Type, Level).

/* GOLD */
earnGold(X):- 
    gold(Current),
    retractall(gold(_)),
    New is Current + X,
    asserta(gold(New)).

goldCollected:-
  gold(Current),
  Current >= 20000,
  retractall(endGame(_)),
  asserta(endGame(true)),
  retractall(gameCompleted(_)),
  asserta(gameCompleted(true)),
  endgame.

/* RANDOM EVENT */
randomGold(Minimum, Maximum, Chance):-
    random(0, 100, Result),
    ((
        % dapat
        Result =< Chance,
        random(Minimum, Maximum, Gold),
        earnGold(Gold),
        format('WHOA!! You found ~d gold!', [Gold]),
        !
    );(
        % tidak dapat
        Result > Chance,
        !
    )).    
