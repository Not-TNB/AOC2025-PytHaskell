module Utils where

import Data.Array

type GridArray = Array (Int,Int) Char
type RowArray = [Array Int Char]

setupGrid :: String -> GridArray
setupGrid str = array ((0,0),(n-1,m-1)) $ zip (liftA2 (,) [0..n-1] [0..m-1]) (concat g2D)
    where g2D  = lines str   
          n    = length g2D
          m    = if null g2D then 0 else length (head g2D)

setupRows :: String -> RowArray
setupRows str = [listArray (0, length row - 1) row | row <- lines str]

ngbrs :: (Ix i, Enum i, Num i) => Array (i,i) e -> (e -> Bool) -> (i,i) -> Int
ngbrs arr p (i,j) = length [ () | (rr,cc) <- liftA2 (,) [i-1..i+1] [j-1..j+1]
                                , inRange (bounds arr) (rr,cc)
                                , p (arr!(rr,cc))]


coords :: (Ix i, Enum i) => Array (i,i) e -> [(i,i)]
coords arr = liftA2 (,) [r0..rn] [c0..cn] where ((r0,c0),(rn,cn)) = bounds arr