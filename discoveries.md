# 2/17/2022 - Preprocessor?

I am writing examples for `foundations.md` and landed upon an interesting nuane with GHCi. 

Here is the program:

```haskell
getLetterGrade grade curve = 
    if grade + curve  >= 90
    then "A"
    else if grade + curve >= 80 && grade + curve < 90
    then "B"
    else if grade + curve >= 70 && grade + curve < 80
    then "C"
    else "F"
```

It is a simple program that adjusts the given grade by the curve. If **the curve is negative**, it should obviously subtract from the grade. However such input produces this error:

```haskell
ghci> getLetterGrade 90 -1

<interactive>:14:1: error:
    * No instance for (Show (Integer -> String))
        arising from a use of `print'
        (maybe you haven't applied a function to enough arguments?)
    * In a stmt of an interactive GHCi command: print it
```

In order to make it run, I need to put `(-1)`.
```haskell
ghci> getLetter 90 (-1)
"B"
```
**Note that change `curve` to `(curve)` in the source code does not solve this.**

## Solution

GHCi sees `-` as the negate binary operator.

---

# 2/19/22

First instance of Haskell compiler spotting logical error!
```haskell
collatz n = 
    if n == 1
    then "done!"
    else if (n `mod` 2 == 0)
        then collatz n `div` 2
        else collatz 3*n + 1
```
The return value `"done"` is not valid and must be replace with a numeric value.

```haskell
collatz n = 
    if n == 1
    then n 
        else if even n 
        then collatz n/2
            else if odd n 
            then collatz n*3 + 1
```
This is not valid because it needs an explicit `else` expression.

---

# 12/20/23

- Function application has the highest precedence.
- We can take a biparameter function and turn it to an infix function (e.g. `div 92 10` = `92 \`div\` 10`
    - note that `/` and `div` are no the same, `div` is integer division

- Functions don't need to be in any particular order
- `else` statement is mandatory because the `if` statement is an expression and expression always returns something, meaning we can do something like `(if x > 100 then x else x*2) + 1  `
- function with no parameters is a *defintion/name* e.g. `x = 2` or `let x = 2`
- functions cannot begin with uppercase letters

- unlike C, characters are not numbers

- lists can be compared in lexiographical order
