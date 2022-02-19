# 2. `where` clause

A key thing about functional programming that differs from imperative programming is that you cannot redefine variables. For example, the below program will not compile:
```haskell
x = 1
x = 2
```
```
PS C:\Users\codeu\Desktop\functional-programming> ghc test.hs
[1 of 1] Compiling Main             ( test.hs, test.o )

test.hs:2:1: error:
    Multiple declarations of `x'
    Declared at: test.hs:1:1
                 test.hs:2:1
  |
2 | x = 2
  | ^
```

Why cannot you not redefine variables?

---

The `where` clause provides a semantic flow when assigning values that shows the parallel of Haskell functions with mathematical definitions. For example,
> To find the new price of an item, given its discount percentage and price, subtract the discount amount with price, **where** discount amount is the discount percentage multiplied with the price.

can be directly translated as

```haskell
getNewPrice percentage price = 
    price - discount
    where discount = percentage * price
```

Another use for the `where` clause is it reduces reduancy (like variables in other language paradigms). Here's an example.

```haskell
getLetterGrade grade curve = 
    if grade + (curve)  >= 90
    then "A"
    else if grade + (curve) >= 80 && grade + (curve) < 90
    then "B"
    else if grade + (curve) >= 70 && grade + (curve) < 80
    then "C"
    else "F"
```       

This program re-computes the new grade for each condition. Just as variable assignment in imperative programming, you can use the `where` clause:

```haskell
getLetterGrade grade curve = 
    if newGrade >= 90
    then "A"
    else if newGrade >= 80 && newGrade < 90
    then "B"
    else if newGrade >= 70 && newGrade < 80
    then "C"
    else "F"
    where newGrade = grade + (curve)
```

---

## Referential Transparency in Depth


## References
- https://www.sitepoint.com/what-is-referential-transparency/#referentialtransparencyinprogramming
- https://cs.stackexchange.com/questions/143180/why-do-functional-languages-disallow-reassignment-of-local-variables
---