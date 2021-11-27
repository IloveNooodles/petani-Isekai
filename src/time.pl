/* DYNAMICS */
:- dynamic(day/1).
:- dynamic(time/2).
:- dynamic(weather/1).
:- dynamic(season/1).
:- dynamic(endGame/1).
:- dynamic(gameCompleted/1).

endGame(false).
gameCompleted(false).

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
end(X):-
    X >= 365, !,
    retractall(endGame(_)),
    asserta(endGame(true)),
    write('A year has passed...\n'),
    endgame.

end(_):- !.

nextDay:-
    day(X),
    X < 365, !,
    Y is X + 1,
    end(Y),
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
/* Buat musim semi: panas, hujan jarang bgt, angin*/
/* Buat musim panas: panas, hujan, angin */
/* Buat musim Gugur: panas, hujan, angin, daun jatuh2 gatau namanya apa */
/* Buat musim Dingin: snow, cold, freeze */

startWeather:-
  asserta(weather(panas)).

setWeather :-
  season(Season),
  Season = semi,
  random(1, 101, Number),
  possibleWeatherSemi(Number).

setWeather:-
  season(Season),
  Season = panas,
  random(1, 101, Number),
  possibleWeatherPanas(Number).

setWeather:-
  season(Season),
  Season = gugur,
  random(1, 101, Number),
  possibleWeatherGugur(Number).

setWeather:-
  season(Season),
  Season = dingin,
  random(1, 101, Number),
  possibleWeatherDingin(Number).

/*Musim semi*/
possibleWeatherSemi(Number):-
  Number < 3, retractall(weather(_)), asserta(weather(badai)).

possibleWeatherSemi(Number):-
  Number < 10, retractall(weather(_)), asserta(weather(hujan)).

possibleWeatherSemi(Number):-
  Number < 40, retractall(weather(_)), asserta(weather(panas)).

possibleWeatherSemi(_):-
  retractall(weather(_)), asserta(weather(berawan)).

/*Musim panas*/
possibleWeatherPanas(Number):-
  Number < 3, retractall(weather(_)), asserta(weather(badai)).

possibleWeatherPanas(Number):-
  Number < 10, retractall(weather(_)), asserta(weather(berawan)).

possibleWeatherPanas(Number):-
  Number < 20, retractall(weather(_)), asserta(weather(hujan)).

possibleWeatherPanas(Number):-
  Number < 40, retractall(weather(_)), asserta(weather(sangatPanas)).

possibleWeatherPanas(_):-
  retractall(weather(_)), asserta(weather(panas)).

/*Musim gugur*/

possibleWeatherGugur(Number):-
  Number < 5, retractall(weather(_)), asserta(weather(anginTopan)).

possibleWeatherGugur(Number):-
  Number < 20, retractall(weather(_)), asserta(weather(berangin)).

possibleWeatherGugur(Number):-
  Number < 40, retractall(weather(_)), asserta(weather(hujan)).

possibleWeatherGugur(_):-
  retractall(weather(_)), asserta(weather(berawan)).

/*Musim dingin*/
possibleWeatherDingin(Number):-
  Number < 5, retractall(weather(_)), asserta(weather(badaiSalju)).

possibleWeatherDingin(_):-
  retractall(weather(_)), asserta(weather(salju)).


/* bisa aja tambahin status effect kaya kalo dingin gimana kalo panas gimana */
startTime:-
  setTime(9,0).

addTime(H, M, Plus, H, MNew):-
  MNew is M + Plus,
  MNew < 60,
  H =< 23,
  !.

addTime(H, M, Plus, HNew, MNew):-
  New is M + Plus,
  New >= 60,
  NewMinute is New - 60,
  NewH is H + 1,
  wrapHour(NewH, NewHour),
  addTime(NewHour, NewMinute, 0, HNew, MNew).

wrapHour(H, H):-
  H < 24,
  !.

wrapHour(H, HNew):-
  H >= 24,
  nextDay,
  HNew is 0,
  !.

endgame:-
  endGame(Endgame), gameCompleted(Completed),
  Endgame = true, Completed = false,
  write('You have worked hard, but in the end result is all that matters.\nMay God bless you in the future with kind people!'),
  write('Congratulations for finishing the game.\nHere\'s your last status: '),
  status,
  halt.

endgame:-
  endGame(true), gameCompleted(true),
  write('Congratulations! After all of your hardwork, you have finally collected 20,000 gold!'), nl, write('Now you can rest assured and tell those bad guys who\'s the boss!\n'),
  halt.