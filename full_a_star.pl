% Load state space from file (no error from linter)
:- ensure_loaded(state_space). 
:- ensure_loaded(e1_fetch_utils).


start_A_star(InitState, PathCost) :-
    score(InitState, 0, 0, InitCost, InitScore),
    read_element(Limit, "Steps limit: "),
    read_element(Preferences, "Preferences list size: "),
    search_A_star([node(InitState, nil, nil, InitCost, InitScore)],
                  [],
                  PathCost,
                  0,
                  Limit,
                  Preferences).

                
search_A_star(Queue, ClosedSet, PathCost, Step, Limit, Preferences) :-
    Step<Limit,
    NextStep is Step+1,
    fetch(Node,
          Queue,
          ClosedSet,
          RestQueue,
          NextStep,
          Limit,
          Preferences),
    continue(Node,
             RestQueue,
             ClosedSet,
             PathCost,
             NextStep,
             Limit,
             Preferences).
                
search_A_star(Queue, ClosedSet, PathCost, Step, Limit, Preferences) :-
    Step is Limit,
    read_element(NewLimit,
                 "Steps=Limit, write new limit or '0' if you want to stop."),
    search_A_star(Queue,
                  ClosedSet,
                  PathCost,
                  Step,
                  Limit,
                  Preferences,
                  NewLimit).

search_A_star(Queue, ClosedSet, PathCost, Step, Limit, Preferences, NewLimit) :-
    \+ NewLimit is 0,
    NewLimit>Limit, % check if new limit is greater than current
    search_A_star(Queue, ClosedSet, PathCost, Step, NewLimit, Preferences).

continue(node(State, Action, Parent, Cost, _), _, ClosedSet, path_cost(Path, Cost), _, _, _) :-
    goal(State),
    !,
    build_path(node(Parent, _, _, _, _),
               ClosedSet,
               [Action/State],
               Path).

continue(Node, RestQueue, ClosedSet, Path, Step, Limit, Preferences) :-
    expand(Node, NewNodes),
    insert_new_nodes(NewNodes, RestQueue, NewQueue),
    search_A_star(NewQueue,
                  [Node|ClosedSet],
                  Path,
                  Step,
                  Limit,
                  Preferences).

fetch(Node, Queue, ClosedSet, Queue, Step, Limit, Preferences) :-
    write("Step is "),
    write(Step),
    write(" / Limit is "),
    write(Limit),
    nl,
    select_elements(Preferences, Queue, ClosedSet, 0, Selected),
    write("Selected N elemets: "),
    write(Selected),
    len(Selected, SelectedLength),
    minimum(SelectedLength, Preferences, Minimum),
    nl,
    read_list(Minimum, 0, UserList),
    nl,
    infetch(Node, Selected, UserList, Preferences, 1).

infetch(_, _, _, Max, CurrentIndex) :-
    CurrentIndex is Max+1,
    !.

infetch(Node, Queue, Order, _, CurrentIndex) :-
    get(CurrentIndex, Order, 1, NodeIndex),
    get(NodeIndex, Queue, 1, Node),
    write("Current node: "+Node+" "+CurrentIndex),
    nl.

infetch(Node, Queue, Order, Max, CurrentIndex) :-
    NextIndex is CurrentIndex+1,
    infetch(Node, Queue, Order, Max, NextIndex).

% fetch(node(State, Action, Parent, Cost, Score), [node(State, Action, Parent, Cost, Score)|RestQueue], ClosedSet, RestQueue) :-
%     \+ member(node(State, _, _, _, _),
%               ClosedSet),
%     select_elements(2,
                    
%                     [ node(State, Action, Parent, Cost, Score)
%                     | RestQueue
%                     ],
%                     0,
%                     Selected),
%     write("Slected N elemets: "),
%     write(Selected),
%     nl,
%     read_list(3, 0, UserList),
%     write(UserList),
%     nl,
%     !.

% fetch(Node, [_|RestQueue], ClosedSet, NewRest) :-
%     fetch(Node, RestQueue, ClosedSet, NewRest).
expand(node(State, _, _, Cost, _), NewNodes) :-
    findall(node(ChildState, Action, State, NewCost, ChildScore),
            ( succ(State, Action, StepCost, ChildState),
              score(ChildState, Cost, StepCost, NewCost, ChildScore)
            ),
            NewNodes).


score(State, ParentCost, StepCost, Cost, FScore) :-
    Cost is ParentCost+StepCost,
    hScore(State, HScore),
    FScore is Cost+HScore.


insert_new_nodes([], Queue, Queue).

insert_new_nodes([Node|RestNodes], Queue, NewQueue) :-
    insert_p_queue(Node, Queue, Queue1),
    insert_new_nodes(RestNodes, Queue1, NewQueue).


insert_p_queue(Node, [], [Node]) :-
    !.

insert_p_queue(node(State, Action, Parent, Cost, FScore), [node(State1, Action1, Parent1, Cost1, FScore1)|RestQueue], [node(State1, Action1, Parent1, Cost1, FScore1)|Rest1]) :-
    FScore>=FScore1,
    !,
    insert_p_queue(node(State, Action, Parent, Cost, FScore),
                   RestQueue,
                   Rest1).

insert_p_queue(node(State, Action, Parent, Cost, FScore), Queue, [node(State, Action, Parent, Cost, FScore)|Queue]).


build_path(node(nil, _, _, _, _), _, Path, Path) :-
    !.

build_path(node(EndState, _, _, _, _), Nodes, PartialPath, Path) :-
    del(Nodes,
        node(EndState, Action, Parent, _, _),
        Nodes1),
    build_path(node(Parent, _, _, _, _),
               Nodes1,
               [Action/EndState|PartialPath],
               Path).


del([X|R], X, R).
del([Y|R], X, [Y|R1]) :-
    X\=Y,
    del(R, X, R1).

len([], LenResult):-
    LenResult is 0.

len([X|Y], LenResult):-
    len(Y, L),
    LenResult is L + 1.

minimum(A, B, A):-
    A < B.
minimum(A, B, B):-
    \+ A < B.