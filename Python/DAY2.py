import re

with open('External_Files/day2.txt') as f:
    ranges = f.read().split(',')
f.close()

# alternative (easier imo) regex solution
pattern1 = re.compile(r'^(\d+)\1$')
pattern2 = re.compile(r'^(\d+)\1+$')
def find(x):
    a, b = x
    a, b = int(a), int(b)
    s1 = s2 = 0
    for k in range(a,b+1):
        s = str(k)
        if pattern1.match(s): s1 += k
        if pattern2.match(s): s2 += k
    return (s1,s2)

rs = [find(x.split('-')) for x in ranges]
ans = list(map(sum,zip(*rs)))
print(ans) # PART 1: 40214376723, PART 2: 50793864718