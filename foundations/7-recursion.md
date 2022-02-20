# 7. Recursion

## Steps on how to write a recursive function
1. Identify end goal(s)
    - how do you know you are finish?
2. Determine what happens when goal is reach
    - what do you return at the finish?
3. List all alternate possibilities
    - what can you do if you aren't at the goal state
4. Rinse and repeat
5. Ensures each alternative moves you toward the goal

Here is an example with Euclid's GCD algorithm:
```haskell
gcdFunction a b = 
    if remainder == 0 -- goal state
    then b -- what happens when goal is reached
    else gcdFunction b remainder -- alternate possibilities, rinse and repeat
        where remainder = a `mod` b
```

The trick is to think in terms of pattern. Split the function into goal patterns and alternative patterns.

## Pattern matching

To reduce the amount of `if then else` expressions for more complex recursive problems, Haskell has a feature called **pattern matching** which allows you to peek at the arguments and pass accordingly.

```haskell
sayAmount n = case n of
    1 -> "one"
    2 -> "two"
    _ -> "bunch"
```
is the equivalent of 
```haskell
sayAmount 1 = "one"
sayAmount 2 = "two"
sayAmount _ = "bunch"
```

Notes about pattern matching: 
- The pattern matching is done in order. 
- One restriction is that pattern matching cannot compute anything in the parameter, i.e. you cannot check it against conditionals.
- It is standard to use `_` for values that aren't used.

### Pattern matching with lists
- It is popular convention to denote lists as `x:xs`.

For values that have no valid returns, you can use the `error` function:
```haskell
myHead (x:xs) = x -- can alos be written as myHead (x:_) as the tail is not needed
myHead [] = error "Empty list does not have a head"
```

Here is Euclid's algorithm with pattern matching:
```haskell
gcdFunction b 0 = b
gcdFunction a b = gcdFunction (b) (mod a b)
```
