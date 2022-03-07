class Solution(object):
    def duplicateZeros(self, arr):
        t = []
        for i in arr:
            t.append(i)
            if i ==0 :
                t.append(0)
                
        for i in range(0,len(arr)):
            arr[i] = t[i]