module DAY7 where

import Control.Monad  
import Control.Monad.ST 
import Data.STRef   
import qualified Data.HashTable.ST.Basic as HT

import Data.Array
import Utils

main :: IO ()
main = do
    file <- readFile "../External_Files/day7.txt"
    let arr = setupGrid file
    print $ simulate arr

type Pos = (Int, Int)  -- (x, y)

simulate :: GridArray -> (Int, Int)


-- def simulate(manifold):
--     h, w = len(manifold), len(manifold[0])
--     beams: Set[Tuple[int,int]] = {start := (grid[0].index('S'),0)} # init with the start beam pos
--     ways = defaultdict(int)
--     ways[start] = 1
--     split = paths = 0
--     while beams:
--         new = set()
--         for (x,y) in beams:
--             if (y1:=y+1)>=h: 
--                 paths += ways[(x, y)]
--             elif manifold[y1][x]=='^':
--                 split += 1
--                 for x1 in (x-1,x+1): 
--                     if 0<=x1<w: 
--                         ways[(x1,y1)] += ways[(x,y)]
--                         new.add((x1,y1))
--             else: 
--                 ways[(x,y1)] += ways[(x,y)]
--                 new.add((x,y1))
--         beams = new
--     return split, paths

-- print(simulate(grid)) # PART 1: 1658, PART 2: 53916299384254