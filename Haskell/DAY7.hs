module DAY7 where

import Control.Monad
import Control.Monad.State
import qualified Data.Set as Set
import qualified Data.Map.Strict as Map
import Data.Array
import Utils

main :: IO ()
main = do
    file <- readFile "../External_Files/day7.txt"
    let arr = setupGrid file
        (_,b@(_,m)) = bounds arr
        startPos = (0, (m+1) `div` 2)
    print $ evalState (simulate b arr) (SimState (Set.singleton startPos) (Map.singleton startPos 1) 0 1)
    -- PART 1: 1658, PART 2: 53916299384254

type Pos = (Int,Int)
data SimState = SimState {beams :: Set.Set Pos, ways :: Map.Map Pos Int, split :: Int, paths :: Int}

simulate :: (Int,Int) -> GridArray -> State SimState (Int, Int)
simulate bds grid = do
    bSet <- gets beams
    if Set.null bSet then gets (\st -> (split st, paths st))
    else do
        let (b,rest) = Set.deleteFindMin bSet
        newBeams <- processBeam bds grid b
        modify $ \st -> st {beams = Set.union (Set.fromList newBeams) rest}
        simulate bds grid

processBeam :: (Int,Int) -> GridArray -> Pos -> State SimState [Pos]
processBeam (h,w) grid pos@(y,x) = do
    let y1 = y+1; p = (y1,x)
    wxy <- gets $ Map.findWithDefault 0 pos . ways
    if y1 >= h then modify (\st -> st {paths = paths st + wxy}) >> return []
    else if grid ! p == '^' then do
        modify $ \st -> st {split = split st + 1}
        let newPos = [(y1,x') | x' <- [x-1,x+1], x'>=0, x'<w]
        forM_ newPos $ addWays wxy
        return newPos
    else addWays wxy p >> return [p]

addWays :: Int -> Pos -> State SimState ()
addWays n p = modify $ \st -> st {ways = Map.insertWith (+) p n (ways st)}