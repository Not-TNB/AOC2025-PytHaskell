{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE TupleSections #-}
module DAY6 where

import Data.List (transpose)
import Data.Array
import Utils
import Data.Char (isSpace)

main :: IO ()
main = do
    file <- readFile "../External_Files/day6.txt"
    let arr = setupGrid file
    print $ part1 file
    print $ part2 arr

part1 :: String -> Int
part1 = sum . map (calculate . reverse) . transpose . map words . lines
    where calculate ("+":nums) = sum (map read nums)
          calculate ("*":nums) = product (map read nums)

part2 :: GridArray -> Int
part2 arr = go initCol initOp 0 0
    where
        (_,(n,m)) = bounds arr
        initCol@(_,_,initOp) = extract 0
        extract :: Int -> (Int,Int,Char)
        extract col
            | all isSpace nums = (col,-1,' ')
            | otherwise = (col, read nums, arr!(n,col))
            where nums = map ((!) arr . (,col)) [0..n-1]
        go :: (Int,Int,Char) -> Char -> Int -> Int -> Int
        go (col,-1 ,_  ) op grp acc = go (extract (col+1)) op grp acc
        go (col,num,' ') op grp acc 
            | col == m  = acc + (num <+*> grp)
            | otherwise = go (extract (col+1)) op (num <+*> grp) acc
            where (<+*>) = if op=='+' then (+) else (*)
        go (col,num,op) _ grp acc = go (extract (col+1)) op num (grp+acc)