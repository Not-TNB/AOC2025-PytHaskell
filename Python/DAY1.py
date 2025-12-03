acc = 50
pt1 = pt2 = 0

with open('External_Files/day1.txt') as f:
    for line in f:
        d = line.strip()
        acc += int(d[1:]) * (1 if d[0] == 'R' else -1)
        pt2 += abs(acc//100)
        if (acc:=acc%100) == 0: pt1 += 1   
f.close()
        
# PART 1: 989 
# PART 2: 5941
print(pt1, pt2)