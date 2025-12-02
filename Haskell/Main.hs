module Main where

import DAY1
import DAY2

main :: IO ()
main = do
    n <- getLine
    case n of
        "1" -> DAY1.main
        "2" -> DAY2.main
        _   -> print "INVALID NUM -- PICK 1 TO 12 INCLUSIVE"