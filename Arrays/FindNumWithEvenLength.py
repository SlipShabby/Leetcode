class Solution(object):
    def findNumbers(self, nums):
        l = []
        n = 0
        for i in range(0, len(nums)):
            l.append(len(str(nums[i])))
            if l[i]%2 ==0:
                n+=1
        return n
        