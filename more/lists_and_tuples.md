# List Comprehension

Structure:
`[ expression | var <- list, predicate1, predicate2, ...]`

Examples are taken from ["Learn You a Haskell for Great Good!"](http://learnyouahaskell.com/starting-out#im-a-list-comprehension)
```haskell

-- first ten even numbers (`<-`` means binding first ten numbers to `x`)
[x*2 | x <- [1..10]]

-- adding a predicate (aka filtering)
[x*2 | x <- [1..10], x*2 >= 12]

-- passing in a list to bind to
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

-- multiple predicates
[ x | x <- [10..20], x /= 13, x /= 15, x /= 19]

-- two lists to bind to
-- goes through all possible combinations of the elements
[ x*y | x <- [2,5,10], y <- [8,10,11], x*y > 50]

-- working with inner lists
[ [ x | x <- xs, even x ] | xs <- xxs]
```

# Tuples
- know exact number of elements
- type depends on how many and type of components
    - each different size of tuple is its own type
- can be hetergenous

- **pair**: tuple of size two, **triple**: size 3
- no singleton tuple

- can compare tuples but must be the same size

- `fst` and `snd` for tuple pairs