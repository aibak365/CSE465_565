/* 
  Homework#4

  Add your name here: ----

  You are free to create as many classes within the Hw4.cs file or across 
  multiple files as you need. However, ensure that the Hw4.cs file is the 
  only one that contains a Main method. This method should be within a 
  class named hw4. This specific setup is crucial because your instructor 
  will use the hw4 class to execute and evaluate your work.
  */
  // BONUS POINT:
  // => Used Pointers from lines 10 to 15 <=
  // => Used Pointers from lines 40 to 63 <=
  

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.IO.Compression;

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
        
        // Read the list of zip codes from zips.txt
       

        




        // TODO: your code goes here
        //GenerateCommonCityNames();
        //Latton();

        
        


        

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
      var Lines = File.ReadLines("zipcodes.txt").Select(Lines => Lines.Split('\t')); // i am using linq and lambda
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
    public static void StatesOfTheCitiy
    {
      var cities = File.ReadLines("cities.txt").Select(line => line.Trim().ToLower()).ToHashSet();
        Console.WriteLine($"Cities read from cities.txt: {cities.Count}");

        foreach (var city in cities)
        {
            Console.WriteLine($"City from file: {city}");
        }

        var lines = File.ReadLines("zipcodes.txt").Skip(1).ToList();
        Console.WriteLine($"Lines read from zipcodes.txt: {lines.Count}");

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
                    writer.WriteLine($"{city} {string.Join(" ", cityStates[city])}");
                }
            }
        }
    }

 

  
    
}
