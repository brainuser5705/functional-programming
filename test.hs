-- myMap function [] = []
-- myMap function (x:xs) = [function x] ++ myMap function xs

-- myFilter function [] = []
-- myFilter function (x:xs) = if function x
--                            then x:(myFilter function xs) 
--                            else (myFilter function xs)

-- remove function [] = []
-- remove function (x:xs) = if function x 
--                          then remove function xs 
--                          else x:(remove function xs)

-- myFoldl binFunc init [] = init
-- myFoldl binFunc init (x:xs) = myFoldl binFunc newValue xs
--     where newValue = (binFunc init x)

-- -- using foldl to reverse a list

-- -- rcons [] = []
-- -- rcons (x:xs) = rcons xs ++ [x]

-- rcons x y = y:x -- firs parameter must be a list, and the second must be an element
-- myReverse xs = foldl rcons "" xs

-- myFoldr f init [] = []
-- myFoldr f init (x:xs) = []

-- chain 1 = [1]
-- chain n
--     | even n    = n:chain (n `div` 2)
--     | otherwise = n:chain (3*n + 1)

-- numLongChains = length (filter isLong (map chain [1..100]))  
--     where isLong xs = length xs > 15  

insertionSort [] = []
insertionSort ys = insertionSortHelper [] ys
    
insertionSortHelper (x:xs) [] = (x:xs)
insertionSortHelper [] (y:ys) = insertionSortHelper [y] ys
insertionSortHelper xs (y:ys) = insertionSortHelper (place xs y) ys
    
place [] y = [y]
place xs y =
    let e = last xs
    in
        if e < y
            then xs ++ [y]
            else (place (init xs) y) ++ [e]