availItems(energyDrink).
availItems(kopiCampur).
availItems(susuSegar).
availItems(milkshake).
availItems(crisbar).
availItems(steak).
availItems(appleSeed).
availItems(cucumberSeed).
availItems(garlicSeed).
availItems(pumpkinSeed).
availItems(sunflowerSeed).
availItems(tomatoSeed).
availItems(wheatSeed).
availItems(fertilizer).
availItems(chicken).
availItems(sheep).
availItems(cow).
availItems(chickenFeed).
availItems(sheepFeed).
availItems(cowFeed).
availItems(bait).
availItems(goodBait).
availItems(shear).
availItems(fishingRod).

market:-
    \+ playerName(_), !,
  write('Game has not started yet!\n').

market:-
  \+ loc_tile(market),
  !,
  write('You are not at the Market tile!\n').

market:-
  write('Welcome to marketplace\n'),
  write('What do you want to do?\n'),
  write('1. buy\n'),
  write('2. sell\n'),
  read(Input),
  processInputMarket(Input).

processInputMarket(X):-
  X = buy,
  buy.

processInputMarket(X):-
  X = sell,
  sell.

processInputMarket(_):-
  write('Please input the correct option!\n'),
  write('1. buy\n'),
  write('2. sell\n'),
  read(Input),
  processInputMarket(Input).

readCategory:-
  category,
  read(Category),
  \+ listCategory(Category),
  write('Please input the correct category!\n'),
  readCategory.

readCategory:-
  category,
  read(Category),
  listCategory(Category).

category:-
  write('Choose the category\nn'),
  write('1. consumables\n'),
  write('2. farming\n'),
  write('3. ranching\n'),
  write('4. fishing\n'),
  write('5. tools\n').

listCategory(consumables):-
  write('------- Consumables ------\n'),
  write('1. energyDrink - 250G\n'),
  write('2. kopiCampur - 100G\n'),
  write('3. susuSegar - 150G\n'),
  write('4. milkshake - 300G\n'),
  write('5. crisbar - 500G\n'),
  write('6. steak - 1000G\n').

listCategory(fishing):-
  write('------- Fishing ------\n'),
  write('1. bait - 250G\n'),
  write('2. goodBait - 350G\n').

listCategory(farming):-
  write('------- Farming ------\n'),
  write('1. appleSeed - 50G\n'),
  write('2. cucumberSeed - 100G\n'),
  write('3. garlicSeed - 75G\n'),
  write('4. pumkinSeed - 50G\n'),
  write('5. sunflowerSeed - 25G\n'),
  write('6. tomatoSeed - 75G\n'),
  write('7. wheatSeed - 50G\n'),
  write('8. Fertilizer - 500G\n').

listCategory(ranching):-
  write('------- Ranching ------\n'),
  write('1. chicken - 50G\n'),
  write('2. sheep - 100G\n'),
  write('3. cow - 75G\n').

listCategory(tools):-
  write('------- tools ------\n'),
  write('Select the tools that you wanna level up!\n')
  write('1. shear - 1500G\n'),
  write('2. shovel - 1000G\n'),
  write('3. fishingRod - 1000G\n').

buy:-
  readCategory,
  read(Items), 
  availItems(Items),
  gold(Current)
  checkGold(Items, Current),
  hasMoney(M), M = true,
  itemPrice(Items, Price),
  NewGold is Current - Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  addInven(X).

/*
sell :-
  write('What')  adit */ 