naikLevel(2, 100).
naikLevel(3, 150).
naikLevel(4, 200).
naikLevel(5, 250).
naikLevel(6, 300).
naikLevel(7, 350).
naikLevel(8, 400).
naikLevel(9, 450).
naikLevel(10, 500).
naikLevel(11, 0).
maxLevel(10).

maxedOut:-
    level(Level),
    maxLevel(Max),
    Level >= Max.

newLevel:-
    maxedOut,
    !.

/* EARN EXP */
newLevel(ExpCurrent):-
    level(Level),
    Next is Level+1,
    naikLevel(Next, NextExp),
    ExpCurrent < NextExp,
    retractall(exp(_)),
    asserta(exp(ExpCurrent)),
    !.

/* LEVEL UP */
newLevel(ExpCurrent):-
    level(Level),
    Next is Level+1,
    naikLevel(Next, NextExp),
    ExpCurrent >= NextExp,
    Exp is ExpCurrent - NextExp,
    retractall(level(_)),
    asserta(level(Next)),
    ((maxedOut,
    retractall(exp(_)),
    asserta(exp(0))
    );
    (\+maxedOut,
    retractall(exp(_)),
    asserta(exp(Exp)),
    newLevel(Exp)
    )),
    !.

/* LEVEL UP MESSAGE */
levelUpMessage(Level):-
    level(New),
    Level = New,
    !.

levelUpMessage(Level):-
    level(New),
    Level < New,
    write('Level Up!!!\n'),
    !.