% Include data.pl file
:-consult(data).

/*
Problem 1
List all orders of a specific customer (as a list).
*/
getCustomerID(CustomerName, CustID):-
    customer(CustID, CustomerName).

getOrderItems(CustID, OrderID, Items):-
    order(CustID, OrderID, Items).

getAllOrders(CustID, OrderID, [Order | OtherOrders]):-
    getOrderItems(CustID, OrderID, Items),
    Order = order(CustID, OrderID, Items),
    NewOrderID is OrderID + 1,
    getAllOrders(CustID, NewOrderID, OtherOrders).

getAllOrders(CustID, _, []).

list_orders(CustomerName, Orders):-
    getCustomerID(CustomerName, CustID),
    getAllOrders(CustID, 1, Orders).
/*
Problem 2
*/

/*
Problem 3
List all items in a specific customer order given customer id and
order id.
*/

getItemsInOrderById(CustomerName, OrderID, Items):-
    getCustomerID(CustomerName, CustID),
    order(CustID, OrderID, Items).

/*
Problem 4
*/

/*
Problem 5
    Predicate to calculate the price of a given order,
    given customer username and order ID.
*/
getOrder(CustomerUsername, OrderID, Items):-
    customer(CustID, CustomerUsername),
    order(CustID, OrderID, Items).

getItemPrice(ItemName, ItemPrice):-
    item(ItemName, _, ItemPrice).

evaluateTotalPrice([], 0).

evaluateTotalPrice([Head|Tail], TotalPrice):-
    getItemPrice(Head, ItemPrice),
    evaluateTotalPrice(Tail, RemainingItemsPrice),
    TotalPrice is ItemPrice + RemainingItemsPrice.

calcPriceOfOrder(CustomerUsername, OrderID, TotalPrice):-
    getOrder(CustomerUsername, OrderID, Items),
    evaluateTotalPrice(Items, TotalPrice).

/*
Problem 6
    Predicate to determine whether we need to boycott or not,
    given item name or company name.
*/
isBoycott(Name):-
    alternative(Name, _);
    boycott_company(Name, _).

/*
Problem 7
*/

/*
Problem 8
    Predicate to remove all the boycott items from a given order,
    given an customer username and order ID.
*/
removeBoycottItems([], []).

removeBoycottItems([Head|Tail], NewList):-
    alternative(Head, _),
    removeBoycottItems(Tail, NewList).

removeBoycottItems([Head|Tail1], [Head|Tail2]):-
    removeBoycottItems(Tail1, Tail2).

removeBoycottItemsFromAnOrder(CustomerUsername, OrderID, NewList):-
    getOrder(CustomerUsername, OrderID, Items),
    removeBoycottItems(Items, NewList).

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
Given an username and order ID, calculate the price of the order after
replacing all boycott items by its alternative (if it exists).
*/

calcPriceAfterReplacingBoycottItemsFromAnOrder(CustomerName, OrderID, NewList, TotalPrice):-
    replaceBoycottItemsFromAnOrder(CustomerName, OrderID, NewList),
    evaluateTotalPrice(NewList, TotalPrice).

/*
calcPriceAfterReplacingBoycottItemsFromAnOrder(CustomerName, OrderID, NewList, TotalPrice).
    replaceBoycottItemsFromAnOrder(CustomerName, OrderID, NewList).
    evaluateTotalPrice(NewList, TotalPrice).    
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