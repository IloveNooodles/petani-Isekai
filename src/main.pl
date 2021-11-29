:- include('cheat.pl').

/* INCLUDES */
:- include('startGame.pl'). % startGame, start, setPlayerName(X), setStat(X), levelOne, resetStat, status
:- include('tutorial.pl'). % tutorial
:- include('help.pl'). % help
:- include('time.pl'). % setDay(X), nextDay, addTime(H, M, AddMinute, HNew, MNew), and other time-related functions
:- include('level.pl'). % config facts, maxedOut, newLevel, levelUpMessage
:- include('map.pl'). % map, a, s, w, d, and other map-related functions
:- include('house.pl'). % house, sleep, etc
:- include('items.pl'). % facts about items
:- include('inventory.pl'). % inventory, throwItem, etc
:- include('fishing.pl'). % fish
:- include('farming.pl'). % dig, plant, harvest, checkRipe(X,Y), and other functions.
:- include('ranching.pl'). % ranch, chicken, sheep, cow, etc
:- include('quest.pl'). % quest
:- include('market.pl'). % market, buy, sell

/* SPECIALS */
:- include('diary.pl').
:- include('alchemist.pl').
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
    asserta(gold(New)),
    goldCollected.

goldCollected:-
    gold(Current),
    Current >= 20000,
    retractall(endGame(_)),
    asserta(endGame(true)),
    retractall(gameCompleted(_)),
    asserta(gameCompleted(true)),
    endgame.
    
goldCollected:- !.

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
