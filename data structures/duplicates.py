
# Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.

'''
we can solve this task with different approaches. 
For an example, we could use brute force solution to 
'''


# most productive solution
# time: O(n)
# space: O(n)

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


# pythonic way
# time: O(n) 
# space: O(n)

class SolutionPythonic(object):
    def containsDuplicate(self,nums):

        return len(nums) != len(set(nums))


# use sort()
# time: O(nlogn)
# space: O(1)

class SolutionSort(object):
    def containssDuplicate(self, nums):
        nums.sort()
        for i in range(1, len(nums)):
            if nums[i] == nums[i-1]:
                return True
            return False