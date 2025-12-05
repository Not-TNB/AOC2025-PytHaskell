{-# LANGUAGE TupleSections #-}
module DAY4 where
import Control.Monad.State
import Data.Array
import Utils

main :: IO ()
main = do
    file <- readFile "../External_Files/day4.txt"
    let (n,m,gridArr) = setupGrid file
        initState = (0, gridArr)
    print $ evalState (removePaperArray n m gridArr) initState
    print $ evalState (part2Array       n m gridArr) initState

type GridState = (Int, GridArray)  -- (total removed, current grid)

toRemoveIdxs :: Int -> Int -> GridArray -> [Int]
toRemoveIdxs n m grid =
    [ idx | i <- [0..n-1], j <- [0..m-1], let idx=i*m+j
    , grid ! idx == '@', length [ () | (rr,cc) <- liftA2 (,) [i-1,i,i+1] [j-1,j,j+1]
                       , rr >= 0 && rr < n && cc >= 0 && cc < m
                       , grid ! (rr*m+cc) == '@'] <= 4 ]

removePaperArray :: Int -> Int -> GridArray -> State GridState Int
removePaperArray n m grid = do
    (tot, _) <- get
    let removeIdx = toRemoveIdxs n m grid
        removed = length removeIdx
    put (tot + removed, grid // map (, '.') removeIdx)
    return removed

part2Array :: Int -> Int -> GridArray -> State GridState Int
part2Array n m grid = do
    removed <- removePaperArray n m grid
    if removed == 0 then get >>= \(tot, _)     -> return tot
    else                 get >>= \(_, gridNew) -> part2Array n m gridNew