/* SISTEM EXP FARMING */
digExp(10).
plantExp(15).
harvestExp(50).
fertilizeExp(10).

/* SISTEM STAMINA FARMING */
digStamina(10).
plantStamina(1).
harvestStamina(5).
fertilizeStamina(2).

/* SISTEM TIME FARMING */
digTime(30).
plantTime(10).
harvestTime(10).
fertilizeTime(15).

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
    time(H, M),
    digTime(PlusTime),
    addTime(H, M, PlusTime, HNew, MNew),
    setTime(HNew, MNew),
    write('You digged the tile.\n'),
    randomGold(1,20,15).

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
    % has seed
    \+hasNoSeed,
    % display inventory seed
    inventorySeed,
    write('What do you want to plant?\n> '),
    read(Seed),
    % check input validity
    \+seedUnavail(Seed),
    % plant if valid
    plantTile(X, Y, Seed),
    throw(Seed, 1),
    plantExp(Exp),
    earnExp(farm, Exp),
    earnExp(general, Exp),
    minStamina(Smin),
    time(H, M),
    plantTime(PlusTime),
    addTime(H, M, PlusTime, HNew, MNew),
    setTime(HNew, MNew),
    format('You planted ~w.\n', [Seed]).

notDiggedTile:-
    \+loc_tile(digged),
    write('Do some digging first!\n').

hasSeed:-
    seed(X, _), 
    isXinInven(X).

hasNoSeed:-
    \+hasSeed,
    write('You do not own any seed.\n').

seedUnavail(Seed):-
    \+isXinInven(Seed),
    \+seed(Seed, _),
    write('Whoops, seems like you don\'t have that seed.').
    
plantTile(X, Y, Seed):-
    day(CurrDay),
    seed(Seed, Ripe),
    RipeDay is CurrDay + Ripe,
    asserta(planted_coordinate(X, Y, Seed, RipeDay)),
    retractall(loc_tile(dirt)),
    asserta(loc_tile(planted)).

/* RIPEN */
checkRipe:-
    forall(planted_coordinate(X, Y, _, _),
        checkRipe(X, Y)).

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

ripenAll:-
    forall(planted_coordinate(X, Y, Seed, _),
        asserta(ripe_coordinate(X, Y, Seed))),
    retractall(planted_coordinate(_, _, _, _)).

/* HARVEST */
harvest:- 
    \+notYetRipe,
    loc_tile(ripe),
    % stamina >= plantStamina
    harvestStamina(Smin),
    \+(staminaLessThan(Smin)),
    player(X, Y),
    ripe_coordinate(X, Y, Seed),
    retract(ripe_coordinate(X, Y, Seed)),
    sub_atom(Seed, 0, _, 4, SeedRipe),
    addInven(SeedRipe),
    harvestExp(Exp),
    earnExp(farm, Exp),
    earnExp(general, Exp),
    minStamina(Smin),
    time(H, M),
    harvestTime(PlusTime),
    addTime(H, M, PlusTime, HNew, MNew),
    setTime(HNew, MNew),
    format('You harvested ~w.\n', [SeedRipe]).

notYetRipe:-
    loc_tile(planted),
    write('Your crop is not ready to be harvested.\n').

/* FERTILIZE */
noFertilizer:-
    \+isXinInven(fertilizer),
    write('You do not own a fertilizer.\n'),
    !.

fertilize:-
    loc_tile(planted),
    \+noFertilizer,
    fertilizeStamina(Smin),
    \+(staminaLessThan(Smin)),
    player(X, Y),
    throw(fertilizer, 1),
    fertilizeExp(Exp),
    earnExp(farm, Exp),
    earnExp(general, Exp),
    minStamina(Smin),
    time(H, M),
    digTime(PlusTime),
    addTime(H, M, PlusTime, HNew, MNew),
    setTime(HNew, MNew),
    calculateNewRipeDay(X, Y),
    !.

calculateNewRipeDay(X, Y):-
    planted_coordinate(X, Y, Seed, RipeDay),
    day(CurrDay),
    NewRipe is RipeDay - 2,
    CurrDay < NewRipe,
    retractall(planted_coordinate(X, Y, Seed, RipeDay)),
    asserta(planted_coordinate(X, Y, Seed, NewRipe)),
    sub_atom(Seed, 0, _, 4, Name),
    format('Nice. You can harvest your ~w 2 days faster!\n', [Name]),
    !.

calculateNewRipeDay(X, Y):-
    planted_coordinate(X, Y, Seed, RipeDay),
    day(CurrDay),
    NewRipe is RipeDay - 2,
    CurrDay >= NewRipe,
    retractall(planted_coordinate(X, Y, Seed, RipeDay)),
    asserta(ripe_coordinate(X, Y, Seed)),
    retractall(loc_tile(planted)),
    asserta(loc_tile(ripe)),
    sub_atom(Seed, 0, _, 4, Name),
    format('Great! Your ~w is ripe!\n', [Name]),
    !.

/* SEEDS */
% seed(SeedName, RipeTime).
seed(appleSeed, 5).
seed(mysteriousSeed, 10).
seed(cucumberSeed, 7).
seed(garlicSeed, 7).
seed(pumpkinSeed, 5).
seed(sunflowerSeed, 1).
seed(tomatoSeed, 3).
seed(wheatSeed, 3).