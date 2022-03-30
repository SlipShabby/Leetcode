
''''
Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

A subarray is a contiguous part of an array.

'''


class Solution(object):
    def maxSubArray(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        for i in range(1,len(nums)):
            if nums[i-1] > 0:
                nums[i] += nums[i-1]
            
        return max(nums)


class Solution2(object):
    def maxSubArray(self, nums):
        cur_max = nums[0]
        max_sum = 0

        for num in nums[1:]:
            cur_max = max(i, cur_max+num)
            max_sum = max(cur_max, max_sum)

        return max_sum
