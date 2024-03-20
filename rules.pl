:-consult(data).

/*
Problem 1
*/

/*
Problem 2
*/

/*
Problem 3
*/

/*
Problem 4
*/

/*
Problem 5
*/

/*
Problem 6
*/

/*
Problem 7
*/

/*
Problem 8
*/


/*
Problem 9
*/
replace([],[]).
replace([H|T1], [H|T2]) :- not(alternative(H,_)), replace(T1, T2).
replace([H|T1], [X|Y]) :- alternative(H,X), replace(T1, Y).
replaceBoycottItemsFromAnOrder(CUSTOMER, ORDER_ID, NewList) :-
    customer(Id, CUSTOMER),order(Id, ORDER_ID, ORDER),replace(ORDER,NewList).

/*
Problem 10
*/

/*
Problem 11
*/
getTheDifferenceInPriceBetweenItemAndAlternative(Item, Alter, Diff):-
    alternative(Item,Alter),item(Item, _, Price1),item(Alter, _, Price2),Diff is Price1 - Price2.
/*
Problem 12
*/
add_item(Name, Brand, Price):-
    not(item(Name, _, _)),assert(item(Name, Brand, Price)).
remove_item(Name, Brand, Price):-
    item(Name, Brand, Price),retract(item(Name, Brand, Price)).

add_alternative(Item, Alter):-
    not(alternative(Item, Alter)),assert(alternative(Item, Alter)).
remove_alternative(Item, Alter):-
    alternative(Item, Alter),retract(alternative(Item, Alter)).

add_boycott_company(Company, Reason):-
    not(boycott_company(Company, Reason)),assert(boycott_company(Company, Reason)).
remove_boycott_company(Company, Reason):-
    boycott_company(Company, Reason),retract(boycott_company(Company, Reason)).