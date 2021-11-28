:- dynamic(item/3).
:- dynamic(hasMoney/1).

/* Item bakal ada ada 2 arity nama sama tipe */
hasMoney(false).

/* Consumable */
/* ini bisa dimakan dan buat nambah stamina possibly, dan bakal ada restoran */
item(energyDrink, consumable).
item(kopiCampur, consumable).
item(susuSegar, consumable).
item(milkshake, consumable).
item(crisbar, consumable).
item(steak, consumable).
item(potion, consumable).

/* Farming */
item(appleSeed, farming).
item(mysteriousSeed, farming).
item(cucumberSeed, farming).
item(garlicSeed, farming).
item(pumpkinSeed, farming).
item(sunflowerSeed, farming).
item(tomatoSeed, farming).
item(wheatSeed, farming).
item(apple, farming).
item(mysterious, farming).
item(pumpkin, farming).
item(sunflower, farming).
item(wheat, farming).
item(carrot, farming).
item(cokelat, farming).
item(cucumber, farming).
item(tomato, farming).
item(garlic, farming).
item(herb, farming).
item(fertilizer, farming).

/* Ranching */
item(chicken, ranching).
item(goldenChicken, ranching).
item(cow, ranching).
item(cowWagyu, ranching).
item(sheep, ranching).
item(pinkSheep, ranching).
item(wool, ranching).
item(egg, ranching).
item(goldenEgg, ranching).
item(milk, ranching).
item(chickenMeat, ranching).
item(sheepMeat, ranching).
item(cowRib, ranching).
item(cowLoin, ranching).
item(cowBrisket, ranching).
item(ranchFood, ranching).

/* Fishing */
item(tuna, fishing).
item(salmon, fishing).
item(angler, fishing).
item(rareEel, fishing).
item(crimsonfish, fishing).
item(sunfish, fishing).
item(relicanth, fishing).
item(kingfish, fishing).
item(mutant, fishing).
item(rareMutant, fishing).
item(lobster, fishing).
item(sardine, fishing).
item(catfish, fishing).
item(octopus, fishing).
item(eel, fishing).
item(seacucumber, fishing).
item(ghostfish, fishing).
item(rareGhostfish, fishing).
item(stonefish, fishing).
item(rareStonefish, fishing).
item(sashimi, fishing).
item(sushi, fishing).
item(bait, fishing).
item(goodBait, fishing).
item(greatestBait, fishing).

/* Tools */
/* Buat bagian tools ini bakal ada nama, tipe, sama level */
item(shear, tools, 1).
item(fishingRod, tools, 1).

/* Item price bakal ada 2 arity isinya <nama, harga> possibly ini bisa dipake buat beli/jual */
/* Kayaknya bakal dibedain sama waktu panennya aja sih */

/* Wizard */
itemPrice(mysteriousSeed, 100).
itemPrice(greatestBait, 500).
itemPrice(potion, 2000).
itemPrice(goldenChicken, 2000).
itemPrice(pinkSheep, 3000).
itemPrice(cowWagyu, 5000).
itemPrice(oldBook, 1000).

/* harga item biasa */
itemPrice(energyDrink, 250).
itemPrice(kopiCampur, 100).
itemPrice(susuSegar, 150).
itemPrice(milkshake, 300).
itemPrice(crisbar, 500).
itemPrice(steak, 1000).
itemPrice(appleSeed, 50).
itemPrice(cucumberSeed, 50).
itemPrice(garlicSeed, 75).
itemPrice(pumpkinSeed, 50).
itemPrice(sunflowerSeed, 25).
itemPrice(tomatoSeed, 75).
itemPrice(wheatSeed, 50).
itemPrice(apple, 200).
itemPrice(pumpkin, 300).
itemPrice(sunflower, 100).
itemPrice(wheat, 250).
itemPrice(carrot, 250).
itemPrice(cokelat, 300).
itemPrice(cucumber, 200).
itemPrice(tomato, 200).
itemPrice(garlic, 250).
itemPrice(herb, 100).
itemPrice(fertilizer, 500).
itemPrice(chicken, 1000).
itemPrice(sheep, 1500).
itemPrice(cow, 2500).
itemPrice(wool, 400).
itemPrice(egg, 350).
itemPrice(goldenEgg, 700).
itemPrice(milk, 500).
itemPrice(chickenMeat, 800).
itemPrice(sheepMeat, 800).
itemPrice(cowRib, 900).
itemPrice(cowLoin, 900).
itemPrice(cowBrisket, 800).
itemPrice(ranchFood, 350).
itemPrice(tuna, 500).
itemPrice(salmon, 800).
itemPrice(angler, 1500).
itemPrice(rareEEl, 700).
itemPrice(crimsonfish, 1500).
itemPrice(sunfish, 1500).
itemPrice(relicanth, 2000).
itemPrice(kingfish, 1000).
itemPrice(mutant, 1000).
itemPrice(rareMutant, 1400).
itemPrice(lobster, 1000).
itemPrice(sardine, 500).
itemPrice(catfish, 600).
itemPrice(octopus, 650).
itemPrice(eel, 550).
itemPrice(seacucumber, 600).
itemPrice(ghostfish, 900).
itemPrice(rareGhostfish, 1100).
itemPrice(stonefish, 600).
itemPrice(rareStonefish, 800).
itemPrice(sashimi, 400).
itemPrice(sushi, 400).
itemPrice(bait, 250).
itemPrice(goodBait, 350).
itemPrice(shovel, 1000).
itemPrice(shear, 1500).
itemPrice(fishingRod, 1000).

/* consumables */
itemEffect(kopiCampur, stamina, 5).
itemEffect(energyDrink, stamina, 10).
itemEffect(susuSegar, stamina, 30).
itemEffect(milkshake, stamina, 50).
itemEffect(crisbar, stamina, 70).
itemEffect(steak, stamina, 100).
itemEffect(potion, exp, 1000).

levelUpItem(ToolsName):-
  item(ToolsName, tools, Level), ! , Newlevel is Level + 1, retractall(item(_,_,_)), asserta(item(ToolsName, tools, Newlevel)).

checkGold(X, CurrentGold):-
  itemPrice(X, Y),
  CurrentGold < Y, !,
  retractall(hasMoney(_)),  asserta(hasMoney(false)),
  write('You don\'t have that much money!\n').

checkGold(X, CurrentGold):-
  itemPrice(X, Y),
  CurrentGold >= Y, !,
  retractall(hasMoney(_)), asserta(hasMoney(true)),
  format('Thank you for buying ~w!', [X]).

/* Buat consume */
% Buat apply item effect
applyEffect(exp, Value) :-
  !,
  earnExp(general, Value),
  format('Kamu mendapatkan ~d exp!!\n', [Value]).

applyEffect(stamina, Value) :- % kasus nambahnya lebih dari max
  stamina(ST),
  maxStamina(Max),
  NewST is ST + Value,
  NewST > Max,
  retractall(stamina(_)),
  asserta(stamina(Max)),
  !,
  format('Stamina kamu bertambah sebanyak ~d!!\n', [Value]).

applyEffect(stamina, Value) :- % kasus nambahnya normal
  stamina(ST),
  NewST is ST + Value,
  retractall(stamina(_)),
  asserta(stamina(NewST)),
  !,
  format('Stamina kamu bertambah sebanyak ~d!!\n', [Value]).

% Buat memakai consumable
use(Item, 1) :-
  inventory(List, Cap),
  retractall(inventory(_,_)),
  NewCap is Cap - 1,
  deleteValinList(Item, List, ListOut),
  itemEffect(Item, Stat, Value),
  applyEffect(Stat, Value),
  asserta(inventory(ListOut, NewCap)), !,
  updateInvenOne(Item).

use(Item, Count) :-
  inventory(List, _),
  countXinInven(Item, List, Res),
  Count > Res,
  !,
  write('Jumlahnya kelebihan!!\n').

use(Item, Count) :-
  inventory(List, Cap),
  retractall(inventory(_,_)),
  NewCap is Cap - 1,
  deleteValinList(Item, List, ListOut),
  itemEffect(Item, Stat, Value),
  applyEffect(Stat, Value),
  asserta(inventory(ListOut, NewCap)), 
  !,
  NewCount is Count - 1,
  use(Item, NewCount).

% Buat ngecek ada consumable ato engga
checkConsuminInven([H|_], true) :-
  item(H, consumable), !.

checkConsuminInven([H], false) :-
  \+ item(H, consumable), !.

checkConsuminInven([H|T], Bool) :-
  \+ item(H, consumable), !,
  checkConsuminInven(T, Bool).

consume :-
  inventory(_, Count),
  Count = 0,
  !,
  write('Kamu ngga punya consumable!!\n').

consume :-
  inventoryOneItem(List),
  checkConsuminInven(List, false),
  !,
  write('Kamu ngga punya consumable!!\n').

consume :-
  inventory(List, _),
  checkConsuminInven(List, true),
  inventoryConsum,
  write('Consumable apa yang akan kamu consume?\n> '),
  read(Item),
  ((
  countXinInven(Item, List, Count),
  Count =:= 0,
  write('Kamu ngga punya consumable itu!!\n')
  );
  (
  countXinInven(Item, List, Count),
  Count > 0,
  format('Kamu punya ~d ~w! Berapa yang ingin kamu consume?\n> ', [Count, Item]),
  read(Amount),
  use(Item, Amount)
  )),
  !.