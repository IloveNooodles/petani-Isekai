/* Includes */
:- include('time.pl').
:- include('startGame.pl').

startHouse:-
  asserta(day(99)),
  retractall(endGame(_)),
  asserta(endGame(false)).

house:-
  write('What do you want to do?\n'),
  write('- bed\n'),
  write('- writeDiary\n'),
  write('- readDiary\n'),
  write('- exit\n').

bed:-
  endGame(Game),
  Game \= true, !,
  day(Day),
  write('You have a good sleep\n'),
  format('Day ~d\n', [Day]),
  nextDay.

writeDiary:-
  day(Day),
  number_atom(Day, X),
  atom_concat('diary/Day', X , Day2),
  atom_concat(Day2, '.txt', Daytxt),
  write('You open your diary and grab a pen\n'),
  write('What are you want to tell to the diary today?\n'),
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
  format('~d. ~w\n',[Index, H]), !,
  NewCounter is Counter + 1,
  printListDiary(T, NewCounter, Index + 1).

printListDiary([_|T], Counter, Index):-
  NewCounter is Counter + 1,
  Counter < 2, printListDiary(T, NewCounter, Index).

readDiary:-
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
  format('Dear Diary\n~w\n\n', [H]),
  atom_concat('diary/', H, File),
  open(File, read, Out),
  read(Out, W),
  close(Out),
  write(W), 
  write('\n##############\n').

processDiary([H], 0):-
  format('~w', [H]), !.

processDiary([], _):-
  write('You haven\'t write a diary!\n'), !.

processDiary([_|T], Index):-
  NewIndex is Index - 1,
  processDiary(T, NewIndex).

