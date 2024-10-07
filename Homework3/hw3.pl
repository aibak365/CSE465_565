% hw3.pl
% Aibak Aljadayah
% ------------------------------------------------
% #1 (Undergraduate/Graduate) (5/5 pts)
% Determine the Maximum of two int numbers
% maxnums(A, B, MAX).
maxnums(A,B,MAX) :- MAX is max(A,B).

% maxnums(-12, 12, MAX). -> MAX = 12
% maxnums(11232, 92674, MAX). -> MAX = 92674
% maxnums(1, 1, MAX). -> MAX = 1 
% ------------------------------------------------
% #2 (Undergraduate/Graduate) (5/5 pts)
% Determine the summation of a list of integer numbers
% sum(LST, SUM).
sum([],0).
sum([Head|Tail],Count) :- sum(Tail, TailCount), Count is TailCount + Head.



% sum([1, 2, 3, 4], SUM). -> SUM = 10
% sum([10, -10], SUM). -> SUM = 0
% sum([], SUM). -> SUM = 0
% ------------------------------------------------
% #3 (Undergraduate/Graduate) (5/5 pts)
% Determine the Maximum of list of integer numbers
% ** You MUST use/call your maxnums predicate that you defined in #1
%    as part of your solution.
% ** You can always assume that the given LST is not empty. 
% max(LST, MAX).
max([MAX], MAX).
max([Head|Tail],MAX) :- max(Tail,Max),  maxnums(Head, Max, MAX).

% max([-5, -5, -5], MAX). -> MAX = -5
% max([1], MAX). -> MAX = 1
% max([413, 0, 977], MAX). -> MAX = 977
% ------------------------------------------------
% #4 (Undergraduate/Graduate) (5/5 pts)
% Determine if a list of integer numbers can be split into two lists 
% that sum to the same value.
% ** You MUST use/call your sum predicate that you defined in #2
%    as part of your solution.
% ** You can always assume that the given LST is not empty. 
% partitionable(LST).
partitionable(LST) :- sum(LST, Sum), Sum mod 2 =:=0, HalfSum is Sum//2,
subset_sum(LST,HalfSum).
subset_sum([],0).
subset_sum([Head|Tail], Sum) :- subset_sum(Tail,Sum).
subset_sum([Head|Tail], Sum) :- Sum >= Head, NewSum is Sum - Head,
subset_sum(Tail,NewSum).

 
 
% partitionable([1, 2, 3, 4, 10]). -> true. because [10, 10]
% partitionable([2, 1, 1]). -> true. because [2, 2]
% partitionable([0]). -> true.
% partitionable([1, 4, 8]). -> false.
% partitionable([3, 2]). -> false.
% ------------------------------------------------
% #5 (Undergraduate/Graduate) (5/5 pts)
% Determine whether the given integer number does exist in the given 
% list of integer numbers
% elementExist(E, LST).
elementExist(E, [E|_]).
elementExist(E,[Head|Tail]) :- elementExist(E,Tail).


% elementExist(3, [1, 2, 3]). -> true.
% elementExist(1, []). -> false.
% elementExist(-10, [-34, -56, 2]). -> false.
% ------------------------------------------------
% #6 (Undergraduate/Graduate) (5/5 pts)
% Determine the reverse list of integer numbers
% reverse(LST, REVLST).

reverse([], []). 
reverse([Head|Tail], REVLST) :- 
    reverse(Tail, RevT), 
    append(RevT, [Head], REVLST).

% reverse([], REVLST). -> REVLST = []
% reverse([1, 1, 1], REVLST). -> REVLST = [1, 1, 1]
% reverse([4, 0, -4, 6], REVLST). -> REVLST = [6, -4, 0, 4]
% reverse([47391], REVLST). -> REVLST = [47391]
% ------------------------------------------------
% #7 (Undergraduate/Graduate) (5/5 pts)
% Determine the list of integer numbers that are only one digit numbers
% collectOneDigits(LST, NEWLST). 
collectOneDigits([], []).

collectOneDigits([Head|Tail], NewLst) :-
    (Head >= -9, Head =< 9),
    collectOneDigits(Tail, TempLst),
    append([Head],TempLst, NewLst).

collectOneDigits([Head|Tail], NewLst) :-
    Head mod 10 =\= Head,
    collectOneDigits(Tail, NewLst).

% collectOneDigits([10, 90, -20], NEWLST). -> NEWLST = []
% collectOneDigits([], NEWLST). -> NEWLST = []
% collectOneDigits([10, 90, -20, 5, -6], NEWLST). -> NEWLST = [5, -6]
% ------------------------------------------------
% #8 (Undergraduate/Graduate) (5/5 pts)
% Consult the 'zipcodes.pl' file, and study it.
% It contains facts about the US zipcodes.
% location(Zipcode, Plcae, State, Location, Latitude, Longitude).
% Example: for getting all the Zipcodes and Sates you can do 
%         location(Z, _, S, _, _, _). 
% Determine all places based on given state and zipcode.
% getStateInfo(PLACE, STATE, ZIPCODE).
% location(45056,'Oxford','OH','Butler',39.4792,-84.6857).
:- consult('zipcodes.pl').
getStateInfo(Place, State, Zipcode) :-
    location(Zipcode, Place, State, _, _, _).
% getStateInfo('Oxford', State, 45056). -> State = 'OH'
% getStateInfo('Oxford', State, _). -> 
% State = 'AL' 
% State = 'AR' 
% State = 'CT' 
% State = 'FL' 
% State = 'GA' 
% State = 'GA' 
% State = 'IA' 
% State = 'IN' 
% State = 'KS' 
% State = 'MA' 
% State = 'MD' 
% State = 'ME' 
% State = 'MI' 
% State = 'MI' 
% State = 'MS' 
% State = 'NC' 
% State = 'NE' 
% State = 'NJ' 
% State = 'NY' 
% State = 'OH' 
% State = 'PA' 
% State = 'WI'
% 
% getStateInfo(_, 'OH', 48122). -> false.
% ------------------------------------------------
% #9 (Undergrad/Grad) (15/5 pts)
% Consult the 'zipcodes.pl' file, and study it.
% It contains facts about the US zipcodes.
% location(Zipcode, Plcae, State, Location, Latitude, Longitude).
% Example: for getting all the Zipcodes and Sates you can do 
%         location(Z, _, S, _, _, _). 
% Gets place names that are common to both STATE1 and STATE2, 
% where STATE1 and STATE2 differ
% ** The order of places is not important
% ** Duplicate values should be removed
% ** You are to do your own search to find a way to return all 
%    places as a single list. You can use any necessary predicate 
%    from Prolog library. Being able to learn something
%    about a new programming language on your own is a skil that takes
%    practice. 
% getCommon(STATE1, STATE2, PLACELST).

:- consult('zipcodes.pl').
getCommon(State1, State2, PlaceLst) :-
    findall(Place, location(_, Place, State1, _, _, _), Places1),
    findall(Place, location(_, Place, State2, _, _, _), Places2),
    intersection(Places1, Places2, CommonPlaces),
    sort(CommonPlaces, PlaceLst).

% please note it will be turncated, so please use getCommon('OH','MI',PLACELST),write(PLACELST).
% getCommon('OH','MI',PLACELST). -> *Should be 131 unique plcase* 
% ['Manchester','Unionville','Athens','Saint
% Johns','Belmont','Bellaire','Bridgeport','Lansing','Flushing','D
% ecatur','Hamilton','Oxford','Trenton','Monroe','Augusta','Carrol
% lton','Milford','Moscow','New
% Richmond','Williamsburg','Clarksville','Midland','Elkton','Salem
% ','Blissfield','Bedford','Greenville','North Star','Union
% City','Sherwood','Ashley','Birmingham','Milan','Sandusky','Colum
% bus','Lyons','Metamora','Burton','Alpha','Cedarville','Jamestown
% ','Fairview','Harrison','Arcadia','Kenton','Ridgeway','Ada','Alg
% er','Freeport','Harrisville','Napoleon','Highland','Lakeville','
% Millersburg','Nashville','Bellevue','New
% Haven','Jackson','Wellston','Bloomingdale','Empire','Mount
% Pleasant','Richmond','Perry','Eastlake','Homer','Utica','Lakevie
% w','Quincy','Holland','Ellsworth','Petersburg','Marion','Caledon
% ia','Brunswick','Chippewa
% Lake','Litchfield','Portland','Coldwater','Mendon','Rockford','C
% ovington','Troy','Clayton','Vandalia','Fulton','Sparta','Rosevil
% le','Martin','Somerset','Jasper','Wakefield','Ravenna','Wayland'
% ,'Deerfield','Camden','Cloverdale','Plymouth','Shelby','Frankfor
% t','Kingston','Fremont','Adrian','Attica','Flat
% Rock','Fostoria','Republic','Sidney','Paris','Canton','Bath','Cl
% inton','Hudson','Akron','Fowler','Hartford','Niles','Warren','Du
% ndee','Marysville','Ray','Franklin','Mason','Lowell','Newport','
% ------------------------------------------------
% #10 ( -- /Graduate) (0/10 pts)
% * ** Only for Graduate Studetns **
% Download the 'parse.pl' from canvas and study it.
% Write Prolog rules to parse simple English sentences 
% (similar to how it was done in parse.pl). The difference here is that 
% the number (i.e., plurality) of the noun phrase and verb phrase must match. 
% That is, “The sun shines” and “The suns shine” is proper, 
% whereas “The suns shines” and “The sun shine” are not. 
% Make sure your code also includes the following vocabulary.
% singular nouns: sun, bus, deer, grass, party
% plural nouns: suns, buses, deer, grasses, parties
% articles: a, an, the
% adverbs: loudly, brightly
% adjectives: yellow, big, brown, green, party
% plural verbs: shine, continue, party, eat
% singular verbs: shines, continues, parties, eats
% Singular nouns
noun_singular([sun]).
noun_singular([bus]).
noun_singular([deer]).
noun_singular([grass]).
noun_singular([party]).

% Plural nouns
noun_plural([suns]).
noun_plural([buses]).
noun_plural([deer]).
noun_plural([grasses]).
noun_plural([parties]).

% Singular verbs
verb_singular([shines]).
verb_singular([continues]).
verb_singular([parties]).
verb_singular([eats]).

% Plural verbs
verb_plural([shine]).
verb_plural([continue]).
verb_plural([party]).
verb_plural([eat]).

% Articles
article([a]).
article([an]).
article([the]).

% Adjectives
adjective([yellow]).
adjective([big]).
adjective([brown]).
adjective([green]).
adjective([party]).

% Adverbs
adverb([loudly]).
adverb([brightly]).
sentence(S) :- append(NP, VP, S), np(Number, NP), vp(Number, VP).
np(Number, [ART|NP]) :- article([ART]), np2(Number, NP).
np(Number, NP) :- np2(Number, NP).
np2(singular, NP2) :- noun_singular(NP2).
np2(plural, NP2) :- noun_plural(NP2).
np2(Number, [ADJ|NP2]) :- adjective([ADJ]), np2(Number, NP2).
vp(singular, VP) :- verb_singular(VP).
vp(plural, VP) :- verb_plural(VP).
vp(Number, [VERB|ADV]) :- (verb_singular([VERB]), Number = singular; verb_plural([VERB]), Number = plural), adverb(ADV).


% sentence([the, party, bus, shines, brightly]). -> true.
% sentence([the, big, party, continues]). -> true.
% sentence([a, big, brown, deer, eats, loudly]). -> true.
% sentence([big, brown, deer, eat, loudly]). -> true.
% sentence([the, sun, shines, brightly]). -> true.
% sentence([the, suns, shine, brightly]). -> true.
% sentence([the, deer, eats, loudly]). -> true.
% sentence([the, deer, eat, loudly]). -> true.
% sentence([the, sun, shine, brightly]). -> false.
%sentence([the, suns, shines, brightly]). -> false.
% ------------------------------------------------

