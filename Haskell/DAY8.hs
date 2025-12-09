{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
module DAY8 where

import Control.Monad
import Control.Monad.ST
import Data.Hashable
import qualified Data.HashTable.ST.Basic as HT
import Data.Maybe
import Data.List.Split
import Data.List (sortOn, sort)
import Utils

main :: IO ()
main = do
    file <- readFile "../External_Files/day8.txt"
    let bs = (\[x,y,z] -> (x,y,z)) . map (read @Int) . splitOn "," <$> lines file
    print $ solve bs 1000 -- PART 1: 117000
    print $ solve bs 0    -- PART 2: 8368033065

type STMap s k v = HT.HashTable s k v
data DSU s a = DSU {parent :: STMap s a a, size :: STMap s a Int}

newDSU :: (Eq a, Hashable a) => [a] -> ST s (DSU s a)
newDSU xs = do
    p <- HT.new; s <- HT.new
    forM_ xs $ \x -> HT.insert p x x >> HT.insert s x 1
    pure $ DSU p s

find :: (Eq a, Hashable a) => DSU s a -> a -> ST s a
find dsu x = HT.lookup (parent dsu) x >>= maybe (pure x) go
    where go px | px == x   = pure x
                | otherwise = ap ((>>) . HT.insert (parent dsu) x) pure =<< find dsu px

union :: (Eq a, Hashable a) => DSU s a -> a -> a -> ST s Bool
union dsu a b = do
    ra <- find dsu a; rb <- find dsu b
    if ra == rb then pure False else do
        sa <- fromMaybe 0 <$> HT.lookup (size dsu) ra
        sb <- fromMaybe 0 <$> HT.lookup (size dsu) rb
        let (big, sml) = if sa < sb then (rb, ra) else (ra, rb)
        HT.insert (parent dsu) sml big
        HT.insert (size dsu) big (sa+sb) >> pure True

type Pos = (Int,Int,Int)
type Edge = (Float, (Pos, Pos))

allEdges :: [Pos] -> [Edge]
allEdges pts = sortOn fst [(dist3 a b, (a,b)) | (i,a) <- zip [0..] pts, b <- drop (i+1) pts]

updateLast :: Hashable a1 => DSU s a1 -> (a1, a1) -> (a2, (a1, a1)) -> ST s (a1, a1)
updateLast dsu lastE (_,ab@(a,b)) = union dsu a b >>= \mrgd -> pure (if mrgd then ab else lastE)

solve :: [Pos] -> Int -> Int
solve bs k = runST $ do
    dsu <- newDSU bs
    let pt2 = k <= 0; edges = allEdges bs
        toUse = if pt2 then edges else take k edges
    lastEdge <- foldM (updateLast dsu) ((0,0,0),(0,0,0)) toUse
    if pt2 then let ((x1,_,_),(x2,_,_)) = lastEdge in pure $ x1 * x2
    else do
        reps <- forM bs $ find dsu
        pure $ (product . take 3 . reverse . sort . map (length . flip filter reps . (==))) bs