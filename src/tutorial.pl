/* TUTORIAL */
% 1. status
% 2. inventory
% 3. map
% 4. farming
% 5. ranching
% 6. fishing
% 7. market
% 8. house
% 9. quest

:- dynamic(tutorial/1).

tutorial(0).

setTutorial(X):-
    retractall(tutorial(_)),
    asserta(tutorial(X)).

checkTutorial(X):-
    tutorial(Tutorial),
    X = Tutorial,
    tutorialStep(X),
    !.

checkTutorial(_):- !.

checkTutorialRipe:-
    tutorial(Tutorial),
    Tutorial = 9,
    setTutorial(8).

checkTutorialRipe:- !.

tutorial:-
    write('\n-------------------------------------------------------------------------------------------------------------\n\n'),
    write('TUTORIAL\n'),
    write('Your goal is to collect 20,000 gold by the end of the year.\n'),
    write('Let\'s see how much you have now!\n'),
    write('To check your status, type \'status.\'\n'),
    setTutorial(1).

tutorialStep(1):-
    % status
    write('\nCongratulations! You have learnt to check your status.\n'),
    write('Next, try to check your inventory to see what you own.\n'),
    write('Type \'inventory.\'\n'),
    addInven(tutorialItem),
    setTutorial(2).

tutorialStep(2):-
    % inventory
    write('\nLook at that! You own a starter pack based on your chosen job.\n'),
    write('Your inventory can only hold 100 items, so you might need to throw away some items later.\n'),
    write('You can do this by typing \'throwItem.\'\n'),
    write('Try to throw away tutorialItem.\n'),
    setTutorial(3).

tutorialStep(3):-
    % throwItem
    write('\n\nYou have learnt how to throw away items.\n'),
    write('Next, we will learn how to get around town.\n'),
    write('Type \'map.\' to see where you are right now.\n'),
    setTutorial(4).

tutorialStep(4):-
    % map
    write('\nOkay, this is our map.\n'),
    write('P means player, which is where you are right now.\n'),
    write('Here is the complete legend of the map.\n'),
    write('>> P : Player\n'),
    write('>> M : Marketplace\n'),
    write('>> R : Ranch\n'),
    write('>> H : House\n'),
    write('>> Q : Quest\n'),
    write('>> o : Water (Lake)\n'),
    write('>> - : Dirt\n'),
    write('>> = : Digged tile\n'),
    write('>> # : Border\n'),
    write('To move you can use \'a.\', \'s.\', \'w.\', \'d.\'\n'),
    write('Moving from one tile to another takes 1 minute.\n'),
    write('Try to move to the marketplace.\n'),
    setTutorial(5).

tutorialStep(5):-
    % market
    write('\nThis is the marketplace.\n'),
    setTutorial(6).

tutorialStep(6):-
    % buy and sell
    write('aaaa'),
    setTutorial(7).

tutorialStep(7):-
    % farming (dig)
    write('\nGood job! Now that you have dug the tile, you can plant the seed you bought at the marketplace.\n'),
    write('Type \'plant.\' to start planting.\n'),
    setTutorial(8).

tutorialStep(8):-
    % farming (plant)
    write('\nYou need to wait for a few days before your crops can be harvested.\n'),
    write('To speed it up, you can use a fertilizer.\n'),
    addInven(fertilizer),
    write('Fertilizer speeds up your crops\' growth by two days and this effect can stack.\n'),
    write('This time, we have added a fertilizer to your inventory.\n'),
    write('Fertilizer can be bought in the marketplace.\n'),
    write('To use the fertilizer, type \'fertilize.\'\n'),
    setTutorial(9).

tutorialStep(9):-
    % farming (fertilize)
    write('\nGreat, now you can harvest your crops.\n'),
    write('Type \'harvest.\'\n'),
    setTutorial(10).

tutorialStep(10):-
    % farming (harvest)
    write('\nYay! You have harvested your first crop!\n'),
    write('All this work takes a lot of stamina and time, but gains you exp points.\n'),
    write('You can always check them in your status window.\n'),
    write('Next, we will try ranching.\n'),
    write('Check your map and head to the ranch (R)!\n'),
    setTutorial(11).

tutorialStep(11):-
    % ranching
    write('\nHere is the ranch.\n'),
    setTutorial(12).

tutorialStep(12):-
    % fishing
    write('\nYou can fish whenever you stand by a lake\n'),
    write('For the sake of tutorial, we have lent you a fishingRod and a bait,\n'),
    addInven(fishingRod),
    addInven(bait),
    write('but you will have to buy them yourself from the market if you are not a fisherman.\n'),
    write('To start fishing, type \'fish.\'\n'),
    setTutorial(13).

tutorialStep(13):-
    write('\nNice catch!\n'),
    ((job(fisherman),!); (job(_),throw(fishingRod, 1))),
    write('All the work has been tiring, hasn\'t it?\n'),
    write('When you run out of stamina, you will have to sleep to replenish it.\n'),
    write('Head over to your house (H)!\n'),
    setTutorial(14).