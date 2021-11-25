house:-
  write("What do you want to do?\n"),
  write("- sleep\n"),
  write("- writeDiary\n"),
  write("- readDiary\n"),
  write("- exit\n").

/* ini gausah di random ya kaya mimpinya buruk apa engga
tapi bisa aja ketemu peri2 itu kan ya */
sleep:-
  printSleep,
  write('You had a good sleep.\n\n'),
  sleep(0.75),
  nextDay,
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