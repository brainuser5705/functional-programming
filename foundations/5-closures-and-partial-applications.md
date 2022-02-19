# 5. Closures and Partial Applications

## Closures - creating functions with functions

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

## Partial Applications

A more refined simplification without the explicit prescence of lambda functions is built into Haskell as **partial applications**.

Using the previous example, we don't even need to create a `genIfEven` function with closure `f`! Partial application will take care of the missing parameter for us. In this case, `ifEvenInc` will be waiting for the remaining parameter `n`.

```haskell
ifEvenInc = ifEven inc

ghci> ifEvenInc 4 -- returns 5
```

> Note about closures and partial applications: order the parameters from most general to least general. 

## Flipping Arguments

Because you want to order your parameters from most general to least general when using partial applications, there comes situations where the order is not correct and the parameters must be *flipped*.

Here is a lambda expression that can fix this issue:
```haskell
flipBinaryArgs f = (\x y -> f y x)
```
In fact, Haskell has its own operator `flip` that does the same thing.

> Haskell allows you to treat infix operators (+, -, *, /, etc.) as a prefix function: `2 + 3` -> `(+) 2 3`. Doing so can allow for closures and partial applications with these operators. For example, here's a function that subtracts 2 from the parameter: `subtract2 = flip (-) 2`.