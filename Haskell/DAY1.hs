import qualified Data.Map as Map
import Data.Map ((!), Map)
import Control.Monad.State

main :: IO()
main = do
    file <- readFile "External_Files/dials.txt"
    let file' = lines file
    print $ "PART 1: " ++ show (evalState (password1 file') (0,50)) -- 989
    print $ "PART 2: " ++ show (evalState (password2 file') (0,50)) -- 5949

--              pwd pos
type PWState = (Int,Int)

drns :: Map.Map Char Int
drns = Map.fromList [('L', -1), ('R', 1)]

password1 :: [String] -> State PWState Int
password1 [] = gets fst
password1 ((d:s):ls) = do
    (pwd, pos) <- get
    let pos' = (pos + (drns ! d) * read s) `mod` 100
    let pwd' = pwd + fromEnum (pos' == 0)
    put (pwd', pos')
    password1 ls

password2 :: [String] -> State PWState Int
password2 [] = gets fst
password2 ((d:s):ls) = do
    (pwd, pos) <- get
    let (q,r) = (pos + (drns ! d) * read s) `divMod` 100
    let pwd' = pwd + abs q
    put (pwd', r)
    password2 ls