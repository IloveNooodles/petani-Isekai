/* DYNAMIC */
/* DYNAMIC */
:- dynamic(hasAlchemist/1).
:- dynamic(hasGoldenChicken/1).
:- dynamic(hasPinkSheep/1).
:- dynamic(hasCowWagyu/1).

hasAlchemist(false).
hasGoldenChicken(false).
hasPinkSheep(false).
hasCowWagyu(false).

startAlchemist:-
  random(1, 1000, Number),
  Number < 10, retractall(hasAlchemist(_)), asserta(hasAlchemist(true)),
  write('An alchemist has appear in the city go check it and don\'t miss a chance!').

doneAlchemist:-
  hasAlchemist(X), X = true, retractall(hasAlchemist(_)), asserta(hasAlchemist(false)).

alchemist:-
  \+ playerName(_), !,
  write('Game has not started yet!\n').

alchemist:-
  loc_tile(X), !, X = wizard,
  shopAlchemist.

shopAlchemist:-
  write('I travel to many unknown place, searching for something that was never meant to be found!...\n'),
  write('While I\'m still here, you can check some items that i got from travelling...\n'),
  write('1. mysteriousSeed - 100G\n'),
  write('2. greatestBait - 500G\n'),
  write('3. potion - 2000G\n'),
  write('4. goldenChicken - 2000G\n'),
  write('5. pinkSheep - 3000G\n'),
  write('6. cowWagyu - 5000G\n\n'),
  read(X),
  buyAlchemist(X).

buyAlchemist(X):-
  checkInventory, isInventoryFull(X), !, X is true,
  write('Your bag is full!\n').

buyAlchemist(X):-
  X = mysteriousSeed,
  gold(Current), !, 
  checkGold(X, Current),
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  addInven(X).

buyAlchemist(X):-
  X = greatestBait,
  gold(Current), !, 
  checkGold(X, Current),
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  addInven(X).

buyAlchemist(X):-
  X = potion,
  gold(Current), !, 
  checkGold(X, Current),
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  addInven(X).

buyAlchemist(X):-
  X = goldenChicken,
  gold(Current), !, 
  checkGold(X, Current),
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  retractall(hasGoldenChicken(_)),
  asserta(hasGoldenChicken(true)),
  addInven(X).

buyAlchemist(X):-
  X = pinkSheep,
  gold(Current), !, 
  checkGold(X, Current),
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  retractall(hasPinkSheep(_)),
  asserta(hasPinkSheep(true)),
  addInven(X).

buyAlchemist(X):-
  X = cowWagyu,
  gold(Current), !, 
  checkGold(X, Current),
  itemPrice(X, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  retractall(hasCowWagyu(_)),
  asserta(hasCowWagyu(true)),
  addInven(X).