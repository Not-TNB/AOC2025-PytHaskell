module DAY4 where

import Data.List.Split

main :: IO()
main = do
    file <- readFile "../External_Files/day4.txt"
    let grid = splitOn "\n" file
    print grid
    print dirs

dirs :: [(Int,Int)]
dirs = liftA2 (,) [-1,0,1] [-1,0,1]

type GridState = ([[Char]],Int)



-- from copy import deepcopy

-- directions = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]
-- def removePaper(grid):
--     n = len(grid)
--     m = len(grid[0])
--     gridNew = deepcopy(grid)
--     total = 0
--     toRemove = []
--     for i,r in enumerate(grid):
--         for j,c in enumerate(r):
--             if c != '@': continue
--             count = 0
--             for dr, dc in directions:
--                 rr, cc = i + dr, j + dc
--                 if 0 <= rr < n and 0 <= cc < m and grid[rr][cc] == '@':
--                     count += 1
--             if count < 4:
--                 toRemove.append((i,j))
--                 total += 1
--     for (i,j) in toRemove: gridNew[i][j] = '.'
--     return total, gridNew

-- def part2(grid):
--     g = deepcopy(grid)
--     total = 0
--     while True:
--         removed, g = removePaper(g)
--         if removed == 0: break
--         total += removed
--     return total

-- pt1, _ = removePaper(grid)
-- pt2 = part2(grid)
-- print(pt1, pt2) # PART 1: 1491, PART 2: 8722