def maxMeeting(effectiveness):
    n = len(effectiveness)
    index = 0
    max_meetings = 0
    effectiveness = sorted(effectiveness)
    effectiveness.reverse()
    for i in range(n):
        
        index += effectiveness[i]
        if index > 0:
            max_meetings +=1
        else:
            break
    return max_meetings
print(maxMeeting([-2,-1,0,3]))