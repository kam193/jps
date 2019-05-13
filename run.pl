% load code of A* and space
:- ensure_loaded(full_a_star).

% this executes A* after load this file to prolog
start_up :-
    start_A_star(a, PathCost), (write(PathCost), nl).

:- start_up.