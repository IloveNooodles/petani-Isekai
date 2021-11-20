/* TO DO */
% change items in plant
% validate user input when planting
% ripe system

/* SISTEM STAMINA FARMING */
digStamina(10).
plantStamina(1).
harvestStamina(5).

minStamina(Smin):-
    stamina(S),
    retract(stamina(_)),
    Snew is S - Smin,
    asserta(stamina(Snew)).

staminaLessThan(Sminimum):-
    stamina(S),
    S < Sminimum,
    write('Uh-oh, too little stamina to continue. Time to sleep.\n').

/* DIG */
dig:-
    player(X, Y),
    loc_tile(dirt),
    digTile(X, Y),
    retract(loc_tile(_)),
    asserta(loc_tile(digged)),
    digStamina(Smin),
    \+(staminaLessThan(Smin)),
    minStamina(Smin),
    write('You digged the tile.\n').

digTile(X, Y):-
    asserta(digged_coordinate(X, Y)).

/* PLANT */
plant:-
    /* Cek prekondisi */
    % loc_tile == digged
    player(X, Y),
    \+notDiggedTile,
    % stamina >= plantStamina
    plantStamina(Smin),
    \+(staminaLessThan(Smin)),
    % item(_, X) in inventory
    /* SEMENTARA */
    item(_,farming),
    write('You have:\n'),
    forall(item(Item, farming),
        format('- ~w\n', [Item])),
    write('What do you want to plant?\n> '),
    read(Seed),
    format('~w', [Seed]),
    plantTile(X, Y, Seed),
    minStamina(Smin).

notDiggedTile:-
    \+loc_tile(digged),
    write('Do some digging first!\n').
    
plantTile(X, Y, Seed):-
    asserta(planted_coordinate(X, Y, Seed)).

ripenTile(X, Y, Seed):-
    asserta(ripe_coordinate(X, Y, Seed)).