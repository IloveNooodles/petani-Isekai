/* Spek inventory
Kapasitas maksnya 100
Dia nyimpen barang dan equipments tidak terpakai yang didapatkan oleh pemain
Buat predikat inventory([], 100). [] menyatakan list kosong di awal, 100 menyatakan kapasitas total
*/

:- dynamic(inventory/2).
:- dynamic(inventoryOneItem/1).

inventory([], 0).
inventoryOneItem([]).

/* ***********Fungsi buat manipulasi list biasa*********** */
% concat Val di List
concatList(Val, [], [Val]).
concatList(Val, [H|T], ListOut) :-
    concatList(Val, T, ListOut2), ListOut = [H|ListOut2].
% Delete val dari dalam list
deleteValinList(_Val, [], []) :- !.
deleteValinList(Val, [Val|T], T) :- !.
deleteValinList(Val, [H|T], [H|ListOut]) :- 
    deleteValinList(Val, T, ListOut).

% Fungsi mencari apakah X ada di list.
isXinList(X, [X|_T]) :- !.
isXinList(X, [_H|T]) :- isXinList(X, T).

/* ***********Fungsi-fungsi buat operasi list inven*********** */
% Menghitung kemunculan X di inven
countXinInven(_X, [], 0) :- !.
countXinInven(X, [Y], 0) :- X \== Y, !.
countXinInven(X, [Y], 1) :- X == Y, !.
countXinInven(X, [H|T], Count) :- 
    countXinInven(X, T, Count2),
    (X == H, Count is Count2 + 1 ; X \== H, Count is Count2), !.
% Menambah sebuah item X di inventory
addInven(_X) :-
    inventory(_ListIn, Total),
    Total = 100,
    !,
    write('Tas kamu penuh!!\n').
% ini kalo dia baru pertama kali masuk inven
addInven(X) :-
    inventory(ListIn, Total),
    inventoryOneItem(ListOne),
    NewTotal is Total + 1,
    concatList(X, ListIn, ListBefore),
    \+ isXinList(X, ListOne),
    concatList(X, ListOne, ListOne2),
    !,
    retractall(inventory(_,_)),
    retractall(inventoryOneItem(_)),
    asserta(inventory(ListBefore, NewTotal)),
    asserta(inventoryOneItem(ListOne2)).
% ini kalo dia udah duplikat
addInven(X) :-
    inventory(ListIn, Total),
    inventoryOneItem(ListOne),
    NewTotal is Total + 1,
    concatList(X, ListIn, ListBefore),
    isXinList(X, ListOne),
    !,
    retractall(inventory(_,_)),
    asserta(inventory(ListBefore, NewTotal)).

% Buat nampilin invent
showInven([], _) :- !.
showInven([H|T], InvenLengkap) :-
    countXinInven(H, InvenLengkap, Count),
    format('>> ~d ~w\n', [Count, H]),
    showInven(T, InvenLengkap).

% Update di invenOneItem
updateInvenOne(Item) :-
    inventory(List, _),
    inventoryOneItem(ListOne),
    countXinInven(Item, List, Res),
    Res =:= 0,
    deleteValinList(Item, ListOne, ListOneOut),
    retractall(inventoryOneItem(_)),
    asserta(inventoryOneItem(ListOneOut)).

% Buat throwitem
% throw(_Item, _) :-
%     inventory(List, _),
%     countXinInven(_Item, List, Count),
%     Count =:= 0, 
%     !, write('Kamu ngga punya item itu!!\n').
% Untuk membuang satu item
throw(Item, 1) :-
    inventory(List, Cap),
    retractall(inventory(_,_)),
    NewCap is Cap - 1,
    deleteValinList(Item, List, ListOut),
    asserta(inventory(ListOut, NewCap)), !,
    updateInvenOne(Item).
% Kalo jumlahnya kelebihan
throw(Item, Count) :-
    inventory(List, _),
    countXinInven(Item, List, Res),
    Count > Res,
    !,
    write('Jumlahnya kelebihan!!\n').
% Buang item lebih dari satu
throw(Item, Count) :-
    inventory(List, Cap),
    retractall(inventory(_,_)),
    NewCap is Cap - 1,
    deleteValinList(Item, List, ListOut),
    asserta(inventory(ListOut, NewCap)), 
    !,
    NewCount is Count - 1,
    throw(Item, NewCount).

/* Command buat inventory */
% Buat nampilin invent
inventory :-
    inventory(_, Cap),
    Cap = 0,
    !,
    write('Inventory kosong!!\n').

inventory :-
    inventory(List, TotalInven),
    inventoryOneItem([H1|T1]),
    format('Inventory Anda:  (~d/100)\n', [TotalInven]),
    showInven([H1|T1], List).

throwItem :-
    inventory,
    inventory(List, _Total),
    write('Item apa yang ingin kamu buang?\n> '),
    read(Item),
    ((
    countXinInven(Item, List, Count),
    Count =:= 0,
    write('Kamu ngga punya item itu!!\n')
    );
    (
    inventory(List, _Total),
    countXinInven(Item, List, Count),
    Count > 0,
    format('Kamu punya ~d ~w Berapa yang ingin kamu buang?\n> ', [Count, Item]),
    read(Amount),
    throw(Item, Amount)
    )),
    !.

