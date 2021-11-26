/* DYNAMICS */
:- dynamic(day/1).
:- dynamic(time/2).
:- dynamic(weather/1).
:- dynamic(season/1).
:- dynamic(endGame/1).
:- dynamic(gameCompleted/1).

/* Time and Season */
resetTime:-
    retractall(day(_)),
    retractall(time(_,_)),
    retractall(weather(_)),
    retractall(season(_)).

startDay:-
    retractall(day(_)),
    asserta(day(1)).

/* dicek kalo lebih dari 365 end game nya jadi true */
/* harus di cek kalo day nya udah masuk season baru sm randomize weather */

nextDay:-
    day(X),
    X >= 365, !,
    retractall(endGame(_)),
    asserta(endGame(true)),
    write('Year have passed...\n'),
    endgame.

nextDay:-
    day(X),
    X < 365,
    Y is X + 1,
    setDay(Y),
    setWeather,
    setSeason(Y).

setDay(Day):-
    retractall(day(_)),
    asserta(day(Day)),
    checkRipe.

setTime(Hour, Minute):-
    retractall(time(_,_)),
    asserta(time(Hour, Minute)).

/* anggap mulai 1 Maret beres 28 Februari, biar gampang musimnya */
/* tergantung mau mulai dari musim kaya gimana */
/* ini gw masukinnya dari belahan utara ya berarti 4 season */
/* 1 Maret - 31 Mei - Semi */
/* 1 Juni - 31 Agustus - Panas */
/* 1 September - 30 November - Gugur */
/* 1 Desember - 28 Februari - Dingin */

startSeason:-
    asserta(season(semi)).

/*Musim semi*/
setSeason(Day):-
  Day >= 1, Day =< 92,
  retractall(season(_)),
  asserta(season(semi)).

/*Musim panas*/
setSeason(Day):-
  Day >= 93, Day =< 183,
  retractall(season(_)),
  asserta(season(panas)).

/*Musim gugur*/
setSeason(Day):-
  Day >= 184, Day =< 273,
  retractall(season(_)),
  asserta(season(gugur)).

/*Musim dingin*/
setSeason(Day):-
  Day >= 274, Day =< 366,
  retractall(season(_)),
  asserta(season(dingin)).

/* tergantung mau mulai dari cuaca kaya gimana */
/* cuaca harus bisa dirandom belom kepikiran */
/* Buat musim semi: panas, ujan jarang bgt, angin*/
/* Buat musim panas: panas, ujan, angin */
/* Buat musim Gugur: panas, ujan, angin, daun jatuh2 gatau namanya apa */
/* Buat musim Dingin: snow, cold, freeze */

startWeather:-
  asserta(weather(panas)).

setWeather():-
  season(Season),
  season = semi,
  random(1, 101, Number),
  possibleWeatherSemi(Number).

setWeather():-
  season(Season),
  season = panas,
  random(1, 101, Number),
  possibleWeatherPanas(Number).

setWeather():-
  season(Season),
  season = gugur,
  random(1, 101, Number),
  possibleWeatherGugur(Number).

setWeather():-
  season(Season),
  season = dingin,
  random(1, 101, Number),
  possibleWeatherDingin(Number).

/*Musim semi*/
possibleWeatherSemi(Number):-
  Number < 3, retractall(weather(_)), asserta(weather(badai)).

possibleWeatherSemi(Number):-
  Number < 10, retractall(weather(_)), asserta(weather(ujan)).

possibleWeatherSemi(Number):-
  Number < 40, retractall(weather(_)), asserta(weather(panas)).

possibleWeatherSemi(Number):-
  retractall(weather(_)), asserta(weather(berawan)).

/*Musim panas*/
possibleWeatherPanas(Number):-
  Number < 3, retractall(weather(_)), asserta(weather(badai)).

possibleWeatherPanas(Number):-
  Number < 10, retractall(weather(_)), asserta(weather(berawan)).

possibleWeatherPanas(Number):-
  Number < 40, retractall(weather(_)), asserta(weather(sangatPanas)).

possibleWeatherPanas(Number):-
  retractall(weather(_)), asserta(weather(panas)).

/*Musim gugur*/

possibleWeatherGugur(Number):-
  Number < 5, retractall(weather(_)), asserta(weather(anginTopan)).

possibleWeatherGugur(Number):-
  Number < 20, retractall(weather(_)), asserta(weather(berangin)).

possibleWeatherGugur(Number):-
  retractall(weather(_)), asserta(weather(berawan)).

/*Musim dingin*/
possibleWeatherDingin(Number):-
  Number < 5, retractall(weather(_)), asserta(weather(badaiSalju)).

possibleWeatherDingin(Number):-
  retractall(weather(_)), asserta(weather(salju)).


/* bisa aja tambahin status effect kaya kalo dingin gimana kalo panas gimana */
startTime:-
    setTime(9,0).

endgame:-
  endGame(Endgame), gameCompleted(Completed)
  endGame = true, completed = false,
  write('You have worked hard, but in the end result is all that matters.\nMay God bless you in the future with kind people!').

endgame:-
  endGame(Endgame), gameCompleted(Completed)
  endGame = true, completed = true,
  write('Congratulations! After all of your hardwork, you have finally collected 20000 golds!'), nl, write('Now you can rest assured and tell those bad guys who\'s the boss!').

