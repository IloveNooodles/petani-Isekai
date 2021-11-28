% Command ranching
ranch:-
      \+ playerName(_), !,
    write('Game has not started yet!\n').

ranch :- % kasus tidak di ranch
    \+ loc_tile(ranch),
    !,
    write('You are currently not at the ranch!\n').
