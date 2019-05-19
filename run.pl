% load code of A* and space
:- ensure_loaded(full_a_star).

% this executes A* after load this file to prolog
start_up :-
    start_A_star(
                 [ pos(0, 3/2),
                   pos(1, 2/3),
                   pos(2, 1/1),
                   pos(3, 1/3),
                   pos(4, 3/1),
                   pos(5, 1/2),
                   pos(6, 3/3),
                   pos(7, 2/1),
                   pos(8, 2/2)
                 ],
                 PathCost),
    write(PathCost),
    nl.

:- start_up.