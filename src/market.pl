market:-
    \+ playerName(_), !,
  write('Game has not started yet!\n').

market:-
  \+ loc_tile(market),
  !,
  write('You are not at the Market tile!\n').
