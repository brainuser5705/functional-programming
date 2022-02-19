# 6. List

List is the *fundamental data structure* of functional programming.

It is inherently recursive i.e. it is either:
- an empty list `[]`
- or an element followed by another list

## Anatomy 

The main pieces of a list are 
1. `head` - the first element
2. `tail` - the rest of the list after the head

Important notes:
- The tail of a single element list is `[]`. 
- An empty list has no `head` or `tail`.

## Constructing lists

To construct a list, you need the `:` infix operator called **cons**, short for *constructing*. The actual operation is call **consing**.

For consing, you need a value and a list.
```haskell
ghci> 1:[] --returns [1]
ghci> [1]
ghci> 1:[2,3,4] --returns [1,2,3,4]

```
> Syntatic sugar: Haskell lists are essentially cons operations.

Strings in Haskell are syntatic sugar as well! They are inherently a *list of characters*. `"sugar"` is the same thing as `s: ['u', 'g', 'a', 'r']` or `'s':"ugar"` or `'s':'u':'g':'a':'r':[]`. Note that it is not the same thing as `"s":"ugar"`.

To concatenate two lists, you would the `++` infix operator.

## Lazy Evaluation

To generate a list of values:
```haskell
ghci> [1..10] -- returns a list from 1 to 10 inclusive
ghci> [1,3..10] -- list of odd numbers for 1 to 10
ghci> [1,0..-10] -- decrementing 
ghci> [1..] -- an infinite list!
```
The reason why Haskell does not get stuck evaluate `[1..] ` is because of **lazy evaulation**: no code is evaluated until it is needed.

## Common functions

These functions are built into the Haskell's standard library module: `Prelude`.

1. `!!` - access element in a list
    - infix operator
```haskell
ghci> [1,2,3] !! 0 -- returns 1
ghci> (!!) "puppies" 4 -- returns 4
ghci> [1..10] !! 11 -- returns index too large error
```

> Using prefix notation makes using partial application easier. To use partial applications with infix operators (called sections), you need to wrap it around (): `("dog" !!)`. You can also create a partial application for the left side: `(!! 2)`.

2. `length` 
```haskell
ghci> length [1..10] --returns 10
```

3. `reverse`

4. `elem` - checks if a value is an element of the list
```haskell
ghci> elem 3 [1..10] --returns True
```

> You can turn a binary function like `elem` into an infix operator by surrounding it with backticks (\`): 3 \`elem\` 2

5. `take` - retuns the first nth element of the list
    - returns the elements as a list
    - if you ask for more than it can give, it will just give you want it can
```haskell
ghci> take 4 [1..10] -- returns [1,2,3,4]
ghci> take 3 "hi" -- returns "hi"
```

6. `drop` - removes the first nth element of the list
    - use is similar to `take`

7. `zip` - combine two lists into *tuple pairs*
    - if one list is longer, than it stops when a list is used up
```haskell
ghci> zip [1..10] "abc" --returns [(1,'a'), (2,'b'), (3,'c')]
```

8. `cycle` - repeats a list endlessly
    - uses lazy evaluation to create the list
```haskell
ghci> cycle [1] -- returns [1,1,1,...]

ones n = take n (cycle [1]) -- function that makes a list of 1s

-- split list into n groups
divideGroup list n = zip list (cycle [1..10])
```

All list functions are included in `Data.list` module.








