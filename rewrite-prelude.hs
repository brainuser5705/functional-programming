import Distribution.Simple.Utils (lowercase)
myTake 0 _ = [] 
myTake _ [] = [] -- two base cases
myTake n (x:xs) = x : (myTake (n-1) xs)

myLength [] = 0
myLength (x:xs) = 1 + myLength xs

myCycle (x:xs) = x : (myCycle (xs ++ [x] ) )

myReverse [] = []
myReverse (x:xs) = (myReverse xs) ++ [x]

myDrop 0 xs = xs
myDrop _ [] = []
myDrop n xs = myDrop (n-1) (tail xs)

-- use filter and length to recreate elem
myElem value xs = length (filter (\x -> x == value) xs) == 1

-- use map and filter to recognize palindrome
-- isPalindrome xs = filterString == reverse filterString
--     where filterString = map toLower noSpace
--           noSpace = (filter (\x -> x /= ' ') xs)

-- haromonic series with lazy evaluation
harmonic n = foldl (+) 0 (map (1 /) [1..n]) -- partial applications!