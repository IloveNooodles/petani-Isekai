/* CONFIG */
% General
naikLevel(1, 300, general).
naikLevel(2, 450, general).
naikLevel(3, 600, general).
naikLevel(4, 750, general).
naikLevel(5, 900, general).
naikLevel(6, 1050, general).
naikLevel(7, 1200, general).
naikLevel(8, 1350, general).
naikLevel(9, 1500, general).
naikLevel(10, 0, general).

% Fish
naikLevel(1, 100, fish).
naikLevel(2, 150, fish).
naikLevel(3, 200, fish).
naikLevel(4, 250, fish).
naikLevel(5, 300, fish).
naikLevel(6, 350, fish).
naikLevel(7, 400, fish).
naikLevel(8, 450, fish).
naikLevel(9, 500, fish).
naikLevel(10, 0, fish).

% Farm
naikLevel(1, 100, farm).
naikLevel(2, 150, farm).
naikLevel(3, 200, farm).
naikLevel(4, 250, farm).
naikLevel(5, 300, farm).
naikLevel(6, 350, farm).
naikLevel(7, 400, farm).
naikLevel(8, 450, farm).
naikLevel(9, 500, farm).
naikLevel(10, 0, farm).

% Ranch
naikLevel(1, 100, ranch).
naikLevel(2, 150, ranch).
naikLevel(3, 200, ranch).
naikLevel(4, 250, ranch).
naikLevel(5, 300, ranch).
naikLevel(6, 350, ranch).
naikLevel(7, 400, ranch).
naikLevel(8, 450, ranch).
naikLevel(9, 500, ranch).
naikLevel(10, 0, ranch).

maxLevel(general, 10).
maxLevel(fish, 10).
maxLevel(farm, 10).
maxLevel(ranch, 10).

maxedOut(Type):-
    level(Type, Level),
    maxLevel(Type, Max),
    Level >= Max.

newLevel(Type,_):-
    maxedOut(Type),
    !.

/* EARN EXP */
newLevel(Type, ExpCurrent):-
    level(Type, Level),
    naikLevel(Level, NextExp, Type),
    ExpCurrent < NextExp,
    retractall(exp(Type, _)),
    asserta(exp(Type, ExpCurrent)),
    !.

/* LEVEL UP */
newLevel(Type, ExpCurrent):-
    level(Type, Level),
    Next is Level+1,
    naikLevel(Level, NextExp, Type),
    ExpCurrent >= NextExp,
    Exp is ExpCurrent - NextExp,
    retractall(level(Type, _)),
    asserta(level(Type, Next)),
    ((maxedOut(Type),
    retractall(exp(Type, _)),
    asserta(exp(Type, 0))
    );
    (\+maxedOut(Type),
    retractall(exp(Type, _)),
    asserta(exp(Type, Exp)),
    newLevel(Type, Exp)
    )),
    staminaUp(Type),
    !.

/* LEVEL UP MESSAGE */
levelUpMessage(Type, Level):-
    level(Type, New),
    Level = New,
    !.

levelUpMessage(Type, Level):-
    level(Type, New),
    Level < New,
    write('Level Up!!!\n'),
    !.

/* STAMINA UP */
staminaUp(general):- 
    maxStamina(CurrStamina),
    New is CurrStamina + 50,
    retractall(maxStamina(_)),
    asserta(maxStamina(New)),
    !.

staminaUp(_):-
    !.