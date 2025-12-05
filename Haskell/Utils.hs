module Utils where

import Data.Array
import Data.List.Split

type GridArray = Array Int Char
setupGrid :: String -> (Int, Int, GridArray)
setupGrid grid = (n,m,gridArr)
    where grid2D = splitOn "\n" grid
          n = length grid2D
          m = length (head grid2D)
          gridArr = listArray (0, n*m-1) $ concat grid2D