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
            cyc = (acc < s)
        else:
            acc = (acc - step) % 100
            cyc = (acc > s) 
        
        if acc == 0:
            pt1 += 1
            pt2 += 1
        elif (cyc and s!=0): 
            pt2 += 1

print(pt1, pt2)