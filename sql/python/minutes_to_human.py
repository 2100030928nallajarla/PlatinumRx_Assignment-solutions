def convert_minutes(m):
    hrs = m // 60
    mins = m % 60
    if hrs == 0:
        return f"{mins} minutes"
    elif mins == 0:
        return f"{hrs} hrs"
    else:
        return f"{hrs} hrs {mins} minutes"
print(convert_minutes(130)) 
print(convert_minutes(110))  
