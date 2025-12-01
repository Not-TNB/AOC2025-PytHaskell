import qualified Data.Map as Map
import Data.Map ((!), Map)
import Control.Monad.State

main :: IO()
main = do
    file <- readFile "External_Files/dials.txt"
    let file' = lines file
    print $ "PART 1: " ++ show (evalState (password1 file') (0,50))
    print $ "PART 2: " ++ show (evalState (password2 file') (0,50))

--              pwd pos
type PWState = (Int,Int)

drns :: Map.Map Char (Int, Int -> Int -> Bool)
drns = Map.fromList [
    ('L', (-1, (>))), 
    ('R', ( 1, (<)))
    ]

password1 :: [String] -> State PWState Int
password1 [] = gets fst
password1 ((d:s):ls) = do
    (pwd, pos) <- get
    let pos' = (pos +  fst (drns ! d) * read s) `mod` 100
    let pwd' = if   pos' == 0 
               then pwd + 1 
               else pwd 
    put (pwd',pos')
    password1 ls

password2 :: [String] -> State PWState Int
password2 [] = gets fst
password2 ((d:s):ls) = do
    (pwd, pos) <- get
    let (cycles,step) = read s `divMod` 100
    let (dir,op) = drns ! d

    let pos' = (pos + (dir * step)) `mod` 100
    let pwd' = cycles + if   pos' == 0 || pos' `op` pos && pos /= 0
                        then pwd + 1 
                        else pwd
    put (pwd',pos')
    password2 ls