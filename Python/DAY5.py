with open('External_Files/day5.txt') as f:
    lines = f.read().splitlines()

ranges = []
while True:
    if (line := lines.pop(0)) == '': break
    ranges.append(list(map(int, line.split('-'))))

union = []
for b,e in sorted(ranges):
    if union and union[-1][1] >= b-1: union[-1][1] = max(union[-1][1], e)
    else: union.append([b,e])

pt1 = 0
while lines:
    query = int(lines.pop(0))
    for b,e in union:
        if b<=query<=e:
            pt1 += 1
            break

pt2 = sum([e-b+1 for b,e in union])

# PART 1: 529 
# PART 2: 344260049617193
print(pt1, pt2)