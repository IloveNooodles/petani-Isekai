/* Spek Map
Peta berukuran 20x20, dengan tambahan 2 kolom dan 2 baris untuk border
(X, Y) itu koordinat di map
pojok kiri atas itu (1,1)
Pagar di koordinat (1,Y), (X, 1), (20, Y), (X,20)
*/

/* dynamic predicate */
baris(22).
kolom(22).
:- dynamic(border/2). /* koordinat border */
:- dynamic(player/2). /* koordinat border */
:- dynamic(market_coordinate/2). /* koordinat border */
:- dynamic(home_coordinate/2). /* koordinat border */
:- dynamic(ranch_coordinate/2). /* koordinat border */
:- dynamic(quest_coordinate/2). /* koordinat border */
:- dynamic(dirt/2). /* koordinat border */
:- dynamic(digged_coordinate/2). /* koordinat border */
:- dynamic(ripe_coordinate/3).
:- dynamic(planted_coordinate/4). /* koordinat border */
:- dynamic(water_coordinate/2). /* koordinat border */
:- dynamic(wizard_coordinate/2). /* koordinat border */
:- dynamic(loc_tile/1).
:- dynamic(playerName/1). /* ini sementara */

/* Spek Map
border = #
player = P
market = M
home = H
ranch = R
quest = Q
dirt = -
digged = =
water = o
wizard = W
*/

/*
Ada predikat loc_tile untuk menyatakan situasi lokasi player, seperti:
home: player masuk home
quest: player masuk quest
ranch: player masuk ranch
market: player masuk market
digged: player di kebun
corn: player di lahan yang sudah ditanami corn
ripe_corn: player di tanaman corn yang sudah matang
lake_edge: player di pinggir danau
dirt: player di tanah kosong
*/
/* Map */
fill_map :- 
    /* hapus dulu map sebelomnya */
    retractall(border(_,_)),
    retractall(player(_,_)),
    retractall(market_coordinate(_,_)),
    retractall(home_coordinate(_,_)),
    retractall(ranch_coordinate(_,_)),
    retractall(quest_coordinate(_,_)),
    retractall(dirt(_,_)),
    retractall(digged_coordinate(_,_)),
    retractall(planted_coordinate(_,_)),
    retractall(ripe_coordinate(_,_,_)),
    retractall(water_coordinate(_,_,_)),
    retractall(wizard_coordinate(_,_)),
    /* buat map */
    % Border map
    asserta(border(1,_)),
    asserta(border(_,1)),
    asserta(border(22,_)),
    asserta(border(_,22)),
    asserta(wizard_coordinate(18,18)),
    % Player
    asserta(player(12,5)),
    % market
    asserta(market_coordinate(18,7)),
    % home
    asserta(home_coordinate(12,6)),
    % ranch
    asserta(ranch_coordinate(12,8)),
    % quest
    asserta(quest_coordinate(18,5)),
    % digged (ini kayanya harus di hardcode)
    % asserta(digged_coordinate(X,Y)),
    % water deket home
    asserta(water_coordinate(5,9)),
    asserta(water_coordinate(6,9)),
    asserta(water_coordinate(7,9)),
    asserta(water_coordinate(4,10)),
    asserta(water_coordinate(5,10)),
    asserta(water_coordinate(6,10)),
    asserta(water_coordinate(7,10)),
    asserta(water_coordinate(8,10)),
    asserta(water_coordinate(4,11)),
    asserta(water_coordinate(5,11)),
    asserta(water_coordinate(6,11)),
    asserta(water_coordinate(7,11)),
    asserta(water_coordinate(8,11)),
    asserta(water_coordinate(5,12)),
    asserta(water_coordinate(6,12)),
    asserta(water_coordinate(7,12)),
    % water pojok kiri bawah
    asserta(water_coordinate(4,18)),
    asserta(water_coordinate(5,18)),
    asserta(water_coordinate(6,18)),
    asserta(water_coordinate(7,18)),
    asserta(water_coordinate(3,19)),
    asserta(water_coordinate(4,19)),
    asserta(water_coordinate(5,19)),
    asserta(water_coordinate(6,19)),
    asserta(water_coordinate(7,19)),
    asserta(water_coordinate(8,19)),
    asserta(water_coordinate(3,20)),
    asserta(water_coordinate(4,20)),
    asserta(water_coordinate(5,20)),
    asserta(water_coordinate(6,20)),
    asserta(water_coordinate(7,20)),
    asserta(water_coordinate(8,20)),
    asserta(water_coordinate(4,21)),
    asserta(water_coordinate(5,21)),
    asserta(water_coordinate(6,21)),
    asserta(water_coordinate(7,21)),
    % isi dengan dirt
    asserta(dirt(_,_)),
    % deklarasi loc tile
    asserta(loc_tile(dirt)).

% Debugging loc_check
print_loc_now :- playerName(Name), loc_tile(quest), !, format('~w bisa mengambil quest!', [Name]), nl.
print_loc_now :- playerName(Name), loc_tile(market), !, format('~w masuk ke Marketplace!', [Name]), nl.
print_loc_now :- playerName(Name), loc_tile(home), !, format('~w masuk ke Home!', [Name]), nl.
print_loc_now :- playerName(Name), loc_tile(ranch), !, format('~w masuk ke Ranch!', [Name]), nl.
print_loc_now :- playerName(Name), loc_tile(digged), !, format('~w sedang mengecek kebun!', [Name]), nl.
print_loc_now :- playerName(Name), loc_tile(planted), !, format('~w sedang mengecek kebun!', [Name]), nl.
print_loc_now :- playerName(Name), loc_tile(ripe), !, format('~w sedang mengecek kebun! Wah kayanya udah mateng!', [Name]), nl.
print_loc_now :- playerName(Name), loc_tile(lake_edge), !, format('~w di pinggir danau!', [Name]), nl.
print_loc_now :- playerName(Name), loc_tile(wizard), !, format('~w masuk ke tempat wizard!', [Name]), nl.

/* print karakter */
printChar(X, Y) :- border(X, Y), !, write('#').
printChar(X, Y) :- player(X, Y), !, write('P').
printChar(X, Y) :- hasAlchemist(Z), !, Z = true, wizard_coordinate(X, Y), !, write('W').
printChar(X, Y) :- market_coordinate(X, Y), !, write('M').
printChar(X, Y) :- home_coordinate(X, Y), !, write('H').
printChar(X, Y) :- ranch_coordinate(X, Y), !, write('R').
printChar(X, Y) :- quest_coordinate(X, Y), !, write('Q').
printChar(X, Y) :- 
    planted_coordinate(X, Y, Seed, _),
    !, 
    sub_atom(Seed, 0, 1, _, SeedName),
    write(SeedName).
printChar(X, Y) :- 
    ripe_coordinate(X, Y, Seed),
    !, 
    sub_atom(Seed, 0, 1, _, SeedName),
    lower_upper(SeedName,SeedUp),
    write(SeedUp).
printChar(X, Y) :- digged_coordinate(X, Y), !, write('=').
printChar(X, Y) :- water_coordinate(X, Y), !, write('o').
printChar(X, Y) :- dirt(X, Y), !, write('-').

% kayanya harus liat state gamenya
map:-
    \+ playerName(_), !,
    write('Game has not started yet!\n').

map :-
    forall(between(1,22,Y),(
        forall(between(1,22,X), (
            printChar(X,Y)
        )),
        nl
    )).

% Fungsi cek lokasi sekarang
% Cek di market
loc_check(X,Y) :- 
    market_coordinate(X,Y),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(market)),
    print_loc_now.
%  cek di home
loc_check(X,Y) :- 
    home_coordinate(X,Y),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(home)),
    print_loc_now.

% cek di ranch
loc_check(X,Y) :- 
    ranch_coordinate(X,Y),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(ranch)),
    print_loc_now.

% cek di wizard
loc_check(X,Y) :- 
    wizard_coordinate(X,Y),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(wizard)),
    print_loc_now.

% cek di Quest
loc_check(X,Y) :- 
    quest_coordinate(X,Y),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(quest)),
    print_loc_now.

% cek di ripe tile
loc_check(X,Y) :- 
    ripe_coordinate(X,Y,_),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(ripe)),
    print_loc_now.

% cek di planted tile
loc_check(X,Y) :- 
    planted_coordinate(X,Y,_,_),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(planted)),
    print_loc_now.

% cek di digged tile
loc_check(X,Y) :- 
    digged_coordinate(X,Y),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(digged)),
    print_loc_now.
    
% Cek kalo dia di pinggir danau, ada 8 kasus, player di kanan, kiri, atas, bawah, trus di serong kanan atas, dst
loc_check(X,Y) :-
    XAround is X + 1,
    water_coordinate(XAround,Y),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(lake_edge)),
    print_loc_now.
   
loc_check(X,Y) :-
    XAround is X - 1,
    water_coordinate(XAround,Y),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(lake_edge)),
    print_loc_now.
   
loc_check(X,Y) :-
    YAround is Y - 1,
    water_coordinate(X,YAround),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(lake_edge)),
    print_loc_now.

loc_check(X,Y) :-
    YAround is Y + 1,
    water_coordinate(X,YAround),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(lake_edge)),
    print_loc_now.
% Kasus serong-serong
loc_check(X,Y) :-
    XAround is X + 1,
    YAround is Y + 1,
    water_coordinate(XAround,YAround),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(lake_edge)),
    print_loc_now.

loc_check(X,Y) :-
    XAround is X + 1,
    YAround is Y - 1,
    water_coordinate(XAround,YAround),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(lake_edge)),
    print_loc_now.

loc_check(X,Y) :-
    XAround is X - 1,
    YAround is Y + 1,
    water_coordinate(XAround,YAround),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(lake_edge)),
    print_loc_now.

loc_check(X,Y) :-
    XAround is X - 1,
    YAround is Y - 1,
    water_coordinate(XAround,YAround),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(lake_edge)),
    print_loc_now.

loc_check(X,Y) :-
    dirt(X, Y),
    !,
    retractall(loc_tile(_)),
    asserta(loc_tile(dirt)).

% Buat gerak gerak
% Buat w
w :-
    \+ playerName(_), !,
    write('Game has not started yet!\n').

w :- 
    playerName(Name),
    player(X,Y),
    Ynow is Y - 1,
    border(X,Ynow),
    !,
    format('~w nabrak pagar :(', [Name]), nl.

w :- 
    playerName(Name),
    player(X,Y),
    Ynow is Y - 1,
    water_coordinate(X,Ynow),
    !,
    format('~w hampir aja masuk danau, kasian ntar tenggelam, dia gabisa renang.', [Name]), nl.

w :- 
    playerName(Name),
    player(X,Y),
    Ynow is Y - 1,
    retractall(player(_,_)),
    asserta(player(X, Ynow)),
    time(H, M),
    addTime(H, M, 1, HNew, MNew),
    setTime(HNew, MNew),
    !, format('~w bergerak ke utara satu langkah!', [Name]), nl, loc_check(X,Ynow), print_loc_now.
% Buat a
a :-
    \+ playerName(_), !,
    write('Game has not started yet!\n').

a :- 
    playerName(Name),
    player(X,Y),
    Xnow is X-1,
    border(Xnow,Y),
    !,
    format('~w nabrak pagar :(', [Name]), nl.

a :- 
    playerName(Name),
    player(X,Y),
    Xnow is X-1,
    water_coordinate(Xnow,Y),
    !,
    format('~w hampir aja masuk danau, kasian ntar tenggelam, dia gabisa renang.', [Name]), nl.

a :- 
    playerName(Name),
    player(X,Y),
    Xnow is X - 1,
    retractall(player(_,_)),
    asserta(player(Xnow, Y)),
    time(H, M),
    addTime(H, M, 1, HNew, MNew),
    setTime(HNew, MNew),
    !, format('~w bergerak ke barat satu langkah!', [Name]), nl, loc_check(Xnow,Y).

% Buat s
s :-
    \+ playerName(_), !,
    write('Game has not started yet!\n').
s :- 
    playerName(Name),
    player(X,Y),
    Ynow is Y + 1,
    border(X,Ynow),
    !,
    format('~w nabrak pagar :(', [Name]), nl.

s :- 
    playerName(Name),
    player(X,Y),
    Ynow is Y + 1,
    water_coordinate(X,Ynow),
    !,
    format('~w hampir aja masuk danau, kasian ntar tenggelam, dia gabisa renang.', [Name]), nl.

s :- 
    playerName(Name),
    player(X,Y),
    Ynow is Y + 1,
    retractall(player(_,_)),
    asserta(player(X, Ynow)),
    time(H, M),
    addTime(H, M, 1, HNew, MNew),
    setTime(HNew, MNew),
    !, format('~w bergerak ke selatan satu langkah!', [Name]), nl, loc_check(X,Ynow).

% Buat d
d :-
    \+ playerName(_), !,
    write('Game has not started yet!\n').

d :- 
    playerName(Name),
    player(X,Y),
    Xnow is X+1,
    water_coordinate(Xnow,Y),
    !,
    format('~w hampir aja masuk danau, kasian ntar tenggelam, dia gabisa renang.', [Name]), nl.

d :- 
    playerName(Name),
    player(X,Y),
    Xnow is X+1,
    border(Xnow,Y),
    !,
    format('~w nabrak pagar :(', [Name]), nl.

d :- 
    playerName(Name),
    player(X,Y),
    Xnow is X + 1,
    retractall(player(_,_)),
    asserta(player(Xnow, Y)),
    time(H, M),
    addTime(H, M, 1, HNew, MNew),
    setTime(HNew, MNew),
    !, format('~w bergerak ke timur satu langkah!', [Name]), nl, loc_check(Xnow,Y).