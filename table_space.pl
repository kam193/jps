goal([pos(0, 3/1), pos(1, 1/3), pos(2, 2/3), pos(3, 3/3), pos(4, 1/2), pos(5, 2/2), pos(6, 3/2), pos(7, 1/1), pos(8, 2/1)]).

succ([pos(0, EmptyPos)|TilePositions], Action, 1, [pos(0, NewEmptyPos)|NewTilePositions]) :-
    find_neighbour(EmptyPos, TilePositions, NewEmptyPos, NewTilePositions, Action).

% 1. Row + 1 (up)
% 2. Row - 1 (down)
% 3. Column - 1 (left)
% 4. Column + 1 (right)
find_neighbour(Column/Row, TilePos, Column/NRow, NewTilePos, move(Column/Row, Column/NRow)) :-
    NRow is Row+1,
    NRow<4,
    change_position(Column/Row,
                    Column/NRow,
                    TilePos,
                    NewTilePos).


find_neighbour(Column/Row, TilePos, Column/NRow, NewTilePos, move(Column/Row, Column/NRow)) :-
    NRow is Row-1,
    NRow>0,
    change_position(Column/Row,
                    Column/NRow,
                    TilePos,
                    NewTilePos).    

find_neighbour(Column/Row, TilePos, NColumn/Row, NewTilePos, move(Column/Row, NColumn/Row)) :-
    NColumn is Column-1,
    NColumn>0,
    change_position(Column/Row,
                    NColumn/Row,
                    TilePos,
                    NewTilePos).

find_neighbour(Column/Row, TilePos, NColumn/Row, NewTilePos, move(Column/Row, NColumn/Row)) :-
    NColumn is Column+1,
    NColumn<4,
    change_position(Column/Row,
                    NColumn/Row,
                    TilePos,
                    NewTilePos).

change_position(NewPos, OldPos, [pos(I, OldPos)|RestPos], [pos(I, NewPos)|RestPos]) :-
    !.

change_position(NewPos, OldPos, [Tile|RestPos], [Tile|NewRest]) :-
    change_position(NewPos, OldPos, RestPos, NewRest).

hScore(State, HScore) :-
    goal(GoalState),
    hCount(State, HScore, GoalState).

hCount([], 0, []).

hCount([pos(I, Column/Row)|Rest], HScore, [pos(I, GCol/GRow)|GRest]) :-
    ColumnDiff is Column-GCol,
    RowDiff is Row-GRow,
    my_abs(ColumnDiff, ColAbs),
    my_abs(RowDiff, RowAbs),
    hCount(Rest, RestScore, GRest),
    HScore is RestScore+RowAbs+ColAbs.

my_abs(Val, Val) :-
    Val>=0,
    !.
my_abs(Val, Abs) :-
    Abs is -Val.