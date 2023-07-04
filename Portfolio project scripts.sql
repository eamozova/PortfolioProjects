-- highest population yearly % change by country (with the year in which the change occurred)
SELECT DISTINCT Country,
FIRST_VALUE(Year) OVER (PARTITION BY Country ORDER BY [Yearly%Change] DESC) AS Year,
FIRST_VALUE([Yearly%Change]) OVER (PARTITION BY Country ORDER BY [Yearly%Change] DESC) AS [Max Yearly % Change]
FROM PortfolioProject..population
ORDER BY [Max Yearly % Change] desc

-- highest population yearly % change by country in 2020
SELECT DISTINCT Country, 2020 AS Year, cast([Yearly%Change] as float) as [Yearly%Change]
FROM PortfolioProject..population
WHERE Year = 2020
ORDER BY [Yearly%Change] desc

-- highest median age by country (with the corresponding year)
SELECT DISTINCT Country,
FIRST_VALUE(Year) OVER (PARTITION BY Country ORDER BY MedianAge DESC) AS Year,
FIRST_VALUE(MedianAge) OVER (PARTITION BY Country ORDER BY MedianAge DESC) AS [Median Age]
FROM PortfolioProject..population
WHERE cast(MedianAge as float) > 0
ORDER BY [Median Age] desc

-- highest median age by country in 2020
SELECT DISTINCT Country, 2020 AS Year, cast(MedianAge as float) as MedianAge
FROM PortfolioProject..population
WHERE Year = 2020 AND cast(MedianAge as float) > 0
ORDER BY MedianAge desc

-- highest fertility rate by country (with the corresponding year)
SELECT DISTINCT Country,
FIRST_VALUE(Year) OVER (PARTITION BY Country ORDER BY FertilityRate DESC) AS Year,
FIRST_VALUE(MedianAge) OVER (PARTITION BY Country ORDER BY FertilityRate DESC) AS [Fertility Rate]
FROM PortfolioProject..population
WHERE cast(FertilityRate as float) > 0
ORDER BY [Fertility Rate] desc

-- highest fertility rate by country in 2020
SELECT DISTINCT Country, 2020 AS Year, cast(FertilityRate as float) as FertilityRate
FROM PortfolioProject..population
WHERE Year = 2020 AND cast(FertilityRate as float) > 0
ORDER BY FertilityRate desc

-- highest unemployment rate by country (with the corresponding year)
SELECT DISTINCT [Country Name],
FIRST_VALUE(Year) OVER (PARTITION BY [Country Name] ORDER BY [Unemployment Rate] DESC) AS Year,
FIRST_VALUE(cast([Unemployment Rate] as float)) OVER (PARTITION BY [Country Name] ORDER BY [Unemployment Rate] DESC) AS Unemployment
FROM PortfolioProject..unemployment
--WHERE [Unemployment Rate] > 0
ORDER BY Unemployment desc

-- highest unemployment rate by country in 2020
SELECT DISTINCT [Country Name], 2020 AS Year, cast([Unemployment Rate] as float) as Unemployment
FROM PortfolioProject..unemployment
WHERE Year = 2020
ORDER BY Unemployment desc

SELECT DISTINCT Country, Continent, p.Year, [Population], cast([UrbanPop%] as float) as [UrbanPop%],
cast([MedianAge] as float) as [MedianAge],
cast(u.[Unemployment Rate] as float) as Unemployment
FROM PortfolioProject..population p
JOIN PortfolioProject..unemployment u ON u.[Country Name] = p.Country AND u.Year = p.Year
ORDER BY Year, Unemployment desc

CREATE VIEW PopulationAndUnemployment as
SELECT DISTINCT Country, Continent, p.Year, [Population], [UrbanPop%], [MedianAge],
cast(u.[Unemployment Rate] as float) as Unemployment
FROM PortfolioProject..population p
JOIN PortfolioProject..unemployment u ON u.[Country Name] = p.Country AND u.Year = p.Year

-- fertility rate over the years
SELECT DISTINCT Country, Continent, Year, cast([FertilityRate] as float) as [FertilityRate]
FROM PortfolioProject..population 
ORDER BY Year, FertilityRate desc