% select up to N first elements from given list
% ! -> maybe we need to select only not-used elements!
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

% get all elements from list one by one
% get_element(List, OutElement).
get_element([Element|_], Element).
get_element([_|Rest], Element) :- get_element(Rest, Element).

% get I-th element from list
% get(I, List, Current, Out)
get(I, [Out|_], I, Out).
get(I, [_|Rest], Current, Out) :-
    Next is Current + 1,
    get(I, Rest, Next, Out).