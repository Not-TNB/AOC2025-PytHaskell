{-# LANGUAGE TypeApplications #-}
module DAY5 where

import Data.List.Split (splitOn)
import Data.List (sortOn)

main :: IO ()
main = do
    file <- readFile "../External_Files/day5.txt"
    let (rs,qs) = parseInput file
        rs' = mergeRanges rs
    print $ length (filter (\q -> any (\(b,e) -> b<=q && q<=e) rs') qs) -- PART 1: 529
    print $ sum (map (\(b,e) -> e-b+1) rs')                             -- PART 2: 344260049617193

parseInput :: String -> ([(Int,Int)], [Int])
parseInput file = (map parseRange rsStr, map (read @Int) qsStr)
    where [rsStr, qsStr] = splitOn [""] (lines file)
          parseRange s = let [a,b] = splitOn "-" s in (read a, read b)

mergeRanges :: [(Int,Int)] -> [(Int,Int)]
mergeRanges = foldl step [] . sortOn fst
  where step [] r = [r]
        step acc@((b1,e1):rest) (b2,e2)
            | e1 >= b2 - 1 = (b1, max e1 e2) : rest
            | otherwise    = (b2, e2) : acc