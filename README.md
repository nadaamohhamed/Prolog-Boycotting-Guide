# Prolog-Boycotting-Guide
This is a Prolog program that helps customers who are in solidarity with Gaza by providing alternatives to boycotting companies for their involvement in Israel's oppression of Palestinians.

## Getting Started
To run the program, you need to have a Prolog interpreter installed on your machine. You can download the interpreter from the following link: [SWI-Prolog](http://www.swi-prolog.org/Download.html)

## Running the program
To run the program, simply open the Prolog interpreter and consult the file `rules.pl`. Then, you can use the predicates defined in our program to execute queries and get answers.

## Predicates implemented

1. ```list_orders(CustomerUsername, ListOfOrders)```:
    Predicate to list all orders of a specific customer, as a list.
2. ```countOrdersOfCustomer(CustomerUsername, Count)```:
    Predicate to get the number of orders of a specific customer, given customer username.
3. ```getItemsInOrderById(CustomerUsername, OrderID, Items)```:
    Predicate to list all items in a specific customer order, given customer username and order ID.
4. ```getNumOfItems(CustomerUsername, OrderID, Count)```:
    Predicate to get the number of items in a specific customer order, given customer username and order ID.
5. ```calcPriceOfOrder(CustomerUsername, OrderID, TotalPrice)```:
    Predicate to calculate the price of a given order, given customer username and order ID.
6. ```isBoycott(Name)```:
    Predicate to determine whether we need to boycott or not, given item name or company name.
7. ```whyToBoycott(Name, Justification)```:
    Predicate to find the justification why you need to boycott this company/item, given the company name or an item name.
8. ```removeBoycottItemsFromAnOrder(CustomerUsername, OrderID, NewList)```:
    Predicate to remove all the boycott items from a given order, given a customer username and order ID.
9. ```replaceBoycottItemsFromAnOrder(CustomerUsername, OrderID, NewList)```:
    Predicate to update the order such that all boycott items are replaced by an alternative (if exists), given a customer username and order ID.
10. ```calcPriceAfterReplacingBoycottItemsFromAnOrder(CustomerUsername, OrderID, NewList, TotalPrice)```:
    Predicate to calculate the price of the order after replacing all boycott items by its alternative (if exists), given a customer username and order ID.
11. ```getTheDifferenceInPriceBetweenItemAndAlternative(Item, Alternative, DiffPrice)```:
    Predicate to calculate the difference in price between the boycott item and its alternative.
12. ```add/remove_item/alternative/boycott_company(Name, Brand, Price)```:
    Predicate to add/remove item/alternative/boycott company to/from the knowledge base.