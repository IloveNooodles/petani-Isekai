:- dynamic(job/1).

/* START GAME (WELCOME SCREEN) */
startGame:- 
    write('             x\n  .-. _______|\n  |=|/     /  \\ \n  | |_____|_""_|\n  |_|_[X]_|____|\n\n'), /* ASCII ART */
    write('Harvest Galaxy S22!!!\n'),
    write('Let\'s play and pay our debts together!\n\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                           ~Harvest Galaxy S22~                               %\n'),
    write('% 1. start.  : untuk memulai petualanganmu                                     %\n'),
    write('% 2. map.    : menampilkan peta                                                %\n'),
    write('% 3. status. : menampilkan kondisimu terkini                                   %\n'),
    write('% 4. w.      : gerak ke utara 1 langkah                                        %\n'),
    write('% 5. s.      : gerak ke selatan 1 langkah                                      %\n'),
    write('% 6. d.      : gerak ke ke timur 1 langkah                                     %\n'),
    write('% 7. a.      : gerak ke barat 1 langkah                                        %\n'),
    write('% 8. help.   : menampilkan bantuan                                             %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n'),
    write('PENTING!!! Akhiri semua perintah atau inputmu dengan titik (.)\n'), !.

/* START */
start:-
    retractall(job(_)),
    write('Welcome to Harvest Galaxy S22! Please choose your specialty (1-3):\n'),
    write('1. Fisherman\n'),
    write('2. Farmer\n'),
    write('3. Rancher\n'),
    write('> '),
    read(Job),
    ((
        Job = 1,
        asserta(job(fisherman)),
        write('You chose fisherman. ')
    );(
        Job = 2,
        asserta(job(farmer)),
        write('You chose farmer. ')
    );(
        Job = 3,
        asserta(job(rancher)),
        write('You chose rancher. ')
    )),
    write('Let\'s start farming!\n').

/* STATUS */