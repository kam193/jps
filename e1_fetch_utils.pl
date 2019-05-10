% select up to N first elements from given list
% select_elements(N, Queue, CurrentSelected, SelectedList).
select_elements(N, _, N, []) :-
    !.

select_elements(_, [], _, []) :-
    !.

select_elements(N, [F|RestQueue], CurrentSelect, [F|RestSelectedList]) :-
    NextSelect is CurrentSelect+1,
    select_elements(N, RestQueue, NextSelect, RestSelectedList).

% read list of N elements from user
% read_list(Size, CurrentStep, OutList)
read_list(Size, Size, []) :-
    !.

read_list(Size, CurrentStep, [UserInput|Rest]) :-
    NextStep is CurrentStep+1,
    write("Input element "),
    write(NextStep),
    write(" of "),
    write(Size),
    write(": "),
    read(UserInput),
    read_list(Size, NextStep, Rest).