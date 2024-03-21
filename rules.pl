% Include data.pl file
:-consult(data).

/*
Problem 1
    Predicate to list all orders of a specific customer, as a list.
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
    Predicate to get the number of orders of a specific customer given customer username.
*/

listLength([],0).

listLength([_|Tail], N):-
    listLength(Tail, TmpN),
    N is TmpN + 1.

countOrdersOfCustomer(CustomerName, Count) :-
    list_orders(CustomerName, Orders),
    listLength(Orders, Count).


/*
Problem 3
    Predicate to list all items in a specific customer order, given customer ID and order ID.
*/

getItemsInOrderById(CustomerName, OrderID, Items):-
    getCustomerID(CustomerName, CustID),
    order(CustID, OrderID, Items).

/*
Problem 4
    Predicate to get the number of items in a specific customer order, given customer username and order ID.
*/

getNumOfItems(CustomerName, OrderID, Count):-
    customer(CustID, CustomerName),
    getOrderItems(CustID, OrderID, Items),
    listLength(Items, Count).


/*
Problem 5
    Predicate to calculate the price of a given order, given customer username and order ID.
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
    Predicate to determine whether we need to boycott or not, given item name or company name.
*/
isBoycott(Name):-
    alternative(Name, _);
    boycott_company(Name, _).

/*
Problem 7
    Predicate to find the justification why you need to boycott this company/item, given the company name or an item name.
*/
whyToBoycott(Name, Justification) :-
    boycott_company(Name, Justification).

whyToBoycott(ItemName, Justification) :-
    item(ItemName, Company, _),
    boycott_company(Company, Justification).
    

/*
Problem 8
    Predicate to remove all the boycott items from a given order, given a customer username and order ID.
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
    Predicate to update the order such that all boycott items are replaced by an alternative (if exists), given a customer username and order ID.
*/
replace([],[]).
replace([H|T1], [H|T2]) :- not(alternative(H,_)), replace(T1, T2).
replace([H|T1], [X|Y]) :- alternative(H,X), replace(T1, Y).
replaceBoycottItemsFromAnOrder(CUSTOMER, ORDER_ID, NewList) :-
    customer(Id, CUSTOMER),order(Id, ORDER_ID, ORDER),replace(ORDER,NewList).

/*
Problem 10
    Predicate to calculate the price of the order after replacing all boycott items by its alternative (if exists), given a customer username and order ID.
*/

calcPriceAfterReplacingBoycottItemsFromAnOrder(CustomerName, OrderID, NewList, TotalPrice):-
    replaceBoycottItemsFromAnOrder(CustomerName, OrderID, NewList),
    evaluateTotalPrice(NewList, TotalPrice).


/*

Problem 11
    Predicate to calculate the difference in price between the boycott item and its alternative.
*/
getTheDifferenceInPriceBetweenItemAndAlternative(Item, Alter, Diff):-
    alternative(Item,Alter),item(Item, _, Price1),item(Alter, _, Price2),Diff is Price1 - Price2.

/*
Problem 12
    Predicate to add/remove item/alternative/boycott company to/from the knowledge base.
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