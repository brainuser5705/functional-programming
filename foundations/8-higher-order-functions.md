# 8. Higher-order Functions

A **higher-order** function is any function that takes another function as an argument. They are used to abstract away the common patterns of recursion.

## `map`
`map` takes a function and a list and applies the function to each element in the list
```haskell
map reverse ["hi","there"] -- returns ["ih","ereht"]
```
- Cleaner for loop as you can change the function that is being passed in and makes it more readable

Here is the common pattern that it abstracts:

```haskell
myMap function [] = []
myMap function (x:xs) = [function x] ++ myMap function xs
```

## `filter`

`filter` is similar to map in that it applies a function to each element in a list, however the function must return `True` or `False`. It will keep only the elements that return `True`.

```haskell
filter even [1..10] -- returns [2,4,6,8,10]
```

Here is the common pattern that it abstracts:
```haskell
myFilter function [] = []
myFilter function (x:xs) = if function x
                           then x:(myFilter function xs) 
                           else (myFilter function xs)
```

Note that the operations can be conditional checks! For example, this filters out the spaces of a string:
```haskell
filter (/= ' ') string 
```

## `foldl`

`foldl` takes a *binary* function, a initial value, and a list and "folds" it into one single value.

```haskell
foldl (+) 0 [1..10] -- note that the parantheses are necessary
55
```
Essentially, it performs the binary function on the initial value and the head of the list, then repeats again for the rest of the values in the list with the result of the operation being the new initial value.

Abstract pattern:
```haskell
myFoldl binFunc init [] = init
myFoldl binFunc init (x:xs) = myFoldl binFunc newValue xs
    where newValue = (binFunc init x)
```

```haskell
-- functions that concats all elements in a list
concatAll xs = foldl (++) "" xs
```

## `foldr`

Takes the same parameters as `foldl`, but instead it compacts into the right argument of the binary function.

```haskell
foldl (-) 0 [1,2,3,4] -- returns -10
foldr (-) 0 [1,2,3,4] -- returns -2
```

```haskell
myFoldr f init [] = init
myFoldr f init (x:xs) = f x newValue
  where newValue = (myFoldr f init xs)
```

The results differ from `foldl` depending on the operation.

There's also another fold operation called `foldl'` which is the nonlazy version of `foldl`.
