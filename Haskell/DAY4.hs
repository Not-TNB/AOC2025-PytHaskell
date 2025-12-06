{-# LANGUAGE TupleSections #-}
module DAY4 where
import Control.Monad.State
import Data.Array
import Utils

main :: IO ()
main = do
    grid <- setupGrid <$> readFile "../External_Files/day4.txt"
    print $ evalState (removePaperArray grid) (0,grid)
    print $ evalState (part2Array       grid) (0,grid)

type GridState = (Int, GridArray)

toRemoveIdxs :: GridArray -> [(Int,Int)]
toRemoveIdxs grid = [pos | pos <- coords grid, grid!pos == '@' && ngbrs grid (=='@') pos <= 4]

removePaperArray ::  GridArray -> State GridState Int
removePaperArray grid = do
    let removeList = toRemoveIdxs grid
        removed    = length removeList
    modify (\(tot,g) -> (tot + removed, g // map (,'.') removeList))
    return removed

part2Array :: GridArray -> State GridState Int
part2Array grid = do
    removed <- removePaperArray grid
    if removed == 0 then gets fst else gets snd >>= part2Array