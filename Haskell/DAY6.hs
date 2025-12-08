{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE TupleSections #-}
module DAY6 where

import Data.List (transpose)
import Data.Array
import Utils
import Control.Monad.State
import Data.Maybe (mapMaybe)
import Text.Read (readMaybe)

main :: IO ()
main = do
    file <- readFile "../External_Files/day6.txt"
    print $ part1 file                                           -- PART 1: 5877594983578
    print $ evalState (part2 $ cols $ setupGrid file) ('+',[],0) -- PART 2: 11159825706149

part1 :: String -> Int
part1 = sum . map (calculate . reverse) . transpose . map words . lines
    where calculate ([op]:nums) = apply op (map read nums)

--                              op     grp   acc
part2 :: [(Int,Char)] -> State (Char, [Int], Int) Int
part2 [] = gets (\(op,grp,acc) -> acc + apply op grp)
part2 ((num,curOp):cls) = do
    (op,grp,acc) <- get
    if curOp == ' ' then put (op, num:grp, acc) else put (curOp, [num], acc + apply op grp)
    part2 cls

apply :: Char -> ([Int] -> Int)
apply op = if op == '+' then sum else product

cols :: GridArray -> [(Int,Char)]
cols arr = mapMaybe (\c -> (,arr!(n,c)) <$> readMaybe [arr!(r,c) | r <- [0..n-1]]) [0..m]
  where (_,(n,m)) = bounds arr