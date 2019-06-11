% load code of A* and space
:- ensure_loaded(full_a_star).

% this executes A* after load this file to prolog
start_up :-
    start_A_star(
                 [ 
                % pos(0, 3/2), pos(1, 1/3), pos(2, 2/3), pos(3, 3/3), pos(4, 1/2), pos(5, 2/2), pos(6, 3/1), pos(7, 1/1), pos(8, 2/1)
                  %  pos(0, 3/2),
                  %  pos(1, 2/3),
                  %  pos(2, 1/1),
                  %  pos(3, 1/3),
                  %  pos(4, 3/1),
                  %  pos(5, 1/2),
                  %  pos(6, 3/3),
                  %  pos(7, 2/1),
                  %  pos(8, 2/2)
                  % pos(0, 1/3), pos(1, 2/3), pos(2, 3/3), pos(3, 3/2), pos(4, 1/2), pos(5, 2/2), pos(6, 3/1), pos(7, 1/1), pos(8, 2/1)
                pos(0, 2/2 ), pos(1, 1/3), pos(2, 2/3), pos(3, 3/3), pos(4, 1/1), pos(5, 3/2), pos(6, 3/1), pos(7, 2/1), pos(8, 1/2)
%  pos(0, 3/1), pos(1, 2/3), pos(2, 1/2), pos(3, 3/3), pos(4, 1/1), pos(5, 2/2),  pos(6, 3/2),  pos(7, 2/1), pos(8, 1/3) % -> 100 krokow / 30
%  pos(0, 2/3), pos(1, 3/3), pos(2, 1/2), pos(3, 3/2), pos(4, 1/1), pos(5, 2/2), pos(6, 3/1), pos(7, 2/1), pos(8, 1/3) % -> 153 kroki
 % 8 1
 % 253
 % 476


                % pos(0, 3/1), pos(1, 1/3), pos(2, 2/3), pos(3, 3/3), pos(4, 1/2), pos(5, 2/2), pos(6, 3/2), pos(7, 1/1), pos(8, 2/1)
                 ],
                 PathCost),
    write(PathCost),
    nl.

:- start_up.