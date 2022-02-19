# First Class Functions and Sort

**Description:** *using first class functions in sorting tuples*  
**Language**: Haskell

---

## Tuples

Tuples in Haskell:
- can contain multiple types
- is of fixed size

Example: `("Will","Kurt")`  
For "binary" tuples, you can access their first and second element with `fst <tuple>` and `snd <tuple>` respectively.

---

## sort

To use `sort`, you must import it from `Data.list`. *This can be put on top of the file as `import Data.list` or import into GHCi.*

By default, Haskell will sort the tuples in a certain order.
```haskell
names = [("Ian", "Curtis"), ("Bernard", "Summer"), ("Peter", "Hook"), ("Stephen", "Morris")]
sort names
```

To override the sorting algorithm, you can create a custom compare function and use `sortBy` as a first class function. The custom compare function must return values `EQ`, `LT`, and `GT`, which stand for *equal to*, *less than*, and *greater than* respectively. 

Let's say we want to sort by last name.
```haskell
compareLastNames name1 name2 = 
        if lastName1 > lastName2
        then GT
        else if lastName < lastName2
            then LT
            else EQ
    where lastName1 = snd name1
          lastName2 = snd name2

sortBy compareLastNames names
```

To simply even further, anything that can be compare in Haskell can be used in the built-in function `compare` which returns `GT`, `LT`, and `EQ`.

```haskell
compareLastNames name1 name2 =
        compare lastName1 lastName2
    where lastName1 = snd name1
          lastName2 = snd name2
```