/* CONFIG */
% General
naikLevel(2, 100, general).
naikLevel(3, 150, general).
naikLevel(4, 200, general).
naikLevel(5, 250, general).
naikLevel(6, 300, general).
naikLevel(7, 350, general).
naikLevel(8, 400, general).
naikLevel(9, 450, general).
naikLevel(10, 500, general).
naikLevel(11, 0, general).

% Fish
naikLevel(2, 100, fish).
naikLevel(3, 150, fish).
naikLevel(4, 200, fish).
naikLevel(5, 250, fish).
naikLevel(6, 300, fish).
naikLevel(7, 350, fish).
naikLevel(8, 400, fish).
naikLevel(9, 450, fish).
naikLevel(10, 500, fish).
naikLevel(11, 0, fish).

% Farm
naikLevel(2, 100, farm).
naikLevel(3, 150, farm).
naikLevel(4, 200, farm).
naikLevel(5, 250, farm).
naikLevel(6, 300, farm).
naikLevel(7, 350, farm).
naikLevel(8, 400, farm).
naikLevel(9, 450, farm).
naikLevel(10, 500, farm).
naikLevel(11, 0, farm).

% Ranch
naikLevel(2, 100, ranch).
naikLevel(3, 150, ranch).
naikLevel(4, 200, ranch).
naikLevel(5, 250, ranch).
naikLevel(6, 300, ranch).
naikLevel(7, 350, ranch).
naikLevel(8, 400, ranch).
naikLevel(9, 450, ranch).
naikLevel(10, 500, ranch).
naikLevel(11, 0, ranch).

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
    Next is Level+1,
    naikLevel(Next, NextExp, Type),
    ExpCurrent < NextExp,
    retractall(exp(Type, _)),
    asserta(exp(Type, ExpCurrent)),
    !.

/* LEVEL UP */
newLevel(Type, ExpCurrent):-
    level(Type, Level),
    Next is Level+1,
    naikLevel(Next, NextExp, Type),
    ExpCurrent >= NextExp,
    Exp is ExpCurrent - NextExp,
    retractall(level(Type, _)),
    asserta(level(Type, Next)),
    ((maxedOut,
    retractall(exp(Type, _)),
    asserta(exp(Type, 0))
    );
    (\+maxedOut,
    retractall(exp(Type, _)),
    asserta(exp(Type, Exp)),
    newLevel(Type, Exp)
    )),
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