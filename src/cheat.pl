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