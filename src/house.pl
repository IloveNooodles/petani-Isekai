/* Includes */

house:-
  \+ playerName(_), !,
  write('Game has not started yet!\n').

house:-
  \+ loc_tile(home),
  !,
  write('You are not at the House tile!\n').

house:-
  loc_tile(X), !, X = home,
  write('What do you want to do?\n'),
  write('- bed\n'),
  write('- writeDiary\n'),
  write('- readDiary\n'),
  write('- exitHouse\n').

writeDiary:-
  \+ playerName(_), !,
  write('Game has not started yet!\n').

writeDiary:-
  \+ loc_tile(home),
  !,
  write('You are not at the House tile!\n').

writeDiary:-
  loc_tile(Z), !, Z = home,
  day(Day),
  number_atom(Day, X),
  atom_concat('diary/Day', X , Day2),
  atom_concat(Day2, '.txt', Daytxt),
  write('You open your diary and grab a pen\n'),
  write('What are you want to tell to the diary today? (wrap the text with \'\')\n'),
  open(Daytxt, write, In),
  read(Word),
  atom_concat('\'', Word, NewWord1),
  atom_concat(NewWord1, '\'.', NewWord2),
  write(In, NewWord2), nl,
  close(In).

listDiary:-
  directory_files('diary', Files),
  printListDiary(Files, 0, 1).

printListDiary([], _, _):- !.
printListDiary([H|T], Counter, Index):-
  Counter >= 2,
  sub_atom(H, _, _, 4, NH),
  format('~d. ~w\n',[Index, NH]), !,
  NewCounter is Counter + 1,
  printListDiary(T, NewCounter, Index + 1).

printListDiary([_|T], Counter, Index):-
  NewCounter is Counter + 1,
  Counter < 2, printListDiary(T, NewCounter, Index).

readDiary:-
  \+ playerName(_), !,
  write('Game has not started yet!\n').

readDiary:-
  \+ loc_tile(home),
  !,
  write('You are not at the House tile!\n').

readDiary:-
  loc_tile(X), X = home,
  directory_files('diary', Files),
  Files = [_, _|T],
  T = [],
  write('You haven\'t write a diary!\n'), !. 

readDiary:-
  loc_tile(Z), !, Z = home,
  listDiary,
  directory_files('diary', Files),
  write('Choose which one of the diary you want to read!\n'),
  read(X),
  Y is X - 1,
  chooseDiary(Files, Y).

chooseDiary([_ , _| T], Index):-
  processDiary(T, Index).

processDiary([H|_], 0):-
  write('##############\n'),
  sub_atom(H, _, _, 4, Y),
  format(' Dear Diary\n ~w\n\n', [Y]),
  atom_concat('diary/', H, File),
  open(File, read, Out),
  read(Out, W),
  close(Out),
  wrapText(W, 12),
  write('\n##############\n').

processDiary([_|T], Index):-
  NewIndex is Index - 1,
  processDiary(T, NewIndex).

/* ini gausah di random ya kaya mimpinya buruk apa engga
tapi bisa aja ketemu peri2 itu kan ya */

sleep:-
  \+ playerName(_), !,
  write('Game has not started yet!\n').

sleep:-
  \+ loc_tile(home),
  !,
  write('You are not at the House tile!\n').

sleep:-
  loc_tile(X), !, X = home,
  printSleep,
  random(1, 10000, Number),
  write('You had a good sleep.\n\n'),
  sleep(0.75),
  doneAlchemist,
  nextDay,
  dream(Number),
  status.

/* ANIMATION */
printSleep:-
  write('z'),
  flush_output,
  sleep(0.75),
  write(' z'),
  flush_output,
  sleep(0.75),
  write(' Z'),
  flush_output,
  sleep(1),
  write(' .'),
  flush_output,
  sleep(1),
  write(' .\n'),
  sleep(1).

exitHouse:-
  \+ playerName(_), !,
  write('Game has not started yet!\n').

exitHouse:-
  \+ loc_tile(home),
  !,
  write('You are not at the House tile!\n').

exitHouse:-
  write('You left the house...\n'), nl.

/* peri tidur */
dream(Number):-
  Number < 100,
  write('You\'ve met fairy in your dream'), nl, write('She says that she can teleport you to anyplace you want to go!\n'),
  write('Enter X coordinate (2-21)'),
  read(X),
  write('Enter Y coordinate (2-21)'),
  read(Y),
  retractall(player(_, _)),
  asserta(player(X, Y)),
  write('You woke up and realize that you have teleported to selected location'), nl.

dream(_):- !.