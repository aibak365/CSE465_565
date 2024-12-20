/* 
  Homework#4

  Add your name here: Aibak Aljadayah

  You are free to create as many classes within the Hw4.cs file or across 
  multiple files as you need. However, ensure that the Hw4.cs file is the 
  only one that contains a Main method. This method should be within a 
  class named hw4. This specific setup is crucial because your instructor 
  will use the hw4 class to execute and evaluate your work.
  */
  // BONUS POINT:
  // => Used Pointers from lines 10 to 15 <=
  // => Used Pointers from lines 40 to 63 <=
  // Please note that you can find using Lambda in any function i have while I am using it with LINQ for ex:124
  

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.IO.Compression;
using System.Globalization;

public class Hw4
{
    public static void Main(string[] args)
    {
        // Capture the start time
        // Must be the first line of this method
        DateTime startTime = DateTime.Now; // Do not change
        // ============================
        // Do not add or change anything above, inside the 
        // Main method
        // ============================
        // TODO: your code goes here
        GenerateCommonCityNames();
        Latton();
        StatesOfTheCitiy();
        // Please note that I am using appending on the grad.txt
        maxDistance();
        TheHighestPopulation();
        TheLowestPopulation();
        TheBigestWage();
        TheSmallestWage();
       TheLargestPopulation();
        

        // ============================
        // Do not add or change anything below, inside the 
        // Main method
        // ============================
        // Read city names from cities.txt
        
        // Capture the end time
        DateTime endTime = DateTime.Now;  // Do not change
        
        // Calculate the elapsed timevar cities = File.ReadLines("cities.txt").Select(line => line.Trim()).ToHashSet();
        
        TimeSpan elapsedTime = endTime - startTime; // Do not change
        
        // Display the elapsed time in milliseconds
        Console.WriteLine($"Elapsed Time: {elapsedTime.TotalMilliseconds} ms");
    }

    public static void GenerateCommonCityNames()
    {
        // the issue is because I tried to override Lines while it be, but i rly don't know when i used it before wired
        // Don't forget that in github i can show that the results are appeared and everything looks fine, but forgot why I added this line, and why is not working
        //https://github.com/aibak365/CSE465_565/tree/main/Homework4/Homework%234 my github link 
        // Don't forget to mentioned that i made a push yesterday here is the link https://github.com/aibak365/CSE465_565/commit/762a68bfbc2753d895fefda890b2a131d1491605
        // the only change was uncomments and comments lines of code and we can see it on this section Homework4/Homework#4/Hw4.cs on the commit, did that cuz maybe it was issue related to commiting my code
        //
        //
      //var Lines = File.ReadLines("zipcodes.txt").Select(Lines => Lines.Split('\t')); // i am using linq and lambda 
        var states = new HashSet<string>(File.ReadLines("states.txt").Select(line => line.Trim()));

        var cityCounts = File.ReadLines("zipcodes.txt")
            .Skip(1) // i want it to skip the header
            .Select(line => line.Split('\t'))
            .Where(columns => states.Contains(columns[4]))
            .Select(columns => new { State = columns[4], City = columns[3] })
            .GroupBy(sc => sc.City)
            .ToDictionary(g => g.Key, g => g.Select(sc => sc.State).Distinct().Count());
        var commonCities = cityCounts
            .Where(kvp => kvp.Value == states.Count)
            .Select(kvp => kvp.Key)
            .OrderBy(city => city);
        File.WriteAllLines("CommonCityNames.txt", commonCities);
    }
    public static void Latton()
    {
       var zipCodesToFind = new HashSet<string>(File.ReadLines("zips.txt").Select(line => line.Trim()));

        var latLonResults = File.ReadLines("zipcodes.txt")
            .Skip(1) 
            .Select(line => line.Split('\t'))
            .Where(columns => zipCodesToFind.Contains(columns[1]))
            .GroupBy(columns => columns[1]) 
            .Select(g => g.First())
            .Select(columns => $" {columns[6]} {columns[7]}") 
            .ToList();

        File.WriteAllLines("LatLon.txt", latLonResults);
    }
    public static void StatesOfTheCitiy()
    {
      var cities = File.ReadLines("cities.txt").Select(line => line.Trim().ToLower()).ToHashSet();

    
        var lines = File.ReadLines("zipcodes.txt").Skip(1).ToList();

        var cityStates = File.ReadLines("zipcodes.txt")
            .Skip(1) 
            .Select(line => line.Split('\t'))
            .Where(columns => cities.Contains(columns[3].ToLower())) 
            .GroupBy(columns => columns[3].ToLower()) 
            .ToDictionary(
                g => g.Key,
                g => g.Select(columns => columns[4]) 
                      .Distinct() 
                      .OrderBy(state => state) 
                      .ToArray() 
            );
      using (var writer = new StreamWriter("CityStates.txt"))
        {
            foreach (var city in cities)
            {
                if (cityStates.ContainsKey(city))
                {
                    writer.WriteLine($"{string.Join(" ", cityStates[city])}");
                }
            }
        }
    }

    // please note that i used ChatGpt for this function
    // Haversine formula to calculate the distance between two points on the Earth
    private static double GetDistance(double lat1, double lon1, double lat2, double lon2)
    {
        const double R = 6371; // Radius of Earth in kilometers
        double dLat = ToRadians(lat2 - lat1);
        double dLon = ToRadians(lon2 - lon1);
        double a = Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
                   Math.Cos(ToRadians(lat1)) * Math.Cos(ToRadians(lat2)) *
                   Math.Sin(dLon / 2) * Math.Sin(dLon / 2);
        double c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
        return R * c; // Distance in kilometers
    }

    private static double ToRadians(double angle)
    {
        return angle * (Math.PI / 180);
    }


  public static void maxDistance()
  {
    var zipCodes = File.ReadLines("zipcodes.txt")
            
            .Select(line =>
            {
                var parts = line.Split('\t');
                double lat = double.TryParse(parts[6], NumberStyles.Float, CultureInfo.InvariantCulture, out var latitude) ? latitude : 0;
                double lon = double.TryParse(parts[7], NumberStyles.Float, CultureInfo.InvariantCulture, out var longitude) ? longitude : 0;

                return new
                {
                    ZipCode = parts[1],
                    Latitude = lat,
                    Longitude = lon
                };
            })
            .ToList();

        var minLatLon = zipCodes.OrderBy(z => z.Latitude).ThenBy(z => z.Longitude).First();
        var maxLatLon = zipCodes.OrderByDescending(z => z.Latitude).ThenByDescending(z => z.Longitude).First();

        var maxDistance = GetDistance(minLatLon.Latitude, minLatLon.Longitude, maxLatLon.Latitude, maxLatLon.Longitude);

        using (var writer = new StreamWriter("grad.txt"))
        {
            writer.WriteLine($"{minLatLon.ZipCode} {maxLatLon.ZipCode}");
        }
  }
  public static void TheHighestPopulation()
  {
    var zipCodes = File.ReadLines("zipcodes.txt")
            .Skip(1) 
            .Select(line =>
            {
                var parts = line.Split('\t');
                int population = int.TryParse(parts[17], out var pop) ? pop : 0;

                return new
                {
                    ZipCode = parts[1],
                    Population = population
                };
            })
            .ToList();

        var largestPopulationZip = zipCodes.OrderByDescending(z => z.Population).FirstOrDefault();

        if (largestPopulationZip != null)
        {
            using (var writer = new StreamWriter("grad.txt", append: true))
            {
                writer.WriteLine($"ZipCode: {largestPopulationZip.ZipCode}");
            }
        }
  }
  public static void TheLowestPopulation()
  {
    var zipCodes = File.ReadLines("zipcodes.txt")
            .Skip(1) 
            .Select(line =>
            {
                var parts = line.Split('\t');
                int population = int.TryParse(parts[17], out var pop) ? pop : 10000; //in case any empty poulation

                return new
                {
                    ZipCode = parts[1],
                    Population = population
                };
            })
            .ToList();

        var smallestPopulationZip = zipCodes.OrderBy(z => z.Population).FirstOrDefault();

        if (smallestPopulationZip != null)
        {
            using (var writer = new StreamWriter("grad.txt", append: true))
            {
                writer.WriteLine($"ZipCode: {smallestPopulationZip.ZipCode}");
            }

        }
  }
  public static void TheBigestWage()
  {
    var zipCodes = File.ReadLines("zipcodes.txt")
            .Skip(1) 
            .Select(line =>
            {
                var parts = line.Split('\t');
                int population = int.TryParse(parts[17], out var pop) ? pop : 0;
                double totalWages = double.TryParse(parts[18], NumberStyles.Float, CultureInfo.InvariantCulture, out var wages) ? wages : 0;

                return new
                {
                    ZipCode = parts[1],
                    Population = population,
                    TotalWages = totalWages
                };
            })
            .Where(z => z.Population > 0) 
            .ToList();

        var zipCodeWages = zipCodes
            .Select(z => new
            {
                z.ZipCode,
                PerCapitaWages = z.TotalWages / z.Population
            })
            .OrderByDescending(z => z.PerCapitaWages)
            .FirstOrDefault();

        if (zipCodeWages != null)
        {
            using (var writer = new StreamWriter("grad.txt", append: true))
            {
                writer.WriteLine($"ZipCode: {zipCodeWages.ZipCode}");
            }

            
        }
  }
  public static void TheSmallestWage()
  {
    var zipCodes = File.ReadLines("zipcodes.txt")
            .Skip(1) 
            .Select(line =>
            {
                var parts = line.Split('\t');
                int population = int.TryParse(parts[17], out var pop) ? pop : 0;
                double totalWages = double.TryParse(parts[18], NumberStyles.Float, CultureInfo.InvariantCulture, out var wages) ? wages : 1000000;

                return new
                {
                    ZipCode = parts[1],
                    Population = population,
                    TotalWages = totalWages
                };
            })
            .Where(z => z.Population > 0) 
            .ToList();

        var zipCodeWages = zipCodes
            .Select(z => new
            {
                z.ZipCode,
                PerCapitaWages = z.TotalWages / z.Population
            })
            .OrderBy(z => z.PerCapitaWages)
            .FirstOrDefault();

        if (zipCodeWages != null)
        {
            using (var writer = new StreamWriter("grad.txt", append: true))
            {
                writer.WriteLine($"ZipCode: {zipCodeWages.ZipCode}");
            }

        }
  }
  public static void TheLargestPopulation()
  {
     var zipCodes = File.ReadLines("zipcodes.txt")
            .Skip(1) 
            .Select(line =>
            {
                var parts = line.Split('\t');
                int population = int.TryParse(parts[17], out var pop) ? pop : 0;

                return new
                {
                    City = parts[3] + ", " + parts[4],
                    Population = population
                };
            })
            .ToList();

        var cityPopulations = zipCodes
            .GroupBy(z => z.City)
            .Select(g => new { City = g.Key, TotalPopulation = g.Sum(z => z.Population) })
            .OrderByDescending(g => g.TotalPopulation)
            .FirstOrDefault();

        if (cityPopulations != null)
        {
            using (var writer = new StreamWriter("grad.txt", append: true))
            {
                writer.WriteLine($"City: {cityPopulations.City}");
            }
        }
  }
  
    
}
