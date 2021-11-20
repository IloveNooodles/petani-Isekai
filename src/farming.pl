/* TO DO */

/* SISTEM STAMINA FARMING */
digStamina(10).
plantStamina(1).
harvestStamina(5).

minStamina(Smin):-
    stamina(S),
    retract(stamina(_)),
    Snew is S - Smin,
    asserta(stamina(Snew)).

/* DIG */
% kasus stamina ga cukup
dig:-
    digStamina(Smin),
    stamina(S),
    S < Smin,
    write('Uh-oh, too little stamina to continue.\n'),
    !.

% kasus stamina cukup
dig:-
    digStamina(Smin),
    stamina(S),
    S >= Smin,
    minStamina(Smin),
    player(X, Y),
    loc_tile(dirt),
    digTile(X, Y),
    retract(loc_tile(_)),
    asserta(loc_tile(digged)),
    write('You digged the tile.\n').

digTile(X, Y):-
    asserta(digged_coordinate(X, Y)).

/* PLANT */
%plant:-
