% animal(jenis, indeks, dayleft).
:- dynamic(animal/3).

:- dynamic(animalQuantity/2).


animalQuantity(chicken, 0).
animalQuantity(goldenChicken, 0).
animalQuantity(cow, 0).
animalQuantity(cowWagyu, 0).
animalQuantity(sheep, 0).
animalQuantity(pinkSheep, 0).

% animal()
% animal(chicken, 0, 0).
% animal(chicken, 1, 24).
% animal(chicken, 2, 12).

% animalQuantity

addAnimal(Animal) :-
    animalQuantity(Animal,Qty),
    Qty1 is Qty+1,
    retractall(animalQuantity(Animal,_)),
    assertz(animalQuantity(Animal,Qty1)),
    azzertz(animal(Animal, Qty1, -1)).

updateDay :-
    forall(animal(chicken,Index,Qty), (Qty1 is Qty - 1, retract(animal(chicken,Index,Qty)), assertz(animal(chicken,Index,Qty1)))).


% Command ranching
ranch:-
      \+ playerName(_), !,
    write('Game has not started yet!\n').

ranch :- % kasus tidak di ranch
    \+ loc_tile(ranch),
    !,
    write('You are currently not at the ranch!\n').
