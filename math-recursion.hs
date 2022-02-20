-- ackerman m n =
--     if m == 0
--     then n + 1
--     else if n == 0
--     then ackerman (m-1) 1
--     else ackerman (m-1) (ackerman m (n-1))

ackerman 0 n = n + 1
ackerman m 0 = ackerman (m-1) 1
ackerman m n = ackerman (m-1) (ackerman m (n-1))

-- collatz n = 
--     if n == 1
--     then n 
--         else if even n 
--         then collatz n/2
--             else collatz n*3 + 1

collatz 1 = 1
collatz n = if even n
            then 1 + collatz (n `div` 2)
            else 1 + collatz (n*3 + 1)

fastFib n1 _ 1 = n1 
fastFib _ n2 2 = n2
fastFib n1 n2 n = fastFib n2 (n1+n2) (n-1)