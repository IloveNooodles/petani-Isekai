house:-
  write("What do you want to do?\n"),
  write("- sleep\n"),
  write("- writeDiary\n"),
  write("- readDiary\n"),
  write("- exit\n").

/* ini gausah di random ya kaya mimpinya buruk apa engga
tapi bisa aja ketemu peri2 itu kan ya */
sleep:-
  write("You have a good sleep\n"),
  nextDay,
  write("Day ~d\n" [Day]),
  status.
