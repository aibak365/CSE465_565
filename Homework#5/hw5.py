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
    with open("zips.txt", 'r') as file:
        zips = file.read().splitlines()

    zip_lat_lon = {}
    for index, row in df.iterrows():
        zip_code = row['Zipcode']
        if zip_code not in zip_lat_lon:
            zip_lat_lon[zip_code] = (row['Lat'], row['Long'])

    with open("LatLon.txt", 'w') as file:
        for zip_code in zips:
            if int(zip_code.strip()) in zip_lat_lon:
                lat, lon = zip_lat_lon[int(zip_code)]
                file.write(f"{lat} {lon}\n")
            else:
                file.write("N/A N/A\n")

    city_states_df = df.groupby('City')['State'].apply(lambda x: sorted(set(x))).reset_index()
    with open("cities.txt", 'r') as file:
        cities = file.read().strip().upper().splitlines()

    city_states_dict = dict(zip(city_states_df['City'], city_states_df['State']))

    with open("CityStates.txt", 'w') as file:
        for city in cities:
            if city in city_states_dict:
                states = ' '.join(city_states_dict[city])
                file.write(f"{states}\n")
            else:
                file.write(f"{city}: N/A\n")
    df = df.dropna(subset=['Lat', 'Long'])
    
    coords = df[['Lat', 'Long']].to_numpy()
    # please note that i used this from chatgpt cuz, the original way in my mind is so slow and heavy
    tree = cKDTree(coords)

    dist, idx = tree.query(coords, k=2, distance_upper_bound=np.inf)
    max_dist_idx = np.argmax(dist[:, 1])
    zip1 = df.iloc[max_dist_idx]['Zipcode']
    zip2 = df.iloc[idx[max_dist_idx, 1]]['Zipcode']

    largest_population_zip = df.loc[df['EstimatedPopulation'].idxmax()]['Zipcode']

    smallest_population_zip = df.loc[df['EstimatedPopulation'].idxmin()]['Zipcode']

    df['PerCapitaWages'] = df['TotalWages'] / df['EstimatedPopulation']
    largest_per_capita_wages_zip = df.loc[df['PerCapitaWages'].idxmax()]['Zipcode']

    smallest_per_capita_wages_zip = df.loc[df['PerCapitaWages'].idxmin()]['Zipcode']

    city_population_df = df.groupby(['City', 'State'])['EstimatedPopulation'].sum().reset_index()
    largest_population_city = city_population_df.loc[city_population_df['EstimatedPopulation'].idxmax()]
    largest_population_city_name = f"{largest_population_city['City']}, {largest_population_city['State']}"

    with open("grad.txt", 'w') as file:
        file.write(f"{zip1} {zip2}\n")
        file.write(f"{largest_population_zip}\n")
        file.write(f"{smallest_population_zip}\n")
        file.write(f"{largest_per_capita_wages_zip}\n")
        file.write(f"{smallest_per_capita_wages_zip}\n")
        file.write(f"{largest_population_city_name.lower().capitalize()}\n")

    '''
    Inside the __main__, do not add any codes after this line.
    ----------------------------------------------------------
    '''
    end_time = time.perf_counter()
    # Calculate the runtime in milliseconds
    runtime_ms = (end_time - start_time) * 1000
    print(f"The runtime of the program is {runtime_ms} milliseconds.")
