{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module DAY1 where

import qualified Data.Map as Map
import Data.Map ((!))
import Control.Monad.State

main :: IO()
main = do
    file <- readFile "../External_Files/day1.txt"
    let file' = lines file
    print $ evalState (password file') (0,0,50) -- (989,5949)

--              pw1 pw2 pos
type PWState = (Int,Int,Int)

drns :: Map.Map Char Int
drns = Map.fromList [('L', -1), ('R', 1)]

password :: [String] -> State PWState (Int,Int)
password [] = gets (\(p1,p2,_) -> (p1,p2))
password ((d:s):ls) = do
    (p1,p2,pos) <- get
    let (q,r) = (pos + (drns ! d) * read s) `divMod` 100 
    let p1' = p1 + fromEnum (r == 0)
    let p2' = p2 + abs q
    put (p1', p2', r)
    password ls