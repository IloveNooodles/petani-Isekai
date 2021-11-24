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
    write('You digged the tile.\n'),
    randomGold(1,20,10).

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
    % display inventory farm
    inventoryFarm,
    write('What do you want to plant?\n> '),
    read(Seed),
    % check input validity
    \+seedUnavail(Seed),
    % plant if valid
    plantTile(X, Y, Seed),
    throw(Seed, 1),
    minStamina(Smin),
    format('You planted a ~w.\n', [Seed]).

notDiggedTile:-
    \+loc_tile(digged),
    write('Do some digging first!\n').

seedUnavail(Seed):-
    \+isXinInven(Seed),
    write('Whoops, seems like you don\'t have that seed.').
    
plantTile(X, Y, Seed):-
    day(CurrDay),
    item(Seed, farming, Ripe),
    RipeDay is CurrDay + Ripe,
    asserta(planted_coordinate(X, Y, Seed, RipeDay)).

/* RIPEN */
checkRipe(X, Y):-
    \+planted_coordinate(X,Y,_,_),
    !.

checkRipe(X, Y):-
    planted_coordinate(X, Y, _, RipeDay),
    day(CurrDay),
    CurrDay < RipeDay,
    !.

checkRipe(X, Y):-
    planted_coordinate(X, Y, Seed, RipeDay),
    day(CurrDay),
    CurrDay >= RipeDay,
    retract(planted_coordinate(X, Y, Seed, RipeDay)),
    asserta(ripe_coordinate(X, Y, Seed)),
    !.

/* HARVEST */
harvest:- 
    loc_tile(ripe),
    player(X, Y),
    ripe_coordinate(X, Y, Seed),
    retract(ripe_coordinate(X, Y, Seed)),
    atom_concat(Seed, 'Ripe', SeedRipe),
    addInven(SeedRipe),
    format('You harvested ~w.\n', [Seed]).