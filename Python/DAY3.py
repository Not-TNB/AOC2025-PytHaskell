with open('External_Files/day3.txt') as f:
    banks = f.read().splitlines()

def maxBank(bank, k):
    canPop = len(bank) - k
    stk = []
    for b in bank:
        while stk and canPop>0 and b>stk[-1]:
            stk.pop()
            canPop -= 1
        stk.append(b)
    return int(''.join(stk[:k]))

pt1 = sum([maxBank(bank, k=2) for bank in banks])  # PART 1: 17430
pt2 = sum([maxBank(bank, k=12) for bank in banks]) # PART 2: 171975854269367
print(pt1, pt2)