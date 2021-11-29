/* CHEATS FOR DEMO */

cheatLevelUp:-
    earnExp(general, 300).

cheatInventoryFull:-
    addInven(crisbar, 96).

cheatGameFail:-
    setDay(364),
    nextDay.

cheatGameSuccess:-
    earnGold(20000).

cheatAlchemist:-
    retractall(hasAlchemist(_)),
    asserta(hasAlchemist(true)),
    retractall(player(_,_)),
    asserta(player(4, 18)).

cheatKappa:-
    addInven(cucumber),
    retractall(weather(_)),
    asserta(weather(hujan)),
    setTime(18,0),
    retractall(player(_,_)),
    asserta(player(10,10)).

cheatPeriTidur:-
    loc_tile(X), !, X = home,
    printSleep,
    write('You had a good sleep.\n\n'),
    sleep(0.75),
    doneAlchemist,
    nextDay,
    dream(50),
    status.