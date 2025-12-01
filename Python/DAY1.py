acc = 50
pt1 = pt2 = 0

with open('External_Files/dials.txt') as f:
    for line in f:
        d = line.strip()

        cycles, step = divmod(int(d[1:]), 100)
        pt2 += cycles

        s = acc
        if d[0] == 'R':
            acc = (acc + step) % 100
            cyc = acc < s
        else: # d[0] == 'L'
            acc = (acc - step) % 100
            cyc = acc > s
        
        if acc == 0:
            pt1 += 1
            pt2 += 1
        elif (cyc and s != 0): 
            pt2 += 1

# PART 1: 989 
# PART 2: 5941
print(pt1, pt2)