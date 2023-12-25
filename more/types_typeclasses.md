# Type

- Haskell is **statically typed** - the type of every expression is known at compile time for safer code

- Haskell also has **type inference** - we don't have to explicitly define the type in the code

- `:t <expression>` - tells us the type of the expression
    - returns `<expression> :: <type>`
    - `::` "has a type of"
    - all explicit types start with capital letter

- functions can have types, and we can give them **explicit type declaration**
    - e.g. `reverse :: [Char] -> [Char]` means it maps from string to string
    - for multiple parameters: `addThree :: Int -> Int -> Int -> Int`

- tuples have types too
    - empty tuple `()` is a type

- `a` is a **type variable** and can be *any type*
    - functions with type variables are **polymorphic functions**
    - `a`, `b`, `c`, ...
    - e.g. `fst :: (a,b) -> a`

# Typeclasses 101

- interface
    - if type is part of typeclass, it supports and implements behavior the typeclass describes

- any equation of only special charactes is a infix function by default
    - to use as prefix, must wrap in parentheses

- e.g. `(==) :: (Eq a) => a -> a -> Bool`
    - before `=>` is **class constraint**
    - the types of `a` must be members of the `Eq` class (provides interface for testing equality - all standard types are part of the class)
    - multiple class constraints separated by commas

- Basic typeclasses
    - `Eq` : support equality testing
        - all members implement `==` and `/=` (not equal)
    - `Ord` : ordering
        - member must be part of `Eq`
    - `Show` : can be presented as a string
        - `show` takes value whose type is member of `Show` and present as string
        - e.g `show 3` => `"3"`
    - `Read` : opposite of `Show`
        - `read` function takes string and returns type which is member of `Read`
        - e.g. `read "True" || False` => `True`
        - whenever we use `read`, we use it did something with the result afterward so GCHI can infer what type to return
            - e.g. `read "4"` would cause an error, it know we want a type that is part of the `Read` class but doesn't know which type
        - to fix, we could use **type annotations** (explicitly saying what the type of an expression should be)
            - add `::` at the end of an expression
            -e.g. `read "5" :: Int` => `5`
    - `Enum` : sequentially ordered types
        - can be used in list ranges
        - defined successors (`succ`) and predecessors (`pred`)
    - `Bounded`: upper and lower bound
        - e.g. `minBound :: Int`, `maxBound :: Char`
        - type of `(Bounded a) => a`: polymorphic constants (can be of multiple types)
        - tuples are part of `Bounded` if components are also in it
        - e.g. `maxBound :: (Bool, Int, Char)`
    - `Num` : numeric typeclass
        - members have property of being to ack like numbers (`Int`, `Integer`, `Double`, `Float`)
        - `(*) :: (Num a) => a -> a -> a` must have the same type for both numbers so `(5 :: Int) * (6 :: Integer)` would result in an error
    - `Integral` : only integral whole numbers (`Integer`, `Int`)
    - `Floating` : only floating numbers (`Float`, `Double`)
        - `fromIntegral :: (Num b, Integral a) => a -> b` to convert integral to more general number
        - useful when using `length` which only returns an `Int`