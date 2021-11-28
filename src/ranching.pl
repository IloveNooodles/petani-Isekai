:- dynamic(animalQuantity/2).

% animal(jenis, indeks, dayleft).
:- dynamic(animal/3).

% setup jumlah animal di awal
animalQuantity(total, 0).
animalQuantity(chicken, 0).
animalQuantity(goldenChicken, 0).
animalQuantity(cow, 0).
animalQuantity(cowWagyu, 0).
animalQuantity(sheep, 0).
animalQuantity(pinkSheep, 0).

% mengurangi stamina
reduceST(Cost) :-
    stamina(ST),
    NewST is ST - Cost,
    retractall(stamina(_)),
    asserta(stamina(NewST)).

% menambah animal
addAnimal(Animal) :-
    animalQuantity(Animal,Qty),
    Qty1 is Qty+1,
    animalQuantity(total, QtyTotal),
    QtyTotal1 is QtyTotal+1,
    retractall(animalQuantity(Animal,_)),
    assertz(animalQuantity(Animal,Qty1)),
    retractall(animalQuantity(total,_)),
    assertz(animalQuantity(total,QtyTotal1)),

    % initialize new animals with day -1
    assertz(animal(Animal, Qty1, -1)).

% mengurang animal, base case 0 animal
removeAnimal(Animal, Cond) :-
    animalQuantity(Animal,0),
    !,
    Cond = false,
    format('There are no more ~w.\n',[Animal]).

% ada animal yang bisa dikurangi
removeAnimal(Animal, Cond) :-
    !,
    Cond = true,
    animalQuantity(Animal,Qty),
    Qty1 is Qty-1,
    animalQuantity(total, QtyTotal),
    QtyTotal1 is QtyTotal-1,
    retractall(animalQuantity(Animal,_)),
    assertz(animalQuantity(Animal,Qty1)),
    retractall(animalQuantity(total,_)),
    assertz(animalQuantity(total,QtyTotal1)),

    % remove animal
    retractall(animal(Animal, Qty, _)),
    format('\nSo long, ~w :(\n',[Animal]).

% update animal untuk esok hari
updateDayRanch :-
    forall(animal(Animal,Index,Time), (Time > 0, Time1 is Time - 1, retract(animal(Animal,Index,Time)), assertz(animal(Animal,Index,Time1));true)).

% update satu animal dengan ranchFood menjadi 0 day
updateDayOne(Animal) :-
    animal(Animal, Index, Time),
    (Time > 0; Time < 0),
    retract(animal(Animal,Index,Time)),
    assertz(animal(Animal,Index,0)),
    !.

% to print eggs from chicken
printChicken(0) :-
    !,
    write('Your chickens have not produced any eggs.\n').

printChicken(X) :-
    !,
    format('Your chicken lays ~w eggs.\n', [X]),
    format('You got ~w eggs!\n', [X]).

% to print golden eggs from golden chicken
printGChicken(0) :-
    animalQuantity(goldenChicken, Qty),
    Qty > 0,
    !,
    write('Your golden chickens have not produced any golden eggs.\n').
    
printGChicken(X) :-
    animalQuantity(goldenChicken, Qty),
    Qty > 0,
    !,
    format('Your golden chicken lays ~w golden eggs.\n', [X]),
    format('You got ~w golden eggs!\n', [X]).

% to print wool from sheep and pink sheep
printSheep(0) :-
    !,
    write('Your sheep have not grown any wool.\n').
    
printSheep(X) :-
    !,
    format('Your sheep have produced ~w wool.\n', [X]),
    format('You got ~w wool!\n', [X]).

% to print wool from sheep and pink sheep
printCow(0) :-
    !,
    write('Your cows have not produced any milk.\n').
    
printCow(X) :-
    !,
    format('Your cows have produced ~w milk.\n', [X]),
    format('You got ~w milk!\n', [X]).

% to print check later and give EXP for chicken
chickenEXP(0, 0) :-
    !,
    write('\nPlease check again later.\n').
    
chickenEXP(X, Y) :-
    !,
    level(ranch, Multiplier),
    RanEXP is (X*2+Y*3)*Multiplier,
    level(general, Multiplier1),
    GenEXP is (X*2+Y*3)*Multiplier1,
    format('\nYou gained ~w EXP and ~w ranching EXP!\n', [GenEXP, RanEXP]),
    earnExp(ranch, RanEXP),
    earnExp(general, GenEXP).

% to print check later and give EXP for others
ranchEXP(0) :-
    !,
    write('\nPlease check again later.\n').
    
ranchEXP(X) :-
    !,
    level(ranch, Multiplier),
    RanEXP is (X*5)*Multiplier,
    level(general, Multiplier1),
    GenEXP is (X*5)*Multiplier1,
    format('\nYou gained ~w EXP and ~w ranching EXP!\n', [GenEXP, RanEXP]),
    earnExp(ranch, RanEXP),
    earnExp(general, GenEXP).

% int div to help with set wait
intdivTwo(X, Y) :-
    Y is X//2.

% set wait time for chicken
chickenTime(Y) :-
    level(ranch, Lev),
    intdivTwo(Lev, LevDiv),
    Y is 8-LevDiv.

% set wait time for golden chicken
goldenChickenTime(Y) :-
    level(ranch, Lev),
    intdivTwo(Lev, LevDiv),
    Y is 11-LevDiv.

% set wait time for sheep
sheepTime(Y) :-
    level(ranch, Lev),
    intdivTwo(Lev, LevDiv),
    Y is 9-LevDiv.

% set wait time for pink sheep
pinkSheepTime(Y) :-
    level(ranch, Lev),
    intdivTwo(Lev, LevDiv),
    Y is 12-LevDiv.

% set wait time for sheep
cowTime(Y) :-
    level(ranch, Lev),
    intdivTwo(Lev, LevDiv),
    Y is 10-LevDiv.

% set wait time for pink sheep
cowWagyuTime(Y) :-
    level(ranch, Lev),
    intdivTwo(Lev, LevDiv),
    Y is 14-LevDiv.

% what you get for killing an animal
loot(chicken) :-
    addInven(chickenMeat),
    write('Hmm, you\'ve got some chicken meat.\n').

loot(goldenChicken) :-
    addInven(chickenMeat, 3),
    write('Hmm, more special golden chicken meat.\n').

loot(sheep) :-
    addInven(sheepMeat),
    write('Hmm, you\'ve got some sheep meat.\n').

loot(pinkSheep) :-
    addInven(sheepMeat, 4),
    write('Hmm, you\'ve got more special pink sheep meat.\n').

loot(cow) :-
    addInven(cowRib),
    addInven(cowLoin),
    write('Yum, yum. Some cow ribs and loins.\n').

loot(cowWagyu) :-
    addInven(cowRib, 2),
    addInven(cowLoin, 2),
    addInven(cowBrisket, 3),
    write('Yum, yum. Some more special wagyu ribs and loins.\n').

% get meat, if false does not get meat
getsomeloot(_, false) :- !.

% if true get some meat
getsomeloot(Animal, true) :-
    !,
    loot(Animal).

% display list of animals
displayAnimal :-
    forall(animalQuantity(Animal,Qty), ((Qty>0, Animal\==total, format('- ~w ~w\n', [Qty, Animal]));true)), !.
% Command ranching
ranch:-
      \+ playerName(_), !,
    write('Game has not started yet!\n').

% kasus tidak di ranch
ranch :- 
    \+ loc_tile(ranch),
    !,
    write('You are currently not at the ranch!\n').

% kasus di ranch tidak ada animal
ranch :-
    loc_tile(ranch),
    animalQuantity(total, 0),
    !,
    write('Welcome to the ranch!\n'),
    write('You currently have no animals, get some at the market!\n'),
    checkTutorial(12).

% kasus di ranch ada animal
ranch :-
    loc_tile(ranch),
    animalQuantity(total, QtyTotal),
    !,
    QtyTotal > 0,
    write('Welcome to the ranch! You have:\n'),
    displayAnimal,
    write('\nWhat do you want to do?\n').

% Command chicken
chicken:-
      \+ playerName(_), !,
    write('Game has not started yet!\n').

% kasus tidak di ranch
chicken :- 
    \+ loc_tile(ranch),
    !,
    write('You are currently not at the ranch!\n').

% kasus kurang stamina
chicken :-
    loc_tile(ranch),
    stamina(ST),
    ST < 5,
    !,
    write('You don\'t have enough stamina!\n').

% kasus di ranch tidak ada chicken
chicken :-
    loc_tile(ranch),
    animalQuantity(chicken, 0),
    animalQuantity(goldenChicken, 0),
    !,
    write('You have no chickens!\n').

% kasus ada chicken
chicken :-
    inventory(List, _),
    countXinInven(egg, List, Countegg),
    forall(animal(chicken,_,0), (addInven(egg))),
    chickenTime(CTime),
    forall(animal(chicken,Indeks,Time), ((Time =< 0, retract(animal(chicken,Indeks,Time)), assertz(animal(chicken,Indeks,CTime)));true)),
    inventory(List1, _),
    countXinInven(egg, List1, Countegg1),
    DiffEgg is Countegg1-Countegg,
    printChicken(DiffEgg),

    inventory(List2, _),
    countXinInven(goldenEgg, List2, CountGegg),
    forall(animal(goldenChicken,_,0), (addInven(goldenEgg))),
    goldenChickenTime(GCTime),
    forall(animal(goldenChicken,Indeks1,Time1), ((Time1 =< 0, retract(animal(goldenChicken,Indeks1,Time1)), assertz(animal(goldenChicken,Indeks1,GCTime)));true)),
    inventory(List3, _),
    countXinInven(goldenEgg, List3, CountGegg1),
    DiffGEgg is CountGegg1-CountGegg,
    printGChicken(DiffGEgg),
    reduceST(5),

    chickenEXP(DiffEgg, DiffGEgg).

% Command sheep
sheep:-
      \+ playerName(_), !,
    write('Game has not started yet!\n').

% kasus tidak di ranch
sheep :- 
    \+ loc_tile(ranch),
    !,
    write('You are currently not at the ranch!\n').

% kasus kurang stamina
sheep :-
    loc_tile(ranch),
    stamina(ST),
    ST < 6,
    !,
    write('You don\'t have enough stamina!\n').

% kasus di ranch tidak ada sheep
sheep :-
    loc_tile(ranch),
    animalQuantity(sheep, 0),
    animalQuantity(pinkSheep, 0),
    !,
    write('You have no sheep!\n').

% kasus ada sheep
sheep :-
    inventory(List, _),
    countXinInven(wool, List, Countwool),
    forall(animal(sheep,_,0), (addInven(wool))),
    sheepTime(STime),
    forall(animal(sheep,Indeks,Time), ((Time =< 0, retract(animal(sheep,Indeks,Time)), assertz(animal(sheep,Indeks,STime)));true)),
    forall(animal(pinkSheep,_,0), (addInven(wool, 3))),
    pinkSheepTime(PSTime),
    forall(animal(pinkSheep,Indeks1,Time1), ((Time1 =< 0, retract(animal(pinkSheep,Indeks1,Time1)), assertz(animal(pinkSheep,Indeks1,PSTime)));true)),
    inventory(List1, _),
    countXinInven(wool, List1, Countwool1),
    Diffwool is Countwool1-Countwool,
    printSheep(Diffwool),
    reduceST(6),

    ranchEXP(Diffwool).

% Command cow
cow:-
      \+ playerName(_), !,
    write('Game has not started yet!\n').

% kasus tidak di ranch
cow :- 
    \+ loc_tile(ranch),
    !,
    write('You are currently not at the ranch!\n').

% kasus kurang stamina
cow :-
    loc_tile(ranch),
    stamina(ST),
    ST < 7,
    !,
    write('You don\'t have enough stamina!\n').

% kasus di ranch tidak ada cow
cow :-
    loc_tile(ranch),
    animalQuantity(cow, 0),
    animalQuantity(cowWagyu, 0),
    !,
    write('You have no cows!\n').

% kasus ada cow
cow :-
    inventory(List, _),
    countXinInven(milk, List, Countmilk),
    forall(animal(cow,_,0), (addInven(milk))),
    cowTime(COTime),
    forall(animal(cow,Indeks,Time), ((Time =< 0, retract(animal(cow,Indeks,Time)), assertz(animal(cow,Indeks,COTime)));true)),
    forall(animal(cowWagyu,_,0), (addInven(milk, 4))),
    cowWagyuTime(COWTime),
    forall(animal(cowWagyu,Indeks1,Time1), ((Time1 =< 0, retract(animal(cowWagyu,Indeks1,Time1)), assertz(animal(cowWagyu,Indeks1,COWTime)));true)),
    inventory(List1, _),
    countXinInven(milk, List1, Countmilk1),
    Diffmilk is Countmilk1-Countmilk,
    printCow(Diffmilk),
    reduceST(7),

    ranchEXP(Diffmilk).

% Command kill
kill:-
    \+ playerName(_), !,
    write('Game has not started yet!\n').

% kasus tidak di ranch
kill :- 
    \+ loc_tile(ranch),
    !,
    write('You are currently not at the ranch!\n').

% kasus kurang stamina
kill :-
    loc_tile(ranch),
    stamina(ST),
    ST < 9,
    !,
    write('You don\'t have enough stamina!\n').

% kasus di ranch tidak ada animal
kill :-
    loc_tile(ranch),
    animalQuantity(total, 0),
    !,
    write('You have no animals!\n').

% kasus ada animal
kill :-
    loc_tile(ranch),
    animalQuantity(total, QtyTotal),
    !,
    QtyTotal > 0,
    write('So you have decided to kill off one of your animals to get some juicy meat, ey?\n'),
    write('Well here are your selections:\n'),
    displayAnimal,
    write('\nWhich animal do you choose to do the sacrifice?\n'),
    reduceST(9),
    read(Input),
    removeAnimal(Input, Removed),
    getsomeloot(Input, Removed).

giveRF(Animal, 1) :-
    updateDayOne(Animal),
    !.

giveRF(Animal, X) :-
    updateDayOne(Animal),
    X1 is X-1,
    giveRF(Animal, X1).

% give ranchFood to 
countRF(CountInv, _, _, CountUsed) :-
    CountUsed > CountInv,
    !,
    format('\nInvalid! You only have ~w ranchFood.\n',[CountInv]).

countRF(_, AnimalQty, Animal, CountUsed) :-
    CountUsed > AnimalQty,
    !,
    format('\nInvalid! You only have ~w ~w to give ranchFood to.\n',[AnimalQty, Animal]).

countRF(_, _, Animal, CountUsed) :-
    !,
    giveRF(Animal, CountUsed),
    reduceST(1),
    format('\nCongrats, you\'ve given ~w ranchFood to your ~w.\n',[CountUsed, Animal]).

% fungsi pembantu givefood
givemefood(0) :-
    !,
    write('You have no ranchFood to feed your animals!\n').

givemefood(Count) :-
    Count > 0,
    !,
    format('You have ~w ranchFood!\n',[Count]),
    displayAnimal,
    write('\nWhich animals do you choose to give the ranchFood?\n'),
    read(Input),
    animalQuantity(Input,Qty),
    format('How much ranchFood would you like to use to feed your ~w?\n',[Input]),
    read(CountUsed),
    countRF(Count, Qty, Input, CountUsed).

% Command givefood
givefood :-
    \+ playerName(_), !,
    write('Game has not started yet!\n').

% kasus tidak di ranch
givefood :- 
    \+ loc_tile(ranch),
    !,
    write('You are currently not at the ranch!\n').

% kasus kurang stamina
givefood :-
    loc_tile(ranch),
    stamina(ST),
    ST < 1,
    !,
    write('You don\'t have enough stamina!\n').

% kasus di ranch tidak ada animal
givefood :-
    loc_tile(ranch),
    animalQuantity(total, 0),
    !,
    write('You have no animals!\n').

givefood :-
    loc_tile(ranch),
    animalQuantity(total, QtyTotal),
    !,
    QtyTotal > 0,
    inventory(List, _),
    countXinInven(ranchFood, List, CountRF),
    givemefood(CountRF).
