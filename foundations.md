# Foundations

**Description:** *what you need to know about functional programming*  
**Language**: Haskell

---

## 1. Function

The use of functions in functional programming follows the definition of functions in mathematics. A function can be thought of as taking in an input and producing an output, with the constraint that for any input, it must always product the same output. This constraint has stuck along in functional programming as well. 

### Requirements of a function
A function should always
1. Take in an argument (a.k.a take an input)
2. Return a value
3. Return the same value for the same input (called **referential transparency**)

### Example of a function
```haskell
--function name: add2
--parameter: x
--function return: x + 2
add2 x = x + 2

ghci>add2 1     -> 3
```
---

## 2. Changing States with Variables

A key thing about functional programming that differs from imperative programming is that you cannot redefine variables. For example, the below program will not compile:
```haskell
x = 1
x = 2
```
```
PS C:\Users\codeu\Desktop\functional-programming> ghc test.hs
[1 of 1] Compiling Main             ( test.hs, test.o )

test.hs:2:1: error:
    Multiple declarations of `x'
    Declared at: test.hs:1:1
                 test.hs:2:1
  |
2 | x = 2
  | ^
```

Why cannot you not redefine variables?

---

## 3. `where` clause

The `where` clause provides a semantic flow when assigning values that shows the parallel of Haskell functions with mathematical definitions. For example,
> To find the new price of an item, given its discount percentage and price, subtract the discount amount with price, **where** discount amount is the discount percentage multiplied with the price.

can be directly translated as

```haskell
getNewPrice percentage price = 
    price - discount
    where discount = percentage * price
```

Another use for the `where` clause is it reduces reduancy (like variables in other language paradigms). Here's an example.

```haskell
getLetterGrade grade curve = 
    if grade + (curve)  >= 90
    then "A"
    else if grade + (curve) >= 80 && grade + (curve) < 90
    then "B"
    else if grade + (curve) >= 70 && grade + (curve) < 80
    then "C"
    else "F"
```       

This program re-computes the new grade for each condition. Just as variable assignment in imperative programming, you can use the `where` clause:

```haskell
getLetterGrade grade curve = 
    if newGrade >= 90
    then "A"
    else if newGrade >= 80 && newGrade < 90
    then "B"
    else if newGrade >= 70 && newGrade < 80
    then "C"
    else "F"
    where newGrade = grade + (curve)
```

---

#### Referential Transparency in Depth


### References
- https://www.sitepoint.com/what-is-referential-transparency/#referentialtransparencyinprogramming
- https://cs.stackexchange.com/questions/143180/why-do-functional-languages-disallow-reassignment-of-local-variables
---

## 4. Lambda Functions

The main purpose of lambda functions is as *anonymous functions*. In the situations where creating an intermediate function is overhead, this is where a lambda function can take over. 

### Example of a lambda function
```haskell
--parameter: x
--return: x + 2
--input: 1
ghci>(\x -> x + 2) 1    -> 3
```

### `where` in the form of lambdas

Let's say you want to create a function that compares the sum of squares or square of sums of two numbers, and returns whichever result is larger.

```haskell
compareNums x y = if sumSquare > squareSum
                  then sumSquare
                  else squareSum
  where sumSquare = x^2 + y^2
        squareSum = (x+y)^2
```

> This is how you do multiple assignments in the `where` clause.

Now we want to use **lambdas**. We can first split the function into its two parts: the function body that does the comparison logic, and the computations in the `where` clause.

```haskell
-- comparison logic
body sumSquare squareSum = if sumSquare > squareSum
                           then sumSquare
                           else squareSum

-- computations
compareNums x y = body (x^2+y^2) ((x+y)^2)
```

We can combine these parts, thus getting rid of the intermediate `body` function, all into one function with a lambda.
```haskell
compareNums x y = (\sumSquare squareNum ->
                    if sumSquare > squareNum
                    then sumSquare
                    else squareSum) (x^2+y^2) ((x+y)^2)
```

### `let` expression

The `let` expression provides you the same functionality of lambdas (the ability to isolate the function of any variables) with the readability of the `where` clause. Here is the same example but with `let`:

```haskell
compareNums x y = let sumSquare = (x^2+y^2) -- variable variables
                      squareSum = ((x+y)^2)
                  in 
                    -- lambda
                    if sumSquare > squareSum
                    then sumSquare
                    else squareSum
```

### Lexical scope

Lambda functions are immediately invoked (IIFE - immediately invoked function expression), taking on the nearest/most immediate definition of the variable using lexical scope. This is very useful as it ensures that you are referencing the correct variable.

```haskell
y = 4
-- y refers to variable y, returns 4
add0 x = y
-- y refers to parameter y, x refers to lambda parameter
add1 y = (\x -> y + x) 3 
-- innermost y refers to lambda parameter y, not the function parameter y
add2 y = (\y -> (\x -> y + x) 1 ) 2 
```

---

## 5. First Class functions

The main idea of first class functions is that functions can be treated as any other data type. It can be:
- passed in as arguments
- return by other functions

### Passed in as arguments

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

### Return by other functions

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

---

## 6. Closures and Partial Applications

### Closures - creating functions with functions

With closures, we can generate functions with functions by passing in the function as a parameter. 

Back to the `ifEven` function series, instead of doing `ifEvenInc n = ifEven inc n`, we can instead redefine `ifEvenInc` as such:

```haskell
-- original
ifEvenInc n = ifEven inc n

-- with closures
genIfEven f = (\x ifEven f x) -- f is the operation function

ifEvenInc = genIfEven inc
```

Expanding, we will see that `ifEvenInc` becomes a lambda function that accepts a parameter x (the number to operate on):

```
ifEvenInc = genIfEven inc
ifEvenInc = (\x ifEven inc x)
```

In `genIfEven f = (\x ifEven f x)`, the parameter `f` is captured in the lambda expression, making it a **closure**. In this case, `inc` is the closure.

### Partial Applications

A more refined simplification without the explicit prescence of lambda functions is built into Haskell as **partial applications**.

Using the previous example, we don't even need to create a `genIfEven` function with closure `f`! Partial application will take care of the missing parameter for us. In this case, `ifEvenInc` will be waiting for the remaining parameter `n`.

```haskell
ifEvenInc = ifEven inc

ghci> ifEvenInc 4 -- returns 5
```

> Note about closures and partial applications: order the parameters from most general to least general. 

### Flipping Arguments

Because you want to order your parameters from most general to least general when using partial applications, there comes situations where the order is not correct and the parameters must be *flipped*.

Here is a lambda expression that can fix this issue:
```haskell
flipBinaryArgs f = (\x y -> f y x)
```
In fact, Haskell has its own operator `flip` that does the same thing.

> Haskell allows you to treat infix operators (+, -, *, /, etc.) as a prefix function: `2 + 3` -> `(+) 2 3`. Doing so can allow for closures and partial applications with these operators. For example, here's a function that subtracts 2 from the parameter: `subtract2 = flip (-) 2`.