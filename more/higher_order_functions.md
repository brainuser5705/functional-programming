# Higher order functions

## Curried functions
- all functions take one parameter
- e.g. `max 4 5` creates a function that takes a parameter and returns either that parameter or `4` depending on which one is bigger. Then `5` is applied to that function to produce the final result
    - equivaluent to `(max 4) 5`

- putting space between things is **function application**
    - highest precedence
    - `max :: (Ord a) => a -> a -> a` same as `max :: (Ord a) => a -> (a -> a)`, which is why return type and parameters are both separated by arrow

- **partially applied function** : function that takes as many parameters as we left out in when calling a function with too few parameters
    - create functions on the fly to pass into another function or use with some data

- partially applied infix functions by using *sections*
    - e.g. `divideByTen = (/10)` returns a function that applies one parameter and applies it to the side that is missing an operand
    - note that `(-4)` is negative four, for subtract use `subtract`

## Maps and filters
- `map`: takes in a function and a list, and applies the function to each element of the list
    - `map f (x:xs) = f x : map f xs`
- `filter`: takes in a predicate (function returning boolean) and a list, returns elements of the list that satisfies the predicate
    - can join predicates with `&&`
- laziness means that calling `map`/`filter` multiple times on a list only traverses the list once
    - if we use `head` on a filtered list, the evaluation stops when the first adequate solution is found (it doesn't create the entire list first)
    - we can do it over an infinite list but it won't do it right away
- `takeWhile` takes a predicate and list, and takes elements from the beginning until predicate fails
    - in place of `filter` since it doesn't work on infinite lists

## Lambdas
- usually make lambdas to pass into a higher-order function
- `(\p1 p2 ... -> function_body)`
- lambdas are expressions
- don't use lambdas if a partially applied function can be used
- can pattern match, but cannot define several patterns for the same parameter
    - if no pattern matches, then there will be a runtime error
- lambdas are normally surrounded by parenthese unless they are extended all the way to the right
    - e.g. `\x -> \y -> \z -> x + y + z`

## Folds
- common recursive pattern: base case for empty list, then a `x:xs` pattern that does an action to a single element and the rest of the list
- like `map` but reduce list to a single value
- how does it work:
    - takes a binary function, initial value (accumulator), and a list to fold up
    - binary is called with accumulator and first/last element to produce new accumulator
    - binary function called again with new accumulator
- `foldl` folds list up from left side
    - has accumlator as the first parameter and current value as second (`\acc x -> ...`)
- `foldr`
    - current value as first parameter, accumulator as second (`\x acc -> ...`)
- use folds whenever you want to traverse a list and return something
- `foldl1` and `foldr1` don't require explicit start value, it assumes that the first/last element will be the starting value
    - does not work with empty lists unlike `foldl`/`foldr`, so use if it doesn't make sense to use the function with an empty list
- another way to picture for list `[3,4,5,6]`, `f` binary function and starting value `z`
    - right fold: `f 3 (f 4 (f 5 (f 6 z)))`
    - left fold: `g (g (g (g z 3) 4) 5) 6`
- `scanl`, `scanr`
    - report all intermediate accumulator states as a list
    - `scanl1`, `scanr1`
    - `scanl`: final result is the last element of resulting list, `scanr`: result in the head

## Function application with $
- `$` function application
- `f $ x = f x`
- a normal function application (space) has high precedence and left-associative (e.g `f a b c` -> `((f a) b) c`)
- `$` has lowest precedence and right associative 
- mostly used as convenience function so we don't have to write so many parentheses
    - e.g. `sqrt (3 + 4 + 9)` required parentheses otherwise it will add the square root of 3, `sqrt $ 3 + 4 + 9` doesn't since `$` has the lowest precedence
    - expression on right is applied as parameter to function on the left
- treat as any other function
    - `map ($ 3) [(4+), (10*), (^2), sqrt]`

## Function composition
- `.` function
- `f . g = \x -> f (g x)`
- type declaration: `(.) :: (b -> c) -> (a -> b) -> a -> c`
    - function f's parameter must be the same type as g's return type
    - applies g first, then f
- use for making functions on the fly
    - can be more concise than lambdas
    - e.g. `(\x -> negate (abs x))` -> `(negate . abs)`
    - can apply multiple functions
        - e.g. `negate . sum . tail`
    - for functions that take more than one parameter, you need to partially apply them so each function only takes one parameter
        - e.g. `sum (replicate 5 (max 6.7 8.9))` -> `(sum . replicate 5 . max 6.7) 8.9`
        - the `8.9` is applied to `max`
    - number of parentheses roughly translates to the same number of function compsitions
- use for *point free style* aka *pointless style*
    - paramters can be omitted because of currying e.g. `sum xs = foldl (+) 0 xs` is the same as `sum = foldl (+) 0` (pointless style)
    - `fn x = (tan (cos max 50 x))` can be rewrite as `tan . cos . max 50`
- don't overuse it to make long chains of function composition, preferred style is to use `let` bindings for intermediate results and split into subproblems
