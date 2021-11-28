/* DYNAMIC */
/* DYNAMIC */
:- dynamic(hasAlchemist/1).
:- dynamic(hasGoldenChicken/1).
:- dynamic(hasPinkSheep/1).
:- dynamic(hasCowWagyu/1).

hasAlchemist(false).
hasGoldenChicken(0).
hasPinkSheep(0).
hasCowWagyu(0).

startAlchemist:-
  random(1, 1000, Number),
  Number < 10, !, retractall(hasAlchemist(_)), asserta(hasAlchemist(true)),
  write('An alchemist has appear in the city go check it and don\'t miss a chance!').

startAlchemist:-
  !, retractall(hasAlchemist(_)), asserta(hasAlchemist(false)).

doneAlchemist:-
  hasAlchemist(X), X = true, retractall(hasAlchemist(_)), asserta(hasAlchemist(false)).

wizard:-
  \+ playerName(_), !,
  write('Game has not started yet!\n').

wizard:-
  loc_tile(X), !, X = wizard,
  shopAlchemist.

shopAlchemist:-
  write('I travel to many unknown place, searching for something that was never meant to be found!...\n'),
  write('I read an old book in this town library, it said that this town has some mysterious being in the lake\n'),
  write('Some people have seen it only in rain, i wonder if that is true...\n'),
  write('Anyway while I\'m still here, you can check some wonderful items that i got from travelling...\n'),
  write('1. mysteriousSeed - 100G\n'),
  write('2. greatestBait - 500G\n'),
  write('3. potion - 2000G\n'),
  write('4. goldenChicken - 2000G\n'),
  write('5. pinkSheep - 3000G\n'),
  write('6. cowWagyu - 5000G\n'),
  write('write the name of the items that you wanna buy!\n\n> '),
  read(X),
  buyAlchemist(X).

buyAlchemist(X):-
  checkInventory, isInventoryFull(X), !, X is true,
  write('Your bag is full!\n').

buyAlchemist(X):-
  X = mysteriousSeed,
  gold(Current), !, 
  checkGold(X, Current),
  hasMoney(M), M = true,
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  addInven(X).

buyAlchemist(X):-
  X = greatestBait,
  gold(Current), !, 
  checkGold(X, Current),
  hasMoney(M), M = true,
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  addInven(X).

buyAlchemist(X):-
  X = potion,
  gold(Current), !, 
  checkGold(X, Current),
  hasMoney(M), M = true,
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  addInven(X).

buyAlchemist(X):-
  X = goldenChicken,
  gold(Current), !, 
  checkGold(X, Current),
  hasMoney(M), M = true,
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  hasGoldenChicken(Y),
  Z is Y + 1,
  retractall(hasGoldenChicken(_)),
  asserta(hasGoldenChicken(Z)),
  addInven(X).

buyAlchemist(X):-
  X = pinkSheep,
  gold(Current), !, 
  checkGold(X, Current),
  hasMoney(M), M = true,
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  hasPinkSheep(Y),
  Z is Y + 1,
  retractall(hasPinkSheep(_)),
  asserta(hasPinkSheep(Z)),
  addInven(X).

buyAlchemist(X):-
  X = cowWagyu,
  gold(Current), !, 
  checkGold(X, Current),
  hasMoney(M), M = true,
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  hasCowWagyu(Y),
  Z is Y + 1,
  retractall(hasCowWagyu(_)),
  asserta(hasCowWagyu(Z)),
  addInven(X).