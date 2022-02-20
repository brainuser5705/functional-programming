myMap function [] = []
myMap function (x:xs) = [function x] ++ myMap function xs

myFilter function [] = []
myFilter function (x:xs) = if function x
                           then x:(myFilter function xs) 
                           else (myFilter function xs)

remove function [] = []
remove function (x:xs) = if function x 
                         then remove function xs 
                         else x:(remove function xs)

myFoldl binFunc init [] = init
myFoldl binFunc init (x:xs) = myFoldl binFunc newValue xs
    where newValue = (binFunc init x)

-- using foldl to reverse a list

-- rcons [] = []
-- rcons (x:xs) = rcons xs ++ [x]

rcons x y = y:x -- firs parameter must be a list, and the second must be an element
myReverse xs = foldl rcons "" xs

myFoldr f init [] = []
myFoldr f init (x:xs) = []



