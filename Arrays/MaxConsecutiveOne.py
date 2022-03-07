
class Solution(object):
    def findMaxConsecutiveOnes(self, nums):
        max = 0
        n=0
        
        for i in range(0, len(nums)):
            if nums[i] == 1:
                n +=1
            else:
                if n > max:
                    max = n
                n=0
        if n>max:
            max = n
        return max 