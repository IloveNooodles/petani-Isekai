/* TO DO */
% change items in plant
% validate user input when planting
% ripe system

/* SISTEM EXP FARMING */
digExp(10).
plantExp(15).
harvestExp(50).

/* SISTEM STAMINA FARMING */
digStamina(10).
plantStamina(1).
harvestStamina(5).

/* DIG */
dig:-
    /* Cek prekondisi */
    % loc_tile == dirt
    player(X, Y),
    loc_tile(dirt),
    % stamina >= digStamina
    digStamina(Smin),
    \+(staminaLessThan(Smin)),
    digTile(X, Y),
    retract(loc_tile(_)),
    asserta(loc_tile(digged)),
    digExp(Exp),
    earnExp(farm, Exp),
    earnExp(general, Exp),
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

/* RIPEN */
ripenTile(X, Y, Seed):-
    asserta(ripe_coordinate(X, Y, Seed)).

/* HARVEST */
harvest:- 
    loc_tile(ripe),
    write('You harvested.').