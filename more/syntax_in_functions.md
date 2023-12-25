# Syntax in Functions

- **patern matching** : specify patterns data should conform/deconstruct to
    - make separate function bodies for different patterns 
    - **matching goes from top to bottom**
    - tips:
        - specific patterns (edge conditions e.g. empty list) first then general
        - always include catch-all otherwise `non-exhaustive patterns` error
    - can do pattern matching for tuples and in list comprehension (e.g. `(x,y)`)

- **as patterns** : put name and `@` in front of pattern, acts like an alias
    - e.g. `all@(x:xs) = ... all ...`
    - when using whole thing again in function without having to retype the pattern

- **guards**
    - make sure values have a certain property
    - more readable and good for pattern matching than `if`
    - guards evaluates to a boolean
    - if no `otherwise` than evaluation falls through to next pattern

```haskell
bmiTell bmi  
    | bmi <= 18.5 = "You're underweight, you emo, you!"  
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"  
    | otherwise   = "You're a whale, congratulations!"
```
    
- define functions as infix with backticks

- `where`
    - when defining multiple `where` clauses, they must be aligned in a single column otherwise Haskell gets confused
    - pattern match
        - e.g. `where (skinny, normal, fat) = (18.5, 25.0, 30.0)`
    - can define functions in `where` bindings
    - syntactic constructs

```haskell
describeList xs = "The list is " ++ what xs  
    where what [] = "empty."  
          what [x] = "a singleton list."  
          what xs = "a longer list." 
```

- `let`
    - bind variables anywhere cause they're expressions themselves
    - local, doesn't span across guards (only accesible after the `in` part)
    - syntax: `let <bindings> in <expression>`
    - can be used anywhere
        - expressions: `4 * (let a = 9 in a + 1) + 2`
        - functions in local scope: `[let square x = x * x in (square 5, square 3, square 2)]`
    - use a semicolon for multiple variables: `(let a = 100; b = 200; c = 300 ...)`
    - can be used in list comprehension as a predicate
        - instead of filtering, it binds the names
        - names are visible to output function (before the `|`) and all predicates after the `let`
        - don't need `in` part since visibility is already defined, but can still be used to limit the visibility to just the `in` expression
    - omitting `in` in GHCI would make the binding visible throughout the entire session

```haskell
cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2  
    in  sideArea + 2 * topArea
```

- `case`
    - expressions
    - like pattern matching for parameters in function definitions (just syntactic sugar)

```haskell
case expression of
    pattern -> result
    ...
```
    - can be used anywhere (useful when pattern matching in the middle of an expression)

```haskell
describeList :: [a] -> String  
describeList xs = "The list is " ++ case xs of [] -> "empty."  
                                               [x] -> "a singleton list."   
                                               xs -> "a longer list." 
```

