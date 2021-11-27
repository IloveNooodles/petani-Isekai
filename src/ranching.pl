% Command ranching
ranch :- % kasus tidak di ranch
    \+ loc_tile(ranch),
    !,
    write('You are currently not at the ranch!\n').
