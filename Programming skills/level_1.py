

# Count Odd Numbers in an Interval Range 

class SolutionOddNumber(object):
    def countOdds(self, low, high):
        if low % 2 == 0:
            return (high-low+1)//2
        return (high-low)//2 + 1
            

# find average salary

class SolutionAverageSalary(object):
    def average(self, salary):
       
        total = 0
        n = len(salary)
        
        for i in range(0, n):
            total += salary[i]
        
        total = total-max(salary) - min(salary)

            
        return float(total)/float((n-2))


class SolutionAvgSalary1(object):
    def average(self, salary):
        return float(sum(sorted(salary)[1:-1])) / float(len(salary)-2)


class SolutionAvgSalary2(object):
    def average(self, salary):
        return float(sum(salary)-min(salary)-max(salary)) / float(len(salary)-2)


# intersection of 2 arrays

from collections import Counter


class Solution(object):
    def intersect(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: List[int]
        """
        
        n1 = Counter(nums1)
        n2 = Counter(nums2)
        n3 = n1 & n2
        return list(n3.elements())


# Largest Perimeter Triangle
class Solution(object):
    def largestPerimeter(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        nums = sorted(nums, reverse=True)
        
        for i in range(0, len(nums) - 2):
            a, b, c = nums[i:i+3]
            if (a < b + c) and (b < a + c) and (c < a + b):
                return a + b + c
        return 0