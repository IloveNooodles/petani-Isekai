/* The great kappa has a 50% chance of rising from the lake everytime you throw a cucumber in it */

/* Behold, here comes the kappa */
loc_tile(lake_edge).
kappaEmerge:-
    kappaAnimate(0),
    shell('clear'),
    sleep(0.25),
    write('You have summoned the great Kappa.'), nl,
    sleep(1),
    random(1, 3, Action),
    action(Action).

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
