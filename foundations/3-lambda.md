# 3. Lambda Functions

The main purpose of lambda functions is as *anonymous functions*. In the situations where creating an intermediate function is overhead, this is where a lambda function can take over. 

## Example of a lambda function
```haskell
--parameter: x
--return: x + 2
--input: 1
ghci>(\x -> x + 2) 1    -> 3
```

## `where` in the form of lambdas

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

## `let` expression

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

## Lexical scope

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