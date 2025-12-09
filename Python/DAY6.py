from functools import reduce
from operator import mul

with open('External_Files/day6.txt') as f:
    file = f.read()

def prod(ls): return reduce(mul, ls, 1)

def pt1(file):
    tokens = list(zip(*map(lambda x: x.split(), file.splitlines())))
    return sum(sum(map(int,row[:-1])) if row[-1][0].strip() == '+' else prod(map(int,row[:-1])) for row in tokens)

def pt2(file):
    lines = [line.rstrip("\n")[::-1] for line in file.splitlines()]
    width = max(map(len,lines))
    lines = [line.ljust(width) for line in lines]
    opRow = lines[-1]

    def extract_column(col):
        nums, acc = [], []
        for row in lines[:-1]:
            if (c := row[col]).isdigit(): acc.append(c)
            elif acc:
                nums.append(int(''.join(acc)))
                acc = []
        if acc: nums.append(int(''.join(acc)))
        return nums

    groups, curGrp, ops = [], [], []
    for col in range(width):
        if (colNums := extract_column(col)): curGrp += colNums
        if (op := opRow[col]).strip():
            ops.append(op)
            if curGrp: groups.append(curGrp)
            curGrp = []
    return sum(sum(nums) if op == '+' else prod(nums) for op, nums in zip(ops, groups))

print(pt1(file)) # PART 1: 5877594983578
print(pt2(file)) # PART 2: 11159825706149