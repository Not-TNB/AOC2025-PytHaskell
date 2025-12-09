from collections import defaultdict
from math import dist, prod
from itertools import combinations

with open('External_Files/day8.txt') as f:
    boxes = [tuple(map(int, line.split(','))) for line in f.read().splitlines()]
f.close()

def findTop3(boxes, k=-2) -> int:
    edges = sorted(map(lambda p: (dist(*p),p), combinations(boxes,2)), key=lambda x: x[0])
    dsu = DSU(boxes)
    for _,ab in edges[:k]: 
        if dsu.union(ab): last = ab
    if k == -2: return last[0][0]*last[1][0]
    circuitSize = defaultdict(int)
    for b in boxes: circuitSize[dsu.find(b)] += 1
    return prod(sorted(circuitSize.values(), reverse=True)[:3])

class DSU:
    def __init__(self, pts): self.parent, self.size = {p: p for p in pts}, {p: 1 for p in pts}
    def find(self, x):
        while self.parent[x] != x: self.parent[x], x = self.parent[self.parent[x]], self.parent[x]
        return x
    def union(self, ab):
        ra, rb = self.find(ab[0]), self.find(ab[1])
        if ra == rb: return False 
        if self.size[ra] < self.size[rb]: ra, rb = rb, ra
        self.parent[rb] = ra
        self.size[ra] += self.size[rb]
        return True
        
print(findTop3(boxes, 1000)) # PART 1: 117000
print(findTop3(boxes))       # PART 2: 8368033065