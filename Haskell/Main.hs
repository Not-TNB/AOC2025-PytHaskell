module Main where

import DAY1
import DAY2
import DAY3
import DAY4
import DAY5
import DAY6
import DAY7
import DAY8
import DAY9

main :: IO ()
main = do
    n <- getLine
    case n of
        "1" -> DAY1.main
        "2" -> DAY2.main
        "3" -> DAY3.main
        "4" -> DAY4.main
        "5" -> DAY5.main
        "6" -> DAY6.main
        "7" -> DAY7.main
        "8" -> DAY8.main
        "9" -> DAY9.main
        _   -> print "INVALID NUM -- PICK 1 TO 12 INCLUSIVE"