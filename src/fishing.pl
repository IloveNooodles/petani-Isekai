/*
Buat fakta ikan ikan yg ada dengan format
ikan(nama, rarity, rarity tingkat 2)
misal:
ikan(blueTuna, 4, 3)
4 itu rarity general, jadi klo uda level 4 misal, dia selalu dapet rarity 4
rarity tingkat 2 nya itu kalo 3 paling mahal. Jadi ntar yang di random itu rarity tingkat 2

Alur:
fishing. cek dia di pinggir danau ato engga, trus cek bawa fishing rod ato engga, trus klo ada pilih bait, trus lgsg random
waktu random klo dapet 0 berarti ndak dapet apa apa
*/

ikan(tuna, 1, 1).
ikan(sardine, 1, 2).
ikan(eel, 1, 3).
ikan(rareEel, 1, 4).
ikan(catfish, 2, 1).
ikan(seacucumber, 2, 2).
ikan(stonefish, 2, 3).
ikan(rareStonefish, 2, 4).
ikan(octopus, 3, 1).
ikan(salmon, 3, 2).
ikan(ghostfish, 3, 3).
ikan(rareGhostfish, 3, 4).
ikan(kingfish, 4, 1).
ikan(lobster, 4, 2).
ikan(mutant, 4, 3).
ikan(rareMutant, 4, 4).
ikan(sunfish, 5, 1).
ikan(crimsonfish, 5, 2).
ikan(angler, 5, 3).
ikan(relicanth, 5, 4).

% Untuk mendapatkan ikan
getFish(_Level, 0, fisherman) :-
    write('Kamu tidak mendapatkan apa-apa!\n'),
    earnExp(fish, 10), !,
    write('Kamu mendapatkan 10 exp fishing!\n').

getFish(_Level, 0, _Job) :-
    write('Kamu tidak mendapatkan apa-apa!\n'),
    earnExp(fish, 5), !,
    write('Kamu mendapatkan 5 exp fishing!\n').

getFish(Level, Rare, fisherman) :-
    ikan(Nama, Level, Rare),
    format('Kamu mendapatkan ~w!\n', [Nama]),
    earnExp(fish, 20), 
    addInven(Nama),
    !,
    write('Kamu mendapatkan 20 exp fishing!\n').

getFish(Level, Rare, _Job) :-
    ikan(Nama, Level, Rare),
    format('Kamu mendapatkan ~w!\n', [Nama]),
    earnExp(fish, 10), 
    addInven(Nama),
    !,
    write('Kamu mendapatkan 10 exp fishing!\n').

% Buat ngeproses input bait
% buat bait
baitInput(1) :-
    inventory(List, _),
    countXinInven(bait, List, Countbait),
    Countbait = 0,
    !,
    write('Kamu gapunya bait!\n').
% buat bait biasa, cuma bisa dapet rarity 0 sampe 2
baitInput(1) :-
    job(Job),
    level(fish, Level),
    inventory(List, Total),
    retractall(inventory(_,_)),
    NewTotal is Total - 1,
    deleteValinList(bait, List, ListOut),
    asserta(inventory(ListOut, NewTotal)),
    updateInvenOne(bait),
    write('Kamu menggunakan bait!\n'),
    random(0, 2, Hasil),
    getFish(Level, Hasil, Job), !.
% buat good bait
baitInput(2) :-
    inventory(List, _),
    countXinInven(goodBait, List, Countbait),
    Countbait = 0,
    !,
    write('Kamu gapunya good bait!\n').

baitInput(2) :-
    job(Job),
    level(fish, Level),
    inventory(List, Total),
    retractall(inventory(_,_)),
    NewTotal is Total - 1,
    deleteValinList(goodBait, List, ListOut),
    asserta(inventory(ListOut, NewTotal)),
    updateInvenOne(goodBait),
    write('Kamu menggunakan good bait!\n'),
    random(1, 3, Hasil),
    getFish(Level, Hasil, Job), !.

% buat great bait
baitInput(3) :-
    inventory(List, _),
    countXinInven(greatestBait, List, Countbait),
    Countbait = 0,
    !,
    write('Kamu gapunya great bait!\n').

baitInput(3) :-
    job(Job),
    level(fish, Level),
    inventory(List, Total),
    retractall(inventory(_,_)),
    NewTotal is Total - 1,
    deleteValinList(greatestBait, List, ListOut),
    asserta(inventory(ListOut, NewTotal)),
    updateInvenOne(greatestBait),
    write('Kamu menggunakan great bait!\n'),
    random(2, 4, Hasil),
    getFish(Level, Hasil, Job), !.

% Command fishing
fish :- % kasus ngga bisa mancing karena ngga di pinggir danau
    \+ loc_tile(lake_edge),
    !,
    write('Ngga ada danau di sekitarmu!!\n').

fish :- % kasus ngga bisa mancing karena ngga bawa pancingan
    loc_tile(lake_edge),
    \+ isXinInven(fishingRod),
    !,
    write('Kamu ngga bawa alat mancing!!\n').
% Kasus ga bawa bait
fish :-
    loc_tile(lake_edge),
    isXinInven(fishingRod), % belom ngecek level fishing rodnya
    \+ isXinInven(bait),
    \+ isXinInven(goodBait),
    \+ isXinInven(greatestBait),
    job(Job),
    !,
    random(0, 1, HasilRoll),
    getFish(1, HasilRoll, Job).

% Kasus bawa bait
fish :-
    inventory(List, _Total),
    loc_tile(lake_edge),
    isXinInven(fishingRod), % belom ngecek level fishing rodnya
    countXinInven(bait, List, Countbait),
    countXinInven(goodBait, List, Countgoodbait),
    countXinInven(greatestBait, List, Countgreatbait),
    !,
    write('Bait yang ada di inven kamu: \n'),
    format('1. ~d bait', [Countbait]),
    format('2. ~d good bait', [Countgoodbait]),
    format('3. ~d greatest bait', [Countgreatbait]),
    read(Input),
    baitInput(Input).

% fungsi proses input bait, kek klo bait nya 0 gabisa, dll, trus