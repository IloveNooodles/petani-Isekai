/* The great kappa will rise when a user throws a cucumber to the lake when it is rainy at exactly 12 A.M. */

/* Behold, here comes the kappa */
callKappa(Cucumber):-
    Cucumber = cucumber,
    loc_tile(lake_edge),
    weather(hujan),
    time(H, _),
    H >= 18,
    H =< 23,
    kappaEmerge,
    !.

callKappa(_):- !.

kappaEmerge:-
    kappaAnimate(0),
    shell('clear'),
    sleep(0.25),
    write('You have summoned the great Kappa.'), nl,
    sleep(1),
    random(1, 4, Action),
    actionKappa(Action).

/* ACTIONS */
/* Refer to footnote */

actionKappa(1):-
    /* Blessings of the good harvest */
    ripenAll,
    write('He looks at your crop, blesses them, and goes back to his deep slumber.\nCheck your crops!'),
    !.

actionKappa(2):-
    /* Bounty of the sea */
    addInven(tuna, 3),
    addInven(sardine, 2),
    addInven(eel, 1),
    write('Surfacing from the lake, he brings you a bounty of fish.\nCheck your inventory!\n'),
    !.

actionKappa(3):-
    /* Hostile kappa */
    write('You see that the kappa is hostile. What do you do? (1-3)\n1. Bow\n2. Fight\n3. Run\n> '),
    read(Action),
    hostile(Action).

hostile(1):-
    write('The kappa bows back and spills the water on its sara, making him weak.\nYou leave unharmed.\n').

hostile(2):-
    write('You try to fight the kappa. Where do you attack? (1-3)\n1. Head\n2. Body\n3. Arm\n> '),
    read(Action),
    fight(Action).

hostile(3):-
    write('You run away. The kappa catches up to you and attacks you. You died.\n'),
    endgame.

fight(1):-
    write('You attack his head, spilling the water in its sara, making him weak.\nYou leave unharmed.\n').

fight(2):-
    write('You attack his body. You are too weak to tackle him. You died.\n'),
    endgame.

fight(3):-
    write('You detach his arms and he will do anything to get it back. What will you ask? (1-2)\n1. Good harvest\n2. A bounty of fish\n> '),
    read(Action),
    actionKappa(Action).

/* ANIMATION */
kappaAnimate(11):-
    !.

kappaAnimate(I):-
    shell('clear'),
    Frame is (I mod 2),
    kappa(Frame),
    writeCucumber(I),
    sleep(0.75),
    Next is I + 1,
    kappaAnimate(Next).

/* ANIMATION FRAMES */
kappa(0):- 
    write('                __'), nl,
    write('     .,-;-;-,. /\'_\\'), nl,
    write('   _/_/_/_|_\\_\\) /'), nl,
    write(' \'-<_><_><_><_>=/\\'), nl,
    write('   `/_/====/_/-\'\\_\\'), nl,
    write('    ""     ""    ""'), nl,
    !.

kappa(1):-
    write('                __'), nl,
    write('     .,-;-;-,. /\'_\\'), nl,
    write('   _/_/_/_|_\\_\\) /'), nl,
    write(' \'-<_><_><_><_>=/\\'), nl,
    write('   `\\_\\====\\_\\-/_/'), nl,
    write('     ""     "" ""'), nl,
    !.

writeCucumber(0):-
    write('C'), nl, !.

writeCucumber(1):-
    write('C U'), nl, !.

writeCucumber(2):-
    write('C U C'), nl, !.

writeCucumber(3):-
    write('C U C U'), nl, !.

writeCucumber(4):-
    write('C U C U M'), nl, !.

writeCucumber(5):-
    write('C U C U M B'), nl, !.

writeCucumber(6):-
    write('C U C U M B E'), nl, !.

writeCucumber(7):-
    write('C U C U M B E R'), nl, !.

writeCucumber(8):-
    write('C U C U M B E R .'), nl, !.

writeCucumber(9):-
    write('C U C U M B E R . . '), nl, !.

writeCucumber(10):-
    write('C U C U M B E R . . .'), nl, !.

/* CHEAT */
kappaConfig:-
    addInven(cucumber),
    retractall(weather(_)),
    asserta(weather(hujan)),
    setTime(18,0).

/* Footnote: Kappa legends
(src: https://en.wikipedia.org/wiki/Kappa_(folklore) )

Defeating the kappa

It was believed that there were a few means of escape if one was confronted with a kappa. Kappa are obsessed with politeness, so if a person makes a deep bow, it will return the gesture. This results in the kappa spilling the water held in the "dish" (sara) on its head, rendering it unable to leave the bowing position until the plate is refilled with water from the river in which it lives. If a person refills it, the kappa will serve that person for all eternity. A similar weakness of the kappa involves its arms, which can easily be pulled from its body. If an arm is detached, the kappa will perform favors or share knowledge in exchange for its return.[24]

Another method of defeat involves shogi or sumo wrestling: a kappa sometimes challenges a human being to wrestle or engage in other tests of skill.[25] This tendency is easily used to encourage the kappa to spill the water from its sara. One notable example of this method is the folktale of a farmer who promises his daughter's hand in marriage to a kappa in return for the creature irrigating his land. The farmer's daughter challenges the kappa to submerge several gourds in water. When the kappa fails in its task, it retreats, saving the farmer's daughter from the marriage.[16] Kappa have also been driven away by their aversion to iron, sesame, or ginger.[26]

Good deeds

Kappa are not entirely antagonistic to human beings.

Once befriended, kappa may perform any number of tasks for human beings, such as helping farmers irrigate their land. Sometimes, they bring fresh fish, which is regarded as a mark of good fortune for the family that receives it.[24] They are also highly knowledgeable about medicine, and legend states that they taught the art of bone setting to human beings.[14][27][28] There are also legends that Kappa will save a friendly human from drowning. */