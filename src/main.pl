/* DYNAMICS */
:- dynamic(state/1).

/* INCLUDES */
:- include('startGame.pl').
:- include('map.pl').

/* START GAME */
lesgo :-
    asserta(player_name(charlie)),
    write('Siapa namamu, calon petani?\n'),
    read(Name),
    retractall(player_name(_)),
    setPlayerName(Name),
    fill_map.