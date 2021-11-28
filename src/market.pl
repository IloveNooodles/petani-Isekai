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
availItems(ranchFood).
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
  write('3. exit\n> '),
  read(Input),
  processInputMarket(Input).

% BUAT PROSES BUY SELL ATO EXIT

processInputMarket(X):-
  X = buy,
  buy.

processInputMarket(X):-
  X = sell,
  sell.

processInputMarket(exit):- !.

processInputMarket(_):-
  write('Please input the correct option!\n'),
  write('1. buy\n'),
  write('2. sell\n'),
  write('3. exit\n> '),
  read(Input),
  processInputMarket(Input).

% BUAT KATEGORI

category:-
  write('Choose the category\n'),
  write('1. consumable\n'),
  write('2. farming\n'),
  write('3. ranching\n'),
  write('4. fishing\n'),
  write('5. tools\n> ').

listCategory(consumable):- 
  write('------- Consumable ------\n'),
  write('1. energyDrink - 250G\n'),
  write('2. kopiCampur - 100G\n'),
  write('3. susuSegar - 150G\n'),
  write('4. milkshake - 300G\n'),
  write('5. crisbar - 500G\n'),
  write('6. steak - 1000G\n> ').

listCategory(fishing):- 
  write('------- Fishing ------\n'),
  write('1. bait - 250G\n'),
  write('2. goodBait - 350G\n'),
  write('3. fishingRod level 1 - 1000G\n'), !.

listCategory(farming):-
  write('------- Farming ------\n'),
  write('1. appleSeed - 50G\n'),
  write('2. cucumberSeed - 100G\n'),
  write('3. garlicSeed - 75G\n'),
  write('4. pumkinSeed - 50G\n'),
  write('5. sunflowerSeed - 25G\n'),
  write('6. tomatoSeed - 75G\n'),
  write('7. wheatSeed - 50G\n'),
  write('8. fertilizer - 250G\n> ').

listCategory(ranching):-
  write('------- Ranching ------\n'),
  write('1. chicken - 300G\n'),
  write('2. sheep - 800G\n'),
  write('3. cow - 1500G\n> ').

listCategory(tools):-
  item(fishingRod, tools, Level), !,
  write('------- tools ------\n'),
  write('Select the tools that you wanna level up!\n'),
  format('1. fishingRod level ~d - 1000G\n', [Level]), !.

% BUAT READ CATEOGORY

readCategory(Category):-
  listCategory(Category),
  write('What do you want to buy?\n> '),
  read(Items),
  buy(Category, Items).

readCategory(Category):-
  \+ listCategory(Category), 
  write('Please input the correct category!\n'), !,
  buy.

% proses buy sesuai item
processBuy(Items, Amount, ranching) :-
  addAnimal(Items, Amount).

processBuy(Items, 1, tools) :- % tools
  \+ isXinInven(Items), !,
  write('You don\'t have that item!\n'),
  itemPrice(Items, Price),
  retractall(gold(_)),
  asserta(gold(Price)).

processBuy(Items, 1, tools) :- % tools
  item(Items, tools, Level), !,
  NewLevel is Level + 1,
  format('You have upgraded your ~w! It is now level ~d', [Items, NewLevel]),
  levelUpItem(Items).

processBuy(Items, Amount, tools) :- % tools
  itemPrice(Items, Price),
  Amount > 1,
  gold(Gold),
  NewGold is Gold + (Amount - 1) * Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  retractall(item(fishingRod, tools, _)),
  asserta(item(fishingRod, tools, 1)),
  format('You can only upgrade 1 fishingRod! We\'re returning your ~d Gold\n', [NewGold]),
  item(Items, tools, Level), !,
  NewLevel is Level + 1,
  format('You have upgraded your ~w! It is now level ~d', [Items, NewLevel]),
  levelUpItem(Items).

processBuy(fishingRod, 1, _) :-
  retractall(item(fishingRod, tools, _)),
  asserta(item(fishingRod, tools, 1)),
  addInven(fishingRod).

processBuy(fishingRod, Amount, _) :- % beli fishingrod level 1 amount lebih dari 1
  itemPrice(fishingRod, Price),
  gold(Gold),
  Amount > 1,
  NewGold is Gold + (Amount - 1) * Price,
  retractall(gold(_)),
  asserta(gold(NewGold)),
  retractall(item(fishingRod, tools, _)),
  asserta(item(fishingRod, tools, 1)),
  format('You can only buy 1 fishingRod! We\'re returning your ~d Gold\n', [NewGold]),
  addInven(fishingRod).  

processBuy(Items, Amount, _) :- % selain ranch dan tools
  addInven(Items, Amount), !.

% kasus pertama engga ada itemnya, uangnya kurang, upgrade tools, beli item ranch

% uang kurang
buy(Category, Items) :-
  (item(Items, Category);item(Items, Category, _)),
  itemPrice(Items, Price),
  gold(CurGold),
  write('How many do you want to buy?\n> '),
  read(Amount),
  TotalPrice is Price * Amount,
  ((
    CurGold < TotalPrice,
    write('You dont\'t have enough money!!\n')
    )
    ;
  (
    CurGold >= TotalPrice,
    NewGold is CurGold - TotalPrice,
    retractall(gold(_)),
    asserta(gold(NewGold)),
    processBuy(Items, Amount, Category)
    )
  ).

buy(_, _) :-
  write('The item is not found in this category!\n').

buy:-
  \+ playerName(_), !,
  write('Game has not started yet!\n').

buy:-
  \+ loc_tile(market),
  !,
  write('You are not at the Market tile!\n').

buy:-
  category,
  write('> '),
  read(Category),
  readCategory(Category).
  % read(Items), 
  % availItems(Items),
  % gold(Current),
  % checkGold(Items, Current),
  % hasMoney(M), M = true,
  % itemPrice(Items, Price),
  % NewGold is Current - Price,
  % retractall(gold(_)),
  % asserta(gold(NewGold)),
  % addInven(Items),
  % checkTutorialMarket(Items).

checkTutorialMarket(sunflowerSeed):-
  checkTutorial(6).

checkTutorialMarket(_):- !.

sell:-
  \+ playerName(_), !,
  write('Game has not started yet!\n').

sell:-
  \+ loc_tile(market),
  !,
  write('You are not at the Market tile!\n').

sell :-
  inventory(_, Count),
  Count = 0,
  !,
  write('You don\'t have any item to sell!').

sell :-
  inventory,
  inventory(List, _Total),
  write('What item do you wanna sell?\n> '),
  read(Item),
  ((
  countXinInven(Item, List, Count),
  Count =:= 0,
  write('You don\'t have that item!\n')
  );
  (
  inventory(List, _Total),
  countXinInven(Item, List, Count),
  Count > 0,
  itemPrice(Item, Value),
  gold(Gold),
  format('You have ~d ~w! How many do you want to sell?\n> ', [Count, Item]),
  read(Amount),
  retractall(gold(_)),
  NewGold is (Gold + Value * Amount),
  asserta(gold(NewGold)),
  throw(Item, Amount)
  )),
  !.