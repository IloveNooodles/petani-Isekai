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
ikan(catfish, 2, 1).
ikan(seacucumber, 2, 2).
ikan(stonefish, 2, 3).
ikan(octopus, 3, 1).
ikan(salmon, 3, 2).
ikan(ghostfish, 3, 3).
ikan(kingfish, 4, 1).
ikan(lobster, 4, 2).
ikan(mutant, 4, 3).
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

% Command fishing
% fish :-
