/* DIARY */

/* DYNAMICS */
:- dynamic(diary/2).

diary:-
    day(Day),
    diary(Day, Entry),
    wrapText(Entry, 20),
    write('> '),
    read(Action),
    action(Action).

/* ACTIONS */
action(write):-
    day(Day),
    diary(Day, Entry),
    read(Addition),
    atom_concat(Entry, Addition, NewEntry),
    writeDiary(Day, NewEntry),
    diary.

writeDiary(Day, Entry):-
    retractall(diary(Day,_)),
    asserta(diary(Day, Entry)).

wrapText(Text, CharaPerLine):-
    atom_length(Text, Length),
    Length =< CharaPerLine,
    format(' ~w ', [Text]), nl, !.

wrapText(Text, CharaPerLine):-
    atom_length(Text, Length),
    Length > CharaPerLine,
    sub_atom(Text, 0, CharaPerLine, _, X),
    format(' ~w ', [X]), nl,
    sub_atom(Text, CharaPerLine, _, 0, Next),
    wrapText(Next, CharaPerLine).