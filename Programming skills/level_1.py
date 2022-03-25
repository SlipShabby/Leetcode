

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
