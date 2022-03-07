class Solution(object):
    def sortedSquares(self, nums):
        l = [x**2 for x in nums]
        return sorted(l)
            
        