-- 1: Find last element of a list
myLast [] = error "Empty list does not have a last element"
myLast (x:[]) = x
myLast (x:xs) = myLast xs

-- 2: Find second last element of list
myButLast [] = error "Empty list"
myButLast (x:[]) = error "List of one element has not second last element"
myButLast (x:y:[]) = x
myButLast (x:y:xs) = myButLast (y:xs)

-- 3: Find kth element of list
elementAt (x:xs) 1 = x
elementAt (x:xs) k = 
    if k > 1 && k <= length (x:xs)
        then elementAt (xs) (k-1)
        else error "Invalid k"

-- 4: Find number of elements in list
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

-- 5: Reverse a list
myReverse (x:xs) = myReverseHelper [] (x:xs)

myReverseHelper (x:xs) [] = (x:xs)
myReverseHelper [] (x:xs) = myReverseHelper [x] xs
myReverseHelper (y:ys) (x:xs) = myReverseHelper (x:y:ys) xs

-- 6: Find out if a list is palindromic
isPalindrome [] = True
isPalindrome (x:[]) = True
isPalindrome (x:xs) =
    if x == (myLast xs)
        then isPalindrome (reverse ys)
        else False
    where (y:ys) = (reverse xs) -- remove the last element of the list

-- 7: Flatten a nested list structure
-- data NestedList a = Elem a | List [NestedList a]
-- flatten [] = []
-- flatten (Elem x) = x
-- flatten (List (x:xs)) = flatten x ++ flatten (List (xs))

-- 8: Eliminate consecutive duplicates of a list element
compress [] = []
compress (x:[]) = [x]
compress (x:xs) =
    if x == (head xs)
        then compress (x:(tail xs))
        else x:(compress xs)

-- 9: Pack consecutive duplicates of list elements into sublists
pack :: (Eq a) => [a] -> [[a]]
pack [] = []
pack [x] = [[x]]
pack (x:xs) = packHelper 1 x xs

packHelper :: (Eq a) => Int -> a -> [a] -> [[a]]
packHelper count x [] = [(replicate count x)]
packHelper count x (y:ys) =
    if x == y
        then packHelper (count+1) x ys
        else [(replicate count x)] ++ (pack (y:ys))

-- 10: Run length encoding of list
encode [] = []
encode [x] = [(1, x)]
encode (x:xs) = encodeHelper 1 x xs

encodeHelper count x [] = [(count, x)]
encodeHelper count x (y:ys) =
    if x == y
        then encodeHelper (count+1) x ys
        else [(count, x)] ++ (encode (y:ys))
