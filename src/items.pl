:- dynamic(item/3).

/* Item bakal ada ada 2 arity nama sama tipe */

/* Consumable */
/* ini bisa dimakan dan buat nambah stamina possibly, dan bakal ada restoran */
item(energyDrink, consumable).
item(kopiCampur, consumable).
item(susuSegar, consumable).
item(milkshake, consumable).
item(crisbar, consumable).
item(steak, consumable).


/* Farming */
item(padi, farming).
item(benihSurga, farming).
item(bibitMisterius, farming).
item(cocoaSeeds, farming).
item(cucumberSeeds, farming).
item(tomatoSeeds, farming).
item(carrotSeeds, farming).
item(coffeeSeeds, farming).
item(garlicSeeds, farming).
item(bijiKopi, farming).
item(carrot, farming).
item(cokelat, farming).
item(cucumber, farming).
item(tomato, farming).
item(garlic, farming).
item(bibitDunia, famring).
item(herb, farming).
item(fertilizer, famring).

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
item(chickenFeed, ranching).
item(sheepFeed, ranching).
item(cowFeed, ranching).

/* Fishing */
item(tuna, fishing).
item(salmon, fishing).
item(angler, fishing).
item(crimsonfish, fishing).
item(sunfish, fishing).
item(relicanth, fishing).
item(kingfish, fishing).
item(mutant, fishing).
item(lobster, fishing).
item(sardine, fishing).
item(catfish, fishing).
item(octopus, fishing).
item(eel, fishing).
item(seacucumber, fishing).
item(ghostfish, fishing).
item(stonefish, fishing).
item(sashimi, fishing).
item(sushi, fishing).
item(bait, fishing).
item(goodBait, fishing).
item(greatestBait, fishing).

/* Tools */
/* Buat bagian tools ini bakal ada nama, tipe, sama level */
asserta(item(shovel, tools, 1)).
asserta(item(shear, tools, 1)).
asserta(item(fishingRod, tools, 1)).
asserta(item(wateringcan, tools, 1)).
asserta(item(catchingNet, tools, 1)).

/* Item price bakal ada 2 arity isinya <nama, harga> possibly ini bisa dipake buat beli/jual */
/* Kayaknya bakal dibedain sama waktu panennya aja sih */
itemPrice(energyDrink, 250).
itemPrice(kopiCampur, 100).
itemPrice(susuSegar, 150).
itemPrice(milkshake, 300).
itemPrice(crisbar, 500).
itemPrice(steak, 1000).
itemPrice(padi, 50).
itemPrice(benihSurga, 5000).
itemPrice(bibitMisterius, 0).
itemPrice(cocoaSeeds, 100).
itemPrice(cucumberSeeds, 50).
itemPrice(tomatoSeeds, 75).
itemPrice(carrotSeeds, 75).
itemPrice(garlicSeeds, 75).
itemPrice(coffeeSeeds, 100).
itemPrice(bijiKopi, 300).
itemPrice(carrot, 250).
itemPrice(cokelat, 300).
itemPrice(cucumber, 200).
itemPrice(tomato, 200).
itemPrice(garlic, 250).
itemPrice(bibitDunia, 2500).
itemPrice(herb, 100).
itemPrice(fertilizer, 250).
itemPrice(chicken, 1000).
itemPrice(goldenChicken, 2000).
itemPrice(sheep, 1500).
itemPrice(pinkSheep, 3000).
itemPrice(cow, 2500).
itemPrice(cowWagyu, 5000).
itemPrice(wool, 400).
itemPrice(egg, 350).
itemPrice(goldenEgg, 700).
itemPrice(milk, 500).
itemPrice(chickenMeat, 800).
itemPrice(sheepMeat, 800).
itemPrice(cowRib, 900).
itemPrice(cowLoin, 900).
itemPrice(cowBrisket, 800).
itemPrice(chickenFeed, 250).
itemPrice(sheepFeed, 300).
itemPrice(cowFeed, 300).
itemPrice(tuna, 500).
itemPrice(salmon, 800).
itemPrice(angler, 1500).
itemPrice(crimsonfish, 1500).
itemPrice(sunfish, 1500).
itemPrice(relicanth, 2000).
itemPrice(kingfish, 1000).
itemPrice(mutant, 1000).
itemPrice(lobster, 1000).
itemPrice(sardine, 500).
itemPrice(catfish, 600).
itemPrice(octopus, 650).
itemPrice(eel, 550).
itemPrice(seacucumber, 600).
itemPrice(ghostfish, 900).
itemPrice(stonefish, 600).
itemPrice(sashimi, 400).
itemPrice(sushi, 400).
itemPrice(bait, 250).
itemPrice(goodBait, 350).
itemPrice(greatestBait, 500).
itemPrice(shovel, 1000).
itemPrice(shear, 1500).
itemPrice(fishingRod, 1000).
itemPrice(wateringcan, 1000).
itemPrice(catchingNet, 1000).

/* item effect */
/* nama item, apa yang berubah, jumlah perubahan */

/* consumables */
itemEffect(kopiCampur, stamina, 5).
itemEffect(energyDrink, stamina, 10).
itemEffect(susuSegar, stamina, 30).
itemEffect(milkshake, stamina, 50).
itemEffect(crisbar, stamina, 70).
itemEffect(steak, stamina, 100).

/* farming + shovel + wateringcan*/
itemEffect(padi, exp, 2).
itemEffect(benihSurga, exp, 50).
itemEffect(bibitMisterius, exp, 500).
itemEffect(cocoaSeeds, exp, 5).
itemEffect(cucumberSeeds, exp, 3).
itemEffect(tomatoSeeds, exp, 3).
itemEffect(carrotSeeds, exp, 3).
itemEffect(coffeeSeeds, exp, 5).
itemEffect(garlicSeeds, exp, 3).

/* fishing  yang punya efek cuma fishing rod sm catching net*/
itemEffect(bait, exp, 5).
itemEffect(goodBait, exp, 20).
itemEffect(greatestBait, exp, 50).

/* ranching */
itemEffect(chickenFeed, exp, 20).
itemEffect(cowFeed, exp, 20).
itemEffect(sheepFeed, exp, 20).

levelUpItem(ToolsName):-
  item(ToolsName, tools, Level), ! , Newlevel is Level + 1, retractall(item(_,_,_)), asserta(ToolsName, tools, Newlevel).

use(ItemName):-
  item(ItemName, Category), Category = consumable, !, efek

use(ItemName):-
  item(ItemName, Category), Category = farming, !, efek

use(ItemName):-
  item(ItemName, Category), Category = ranching, !, efek

use(ItemName):-
  item(ItemName, Category), Category = fishing, !, efek

use(ItemName):-
  item(ItemName, Category), Category = tools, !, efek

