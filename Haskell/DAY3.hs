module DAY3 where

import Control.Monad.State
import Data.Char (digitToInt)

main :: IO()
main = do
    file <- readFile "../External_Files/day3.txt"
    let banks = map (map digitToInt) $ lines file
    print $ maxBanks  2 banks -- PART 1: 17430
    print $ maxBanks 12 banks -- PART 2: 171975854269367

type StkState = ([Int], Int)

maxBanks :: Int -> [[Int]] -> Int
maxBanks k = sum . map (\b -> 
    (read . concatMap show) $ 
    take k                  $ 
    evalState (maxBank b) ([],length b - k))

maxBank :: [Int] -> State StkState [Int]
maxBank [] = gets $ reverse . fst
maxBank bank@(b:bs) = do
    (stk,canPop) <- get
    let next = put (b:stk, canPop) >> maxBank bs in
        case stk of
            (d:ds) -> if canPop <= 0 || b <= d 
                    then next
                    else put (ds, canPop-1) >> maxBank bank
            _ -> next