room(1,1).
room(1,2).
room(1,3).
room(1,4).
room(2,1).
room(2,2).
room(2,3).
room(2,4).
room(3,1).
room(3,2).
room(3,3).
room(3,4).
room(4,1).
room(4,2).
room(4,3).
room(4,4).

breeze(room(2,1)).
breeze(room(4,1)).
breeze(room(3,2)).
breeze(room(2,3)).
breeze(room(4,3)).
breeze(room(3,4)).

stench(room(1,2)).
stench(room(2,3)).
stench(room(1,4)).

adjacent(room(X,Y),room(A,B)) :- room(X,Y), room(A,B), (X=A), Z is (Y+1), (Z=B).
adjacent(room(X,Y),room(A,B)) :- room(X,Y), room(A,B), (X=A), Z is (Y-1), (Z=B).
adjacent(room(X,Y),room(A,B)) :- room(X,Y), room(A,B), (B=Y), Z is (X+1), (Z=A).
adjacent(room(X,Y),room(A,B)) :- room(X,Y), room(A,B), (B=Y), Z is (X-1), (Z=A).

position(room(1,2)).

visited(room(1,1)).
visited(room(1,2)).

glitter(room(2,3)).

gold(room(X,Y)) :- glitter(room(X,Y)).
   
wumpus(room(X,Y)) :- room(X,Y), room(A,B), stench(room(A,B)), adjacent(room(X,Y),room(A,B)).

pit(room(X,Y)) :- room(X,Y), room(A,B), breeze(room(A,B)), adjacent(room(X,Y),room(A,B)).

% breeze(room(X,Y)) :- room(X,Y), room(A,B), pit(room(A,B)), adjacent(room(X,Y),room(A,B)).

% stench(room(X,Y)) :- room(X,Y), room(A,B), wumpus(room(A,B)), adjacent(room(X,Y),room(A,B)).

grabGold :- room(X,Y), gold(room(X,Y)), position(room(X,Y)).

shootWumpus :- room(X,Y), stench(room(X,Y)), position(room(X,Y)).

candidate(room(X,Y)) :- room(X,Y), visited(room(X,Y)), room(A,B), position(room(A,B)), adjacent(room(A,B),room(X,Y)).

no_pit(room(A,B)) :- visited(room((A,B))).
no_pit(room(A,B)) :- room(X,Y), adjacent(room(A,B),room(X,Y)), not(breeze(room(X,Y))).

no_wumpus(room(A,B)) :- visited(room((A,B))).
no_wumpus(room(A,B)) :- room(X,Y), adjacent(room(A,B),room(X,Y)), not(stench(room(X,Y))).

safe(room(X,Y)) :- room(X,Y), candidate(room(X,Y)), no_wumpus(room(X,Y)), no_pit(room(X,Y)).

