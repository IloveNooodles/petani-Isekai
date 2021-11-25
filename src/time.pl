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
    X >= 365,
    retractall(endGame(_)),
    asserta(endGame(true)).

nextDay:-
    day(X),
    X < 365,
    Y is X + 1,
    setDay(Y).

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

%setSeason(Season):-

/* tergantung mau mulai dari cuaca kaya gimana */
/* cuaca harus bisa dirandom belom kepikiran */
/* Buat musim semi: panas, ujan jarang bgt, angin*/
/* Buat musim panas: panas, ujan, angin */
/* Buat musim Gugur: panas, ujan, angin, daun jatuh2 gatau namanya apa */
/* Buat musim Dingin: snow, cold, freeze */

startWeather:-
    asserta(weather(panas)).

%setWeather()

/* bisa aja tambahin status effect kaya kalo dingin gimana kalo panas gimana */
startTime:-
    setTime(9,0).