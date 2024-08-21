-- Active: 1724146165933@@127.0.0.1@3306@world
# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT * FROM CITY WHERE NAME LIKE 'PING%' ORDER BY POPULATION ASC;
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT * FROM CITY WHERE NAME LIKE 'RAN%' ORDER BY POPULATION DESC;
#
# 3: Count all cities
SELECT COUNT(*) FROM CITY;
#
# 4: Get the average population of all cities
SELECT AVG(POPULATION) FROM CITY;
#
# 5: Get the biggest population found in any of the cities
SELECT MAX(POPULATION) FROM CITY;
#
# 6: Get the smallest population found in any of the cities
SELECT MIN(POPULATION) FROM CITY;
#
# 7: Sum the population of all cities with a population below 10000
SELECT SUM(POPULATION) FROM CITY WHERE POPULATION < 10000;
#
# 8: Count the cities with the countrycodes MOZ and VNM
SELECT COUNT(*) FROM CITY WHERE COUNTRYCODE IN ('MOZ','VNM');
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
SELECT CountryCode, COUNT(*) FROM CITY WHERE CountryCode IN ('MOZ', 'VNM') GROUP BY CountryCode;
#
#
# 10: Get average population of cities in MOZ and VNM
SELECT COUNTRYCODE, AVG(POPULATION) FROM CITY WHERE COUNTRYCODE IN ('MOZ','VNM') GROUP BY COUNTRYCODE;
#
#
# 11: Get the countrycodes with more than 200 cities
SELECT COUNTRYCODE, COUNT(*) FROM CITY GROUP BY COUNTRYCODE HAVING COUNT(*) > 200;
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
SELECT COUNTRYCODE, COUNT(*) FROM CITY GROUP BY COUNTRYCODE HAVING COUNT(*) > 200 ORDER BY COUNT(*) DESC;
#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
SELECT COUNTRYLANGUAGE.COUNTRYCODE FROM CITY JOIN COUNTRYLANGUAGE ON CITY.COUNTRYCODE = COUNTRYLANGUAGE.COUNTRYCODE WHERE CITY.POPULATION BETWEEN 400 AND 500;
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them 
SELECT CITY.NAME, COUNTRYLANGUAGE.LANGUAGE FROM CITY JOIN COUNTRYLANGUAGE ON CITY.COUNTRYCODE = COUNTRYLANGUAGE.COUNTRYCODE WHERE CITY.POPULATION BETWEEN 500 AND 600;
#
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)

SELECT CITY.NAME FROM CITY WHERE POPULATION = 122199;

SELECT CITY.NAME FROM CITY WHERE COUNTRYCODE = (SELECT COUNTRYCODE FROM CITY WHERE POPULATION = 122199);
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)

SELECT CITY.NAME FROM CITY WHERE COUNTRYCODE = (SELECT COUNTRYCODE FROM CITY WHERE POPULATION = 122199) AND CITY.POPULATION != 122199;
#
# 17: What are the city names in the country where Luanda is capital?

# SOLUTION TO THE QUESTION!
SELECT CITY.NAME FROM CITY JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE WHERE COUNTRY.CAPITAL = (SELECT ID FROM CITY WHERE NAME = 'Luanda');

#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
# SOLUTION TO THE QUESTION!

# Get the region of the city named Yaren
SELECT * FROM CITY WHERE NAME = 'Yaren';
# Get the countrycode of the city named Yaren
SELECT COUNTRYCODE FROM CITY WHERE NAME = 'Yaren';
# Get the region of the country where the city named Yaren is located
SELECT REGION FROM COUNTRY WHERE CODE = (SELECT COUNTRYCODE FROM CITY WHERE NAME = 'Yaren');

SELECT CITY.NAME FROM CITY JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE WHERE COUNTRY.REGION = (SELECT REGION FROM COUNTRY WHERE CODE = (SELECT COUNTRYCODE FROM CITY WHERE NAME = 'Yaren')) AND COUNTRY.CAPITAL = CITY.ID;

#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga
#
SELECT * FROM CITY WHERE CITY.NAME = 'RIGA';
SELECT * FROM COUNTRY WHERE COUNTRY.CODE = (SELECT COUNTRYCODE FROM CITY WHERE CITY.NAME = 'RIGA');


# SOLUTION TO THE QUESTION!
SELECT LANGUAGE FROM COUNTRYLANGUAGE WHERE COUNTRYCODE IN (SELECT CODE FROM COUNTRY WHERE REGION = (SELECT REGION FROM COUNTRY WHERE CODE = (SELECT COUNTRYCODE FROM CITY WHERE NAME = 'Riga'))) GROUP BY LANGUAGE;

# 20: Get the name of the most populous city
SELECT NAME FROM CITY WHERE POPULATION = (SELECT MAX(POPULATION) FROM CITY);
#
