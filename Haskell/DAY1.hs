-- module Haskell.DAY1 where
-- import Data.Foldable (foldl')
-- -- This code is unsafe/could err!
-- -- (only meant to be run on a well-formed dial text file)

-- main :: IO()
-- main = do
--     file <- readFile "External_Files/dials.txt"
--     print $ parseDials file

-- -----

-- type State = (Int,Int,Int)

-- getAns :: State -> (Int,Int)
-- getAns (_,p1,p2) = (p1,p2)



-- -----

-- solve :: [Int] -> (Int, Int)
-- solve = getAns . foldl' solve' (50,0,0)
--     where solve' :: State -> Int -> State

-- parseDials :: String -> [Int]
-- parseDials = map parseDial . lines
--     where parseDial :: String -> Int
--           parseDial ('L':step) = read step
--           parseDial ('R':step) = -read step

-- WIP