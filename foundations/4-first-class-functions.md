# 4. First Class functions

The main idea of first class functions is that functions can be treated as any other data type. It can be:
- passed in as arguments
- return by other functions

## Passed in as arguments

This is very useful when abstracting repetitive computation. Say you have a series of functions that operates on a value depending on if it is even or odd:

```haskell
ifEvenInc x = 
  if even x 
  then x + 1
  else x

ifEvenDouble x =
  if even x
  then x * 2
  else x

ifEvenSquare x =
  if even x
  then x * x
  else x
```

It is quite redudant; the functions only differ in one operation. Rather you can use **first class functions**:

```haskell
-- first class function where `operation` is a function:
ifEven operation x =
  if even x
  then operation x
  else x

-- each operation is its own function
inc n = n + 1
double n = n * 2
square n = n^2

ifEvenInc n = ifEven inc n
ifEvenDouble n = ifEven double n
ifEvenSquare n = ifEven square n

-- You can also pass in lambda functions:
ifEvenLambda n = ifEven (\x -> x-1) n
```

> Note here that the function `ifEven` has a *higher precedence* that the operation functions.

## Return by other functions

In situations where we have specific functionality for specific values within a larger functionality, it would be useful to isolate each specific functionality as its own entity. 

To give a concrete example, say we own a store that has different discounts for certain on different days of the week. Instead of putting it all in one big if statement (which is not good for extensibility), we can use **first class functions**.

```haskell
-- general discount item
discountItem item discount actualItem =
    if actualItem == item 
    then discount 
    else 0

-- specifying discount item for each day
mondayDiscount item = discountItem "potatoes" 0.10 item
tuesdayDiscount item = discountItem "soap" 0.2 item
wedDiscount item = discountItem "carrots" 0.3 item

-- First class function returns corresponding discount function
getDiscountFunction day = 
  case day of -- case looks at value `of` `location`
    "monday" -> mondayDiscount
    "tuesday" -> tuesdayDiscount
    "wed" -> wedDiscount
    _ -> (\item -> 0) -- lambda function for wildcard case!

getDiscount day item price = price - ( discount * price)
    where discount = (getDiscountFunction day) item
```