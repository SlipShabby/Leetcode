
# Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.


# most productive solution

class Solution(object):
    def containsDuplicate(self, nums):
        d = {}
        
        for x in nums:
            if x not in d:
                d[x] = 0
            d[x]+=1
            if d[x] >1:
                return True
        
        return False