/* The great kappa will rise when a user throws a cucumber to the lake when it is rainy at exactly 12 A.M. */

/* Behold, here comes the kappa */
loc_tile(lake_edge).
weather(hujan).
time(0).

callKappa:-
    loc_tile(lake_edge),
    weather(hujan),
    time(0),
    kappaEmerge,
    !.

callKappa:- !.

kappaEmerge:-
    kappaAnimate(0),
    shell('clear'),
    sleep(0.25),
    write('You have summoned the great Kappa.'), nl,
    sleep(1),
    random(1, 3, Action),
    action(Action).

/* ACTIONS */
/* Refer to footnote */

action(1):-
    write('But he is in a bad mood.'), nl.

action(2):-
    write('He loves you.'), nl.

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

/* Footnote: Kappa legends
(src: https://en.wikipedia.org/wiki/Kappa_(folklore))

Defeating the kappa

It was believed that there were a few means of escape if one was confronted with a kappa. Kappa are obsessed with politeness, so if a person makes a deep bow, it will return the gesture. This results in the kappa spilling the water held in the "dish" (sara) on its head, rendering it unable to leave the bowing position until the plate is refilled with water from the river in which it lives. If a person refills it, the kappa will serve that person for all eternity. A similar weakness of the kappa involves its arms, which can easily be pulled from its body. If an arm is detached, the kappa will perform favors or share knowledge in exchange for its return.[24]

Another method of defeat involves shogi or sumo wrestling: a kappa sometimes challenges a human being to wrestle or engage in other tests of skill.[25] This tendency is easily used to encourage the kappa to spill the water from its sara. One notable example of this method is the folktale of a farmer who promises his daughter's hand in marriage to a kappa in return for the creature irrigating his land. The farmer's daughter challenges the kappa to submerge several gourds in water. When the kappa fails in its task, it retreats, saving the farmer's daughter from the marriage.[16] Kappa have also been driven away by their aversion to iron, sesame, or ginger.[26]

Good deeds

Kappa are not entirely antagonistic to human beings.

Once befriended, kappa may perform any number of tasks for human beings, such as helping farmers irrigate their land. Sometimes, they bring fresh fish, which is regarded as a mark of good fortune for the family that receives it.[24] They are also highly knowledgeable about medicine, and legend states that they taught the art of bone setting to human beings.[14][27][28] There are also legends that Kappa will save a friendly human from drowning. */