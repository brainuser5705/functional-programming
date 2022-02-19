# 1. Function

The use of functions in functional programming follows the definition of functions in mathematics. A function can be thought of as taking in an input and producing an output, with the constraint that for any input, it must always product the same output. This constraint has stuck along in functional programming as well. 

## Requirements of a function
A function should always
1. Take in an argument (a.k.a take an input)
2. Return a value
3. Return the same value for the same input (called **referential transparency**)

## Example of a function
```haskell
--function name: add2
--parameter: x
--function return: x + 2
add2 x = x + 2

ghci>add2 1     -> 3
```
---