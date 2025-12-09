from itertools import *
from shapely.geometry import *
from shapely.prepared import *

with open('External_Files/day9.txt',"r") as f:
   pts = [list(map(int,line.split(','))) for line in f.read().splitlines()]

poly = prep(Polygon(pts))
pt1 = pt2 = 0
for p,q in combinations(pts,2):
    pt1 = max(pt1, a := (abs(p[0]-q[0])+1)*(abs(p[1]-q[1])+1))
    if a > pt2 and poly.covers(box(*map(min,zip(p,q)), *map(max,zip(p,q)))): pt2 = a

# PART 1: 4776487744, PART 2: 1560299548
print(pt1, pt2)