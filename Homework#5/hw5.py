import time
from geopy.distance import geodesic # please don't forget to install it; pip install geopy
import pandas as pd
import numpy as np
from scipy.spatial import cKDTree # as i understood is a better way of the memory
 # please don't forget to install scipy

"""
Homework#5
Add your name here: Aibak Aljadayah
You are free to create as many classes within the hw5.py file or across
multiple files as you need. However, ensure that the hw5.py file is the
only one that contains a __main__ method. This specific setup is crucial
because your instructor will run the hw5.py file to execute and evaluate
your work.
"""
"""
1- => Lambda was used in line/s: 53
2- => Filter or map was used in line/s: ...........
3- => yield was used in line/s: .........
"""
if __name__ == "__main__":
    start_time = time.perf_counter() # Do not remove this line
    '''
    Inisde the __main__, do not add any codes before this line.
    -----------------------------------------------------------
    '''
    # write your code here
    # to read the file as panda dataframe
    df = pd.read_csv("zipcodes.txt", delimiter='\t')

    with open("states.txt", 'r') as file:
        states = file.read().strip().splitlines()
    state_cities = {state: set(df[df['State'] == state]['City']) for state in states}
    common_cities = set.intersection(*state_cities.values())
    common_cities_sorted = sorted(common_cities)

    with open("CommonCityNames.txt", 'w') as file:
        for city in common_cities_sorted:
            file.write(f"{city}\n")
    

    '''
    Inside the __main__, do not add any codes after this line.
    ----------------------------------------------------------
    '''
    end_time = time.perf_counter()
    # Calculate the runtime in milliseconds
    runtime_ms = (end_time - start_time) * 1000
    print(f"The runtime of the program is {runtime_ms} milliseconds.")
