:- dynamic(questStatus/3).
:- dynamic(questAwal/3).
:- dynamic(questonProgress/1).

questStatus(0,0,0).
questonProgress(false).

% command to remove harvest quest
harvestCompletion(X) :-
    questStatus(HarvestQuest, FishQuest, RanchQuest),
    HarvestQuest-X =< 0,
    !,
    retractall(questStatus(_,_,_)),
    asserta(questStatus(0, FishQuest, RanchQuest)).
    
harvestCompletion(X) :-
    !,
    questStatus(HarvestQuest, FishQuest, RanchQuest),
    NewHQ is HarvestQuest-X,
    retractall(questStatus(_,_,_)),
    asserta(questStatus(NewHQ, FishQuest, RanchQuest)).
    
% command to remove fish quest
fishCompletion(X) :-
    questStatus(HarvestQuest, FishQuest, RanchQuest),
    FishQuest-X =< 0,
    !,
    retractall(questStatus(_,_,_)),
    asserta(questStatus(HarvestQuest, 0, RanchQuest)).
    
fishCompletion(X) :-
    !,
    questStatus(HarvestQuest, FishQuest, RanchQuest),
    NewFQ is FishQuest-X,
    retractall(questStatus(_,_,_)),
    asserta(questStatus(HarvestQuest, NewFQ, RanchQuest)).

% command to remove ranch quest
ranchCompletion(X) :-
    questStatus(HarvestQuest, FishQuest, RanchQuest),
    RanchQuest-X =< 0,
    !,
    retractall(questStatus(_,_,_)),
    asserta(questStatus(HarvestQuest, FishQuest, 0)).
    
ranchCompletion(X) :-
    !,
    questStatus(HarvestQuest, FishQuest, RanchQuest),
    NewRQ is RanchQuest-X,
    retractall(questStatus(_,_,_)),
    asserta(questStatus(HarvestQuest, FishQuest, NewRQ)).

quest :-
    \+ playerName(_), !,
    write('Game has not started yet!\n').

% kondisi tidak di tile Q
quest :-
    \+ loc_tile(quest),
    !,
    write('You are not at the Quest tile!\n').

% kondisi quest sudah selesai
quest :-
    questStatus(0,0,0),
    questonProgress(true),
    !,
    retractall(questonProgress(_)),
    asserta(questonProgress(false)),
    questAwal(HQ, FQ, RQ),
    level(general, Gen),

    % SCALING UNTUK MENDAPAT GOLD = total items * level general * 5
    Gold is (HQ+FQ+RQ)*Gen*5,
    earnGold(Gold),

    % SCALING UNTUK MENDAPAT EXP = total items * 15
    GenEXP is (HQ+FQ+RQ)*15,
    earnExp(general, GenEXP),

    write('You have completed all your quest!\n'),
    format('You have earned additional ~w gold, and ~w EXP.\n\n', [Gold,GenEXP]),
    write('Type quest again to start a new quest!\n\n').

% kondisi mendapat quest baru
quest :-
    questStatus(0,0,0),
    questonProgress(false),
    !,
    level(fish, A),
    Fis is A+3,
    level(farm, B),
    Far is B+3,
    level(ranch, C),
    Ran is C+3,
    random(1, Far, HarvestQuest),
    random(1, Fis, FishQuest),
    random(1, Ran, RanchQuest),
    retractall(questStatus(_,_,_)),
    asserta(questStatus(HarvestQuest, FishQuest, RanchQuest)),
    retractall(questonProgress(_)),
    asserta(questonProgress(true)),
    retractall(questAwal(_,_,_)),
    asserta(questAwal(HarvestQuest, FishQuest, RanchQuest)),
    write('You got a new quest!\n\n'),
    format('- ~w harvest items\n', [HarvestQuest]),
    format('- ~w fish\n', [FishQuest]),
    format('- ~w ranch items\n', [RanchQuest]).

% kondisi sudah ada quest on-going
quest :-
    !,
    write('You have an on-going quest!\n'),
    questStatus(HarvestQuest, FishQuest, RanchQuest),
    questAwal(HQ, FQ, RQ),
    format('- ~w/~w harvest items\n', [HarvestQuest, HQ]),
    format('- ~w/~w fish\n', [FishQuest, FQ]),
    format('- ~w/~w ranch items\n', [RanchQuest, RQ]).