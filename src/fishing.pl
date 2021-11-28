/*
Buat fakta ikan ikan yg ada dengan format
ikan(nama, rarity, rarity tingkat 2)
misal:
ikan(blueTuna, 4, 3)
4 itu rarity general, jadi klo uda level 4 misal, dia selalu dapet rarity 4
rarity tingkat 2 nya itu kalo 3 paling mahal. Jadi ntar yang di random itu rarity tingkat 2
Lvel fishing rod memengaruhi stamina yang dipake
bait memengaruhi hasil tangkapan sama level fishing juga

Alur:
fishing. cek dia di pinggir danau ato engga, trus cek bawa fishing rod ato engga, trus klo ada pilih bait, trus lgsg random
waktu random klo dapet 0 berarti ndak dapet apa apa
*/

/* DYNAMIC PREDIACTE */
:- dynamic(fishST/1).

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

/* ***** ANIMASI MANCING ANJAY ***** */
fishAnim(1) :-
    write('   \\\\\n'),
    write('   |   \\\\\n'),
    write('   |       \\\\\n'),
    write('   |           \\\\\n'),
    write('   |               \\\\\n'),
    write('   |                   \\\\\n'),
    write('   |                       \\\\\n'),
    write(' ~ | ~                          \\\\\n'),
    write(' ~ |  ~                            \\\\\n'),
    write(' ~ ~ ~ ~                            \n\n').

fishAnim(2) :-
    write('   \\\\\n'),
    write('   |   \\\\\n'),
    write('   |       \\\\\n'),
    write('   |           \\\\\n'),
    write('   |               \\\\\n'),
    write('   |                   \\\\\n'),
    write('   |                       \\\\\n'),
    write('  ~|~ ~                        \\\\\n'),
    write(' ~ |  ~                           \\\\\n'),
    write('  ~ ~ ~                            \n\n').

fishPrint(1) :-
    write('.\n').
fishPrint(2) :-
    write('.    .\n').
fishPrint(3) :-
    write('.    .    .\n').

playFishAnim(4) :-
    !.

playFishAnim(Frame) :-
    shell('clear'),
    AnimFrame is (Frame mod 2 + 1),
    fishAnim(AnimFrame),
    fishPrint(Frame),
    sleep(0.75),
    NewFrame is Frame + 1,
    playFishAnim(NewFrame).

% Untuk mengurangi stamina berdasarkan level fishing rod
reduceST :-
    stamina(ST),
    fishST(Cost),
    NewST is ST - Cost,
    retractall(stamina(_)),
    asserta(stamina(NewST)).
    
% Untuk mengupdate fishST sesuai level fishingRod
updateFishST :-
    item(fishingRod, tools, 1),
    retractall(fishST(_)),
    asserta(fishST(20)), !.

updateFishST :-
    item(fishingRod, tools, 2),
    retractall(fishST(_)),
    asserta(fishST(16)), !.

updateFishST :-
    item(fishingRod, tools, 3),
    retractall(fishST(_)),
    asserta(fishST(12)), !.

updateFishST :-
    item(fishingRod, tools, 4),
    retractall(fishST(_)),
    asserta(fishST(8)), !.

updateFishST :-
    item(fishingRod, tools, 5),
    retractall(fishST(_)),
    asserta(fishST(4)), !.

% Untuk mendapatkan ikan
getFish(_Level, 0, fisherman) :-
    write('Kamu tidak mendapatkan apa-apa!\n'),
    earnExp(fish, 10),
    earnExp(general, 20),
    time(H, M),
    addTime(H, M, 15, HNew, MNew),
    setTime(HNew, MNew), !,
    write('Kamu mendapatkan 10 exp fishing!\n'),
    write('Kamu mendapatkan 20 exp!\n').

getFish(_Level, 0, _Job) :-
    write('Kamu tidak mendapatkan apa-apa!\n'),
    earnExp(fish, 5),
    earnExp(general, 20),
    time(H, M),
    addTime(H, M, 15, HNew, MNew),
    setTime(HNew, MNew), !,
    write('Kamu mendapatkan 5 exp fishing!\n'),
    write('Kamu mendapatkan 20 exp!\n').

getFish(Level, Rare, fisherman) :-
    ikan(Nama, Level, Rare),
    format('Kamu mendapatkan ~w!\n', [Nama]),
    earnExp(fish, 20), 
    earnExp(general, 20), 
    addInven(Nama),
    time(H, M),
    addTime(H, M, 15, HNew, MNew),
    setTime(HNew, MNew),
    fishCompletion(1),
    !,
    write('Kamu mendapatkan 20 exp fishing!\n'),
    write('Kamu mendapatkan 20 exp!\n').

getFish(Level, Rare, _Job) :-
    ikan(Nama, Level, Rare),
    format('Kamu mendapatkan ~w!\n', [Nama]),
    earnExp(fish, 10), 
    addInven(Nama),
    earnExp(general, 20),
    time(H, M),
    addTime(H, M, 15, HNew, MNew),
    setTime(HNew, MNew),
    fishCompletion(1),
    !,
    write('Kamu mendapatkan 10 exp fishing!\n'),
    write('Kamu mendapatkan 20 exp!\n').

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
    throw(bait, 1),
    playFishAnim(1), % mainkan anim mancing
    write('Kamu menggunakan bait!\n'),
    random(0, 3, Hasil), % random rarity
    LevelRndm is Level + 1,
    random(1, LevelRndm, RndmLvl), % random level
    getFish(RndmLvl, Hasil, Job), 
    reduceST, !. % kurangi stamina
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
    throw(goodBait, 1),
    playFishAnim(1),
    write('Kamu menggunakan good bait!\n'),
    random(1, 4, Hasil),
    LevelRndm is Level + 1,
    random(1, LevelRndm, RndmLvl), % random level
    getFish(RndmLvl, Hasil, Job),  
    reduceST, !.

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
    throw(greatestBait, 1),
    playFishAnim(1),
    write('Kamu menggunakan great bait!\n'),
    random(2, 5, Hasil),
    LevelRndm is Level + 1,
    random(1, LevelRndm, RndmLvl), % random level
    getFish(RndmLvl, Hasil, Job), 
    reduceST, !.

% Command fishing
fish :-
    \+ playerName(_), !,
    write('Game has not started yet!\n').

fish :- % kasus ngga bisa mancing karena ngga di pinggir danau
    \+ loc_tile(lake_edge),
    !,
    write('Ngga ada danau di sekitarmu!!\n').

fish :- % kasus ngga bisa mancing karena musim dingin
    loc_tile(lake_edge),
    season(dingin),
    !,
    write('Sekarang musim dingin!!\nDanaunya membeku dan kamu ngga bisa mancing!!\n').

fish :- % kasus ngga bisa mancing karena badai
    loc_tile(lake_edge),
    weather(badai),
    !,
    write('Cuaca lagi badai!!\nIkannya pada masuk ke dasar danau!!\nKamu ngga bisa mancing!!\n').

fish :- % kasus ngga bisa mancing karena hujan
    loc_tile(lake_edge),
    weather(hujan),
    !,
    write('Cuaca lagi hujan!!\nIkannya pada masuk ke dasar danau!!\nKamu ngga bisa mancing!!\n').

fish :- % kasus ngga bisa mancing karena ngga bawa pancingan
    loc_tile(lake_edge),
    \+ isXinInven(fishingRod),
    !,
    write('Kamu ngga bawa alat mancing!!\n').

% Kasus stamina kurang
fish :-
    loc_tile(lake_edge),
    isXinInven(fishingRod),
    updateFishST,
    stamina(ST),
    fishST(STmin),
    ST < STmin,
    !,
    write('Stamina kamu kurang!!\n').

% Kasus ga bawa bait
fish :-
    loc_tile(lake_edge),
    isXinInven(fishingRod), % belom ngecek level fishing rodnya
    \+ isXinInven(bait),
    \+ isXinInven(goodBait),
    \+ isXinInven(greatestBait),
    !,
    write('Kamu ngga bisa mancing karena ngga punya bait!\n').

% Kasus bawa bait
fish :-
    inventory(List, _Total),
    loc_tile(lake_edge),
    isXinInven(fishingRod),
    countXinInven(bait, List, Countbait),
    countXinInven(goodBait, List, Countgoodbait),
    countXinInven(greatestBait, List, Countgreatbait),
    !,
    write('Bait yang ada di inven kamu: \n'),
    format('1. ~d bait\n', [Countbait]),
    format('2. ~d good bait\n', [Countgoodbait]),
    format('3. ~d greatest bait\n', [Countgreatbait]),
    write('Bait mana yang akan kamu gunakan?(Masukkan berupa angka)\n>> '),
    read(Input),
    baitInput(Input),
    !.
% fungsi proses input bait, kek klo bait nya 0 gabisa, dll, trus