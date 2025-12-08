{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
module DAY2 where

import Data.List.Split (splitOn)
import Text.Regex.PCRE

main :: IO()
main = do
    file <- readFile "../External_Files/day2.txt"
    print $ checkRanges (splitOn "," file)

pattern1, pattern2 :: String
pattern1 = "^(\\d+)\\1$"
pattern2 = "^(\\d+)\\1+$"

checkRanges :: [String] -> (Int,Int)
checkRanges = foldr ((<++>) . checkRange) (0,0)

(<++>) :: (Num a) => (a,a) -> (a,a) -> (a,a)
(x,y) <++> (z,w) = (x+z,y+w)

checkRange :: String -> (Int,Int)
checkRange str = (count pattern1, count pattern2)
  where
    (a,_:b) = break (== '-') str
    range = [(read a :: Int)..(read b :: Int)]
    count pt = sum (filter (\x -> show x =~ (pt :: String)) range)