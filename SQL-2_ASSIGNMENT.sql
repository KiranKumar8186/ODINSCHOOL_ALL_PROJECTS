#=========================================================================================================================================================================#
## Q1.Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role.
#=========================================================================================================================================================================#
------------# SELECTING 'ACT_FNAME', 'ACT_LNAME' AND 'ROLE' FROM 'ACTRORS' AND 'MOVIE_CAST' TABLES FOR TO GETTING THE _ACTORS_ WHO WERE CAST IN THE MOVIE 'ANNIE HALL' #------------
------------# HERE I USED "NATURAL JOIN", BECAUSE THAT CREATES AN IMPLICIT JOIN CLAUSE FOR YOU BASED ON COMMON COLUMNS IN TWO TABLES BEING JOINED #------------

SELECT 
    ACTORS.ACT_FNAME AS 'ACTOR FIRST NAME',
    ACTORS.ACT_LNAME AS 'ACTOR LAST NAME',
    MOVIE_CAST.ROLE AS 'ACTOR ROLE'
FROM
    ACTORS
        NATURAL JOIN
    MOVIE_CAST
        NATURAL JOIN
    MOVIE
WHERE
    MOVIE.MOV_TITLE = 'ANNIE HALL';

#==========================================================================================================================================================================================#
## Q2.From the following tables, write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name and movie title.
#==========================================================================================================================================================================================#
------------# SELECTING 'DIRECTOR FIRST NAME', 'LAST NAME' AND 'MOVIE TITLE' FROM 'DIRECTOR' AND 'MOVIE' TABLES TO GET THAT _DIRECTOR_ WHO DIRECTED A _MOVIE_ THAT CASTED A ROLE FOR 'EYES WIDE SHUT' #------------
------------# HERE I USED "NATURAL JOIN" - 'DIRECTOR' AND 'MOVIE_DIRECTION' TABLES HAVING 'DIR_ID' COMMON COLUMN, 'MOVIE_DIRECTION' AND 'MOVIE' TABLES HAVING 'MOV_ID' COMMON COLUMN  #------------

SELECT 
    DIRECTOR.DIR_FNAME AS 'DIRECTOR FISRT NAME',
    DIRECTOR.DIR_LNAME AS 'DIRECTOR LAST NAME',
    MOVIE.MOV_TITLE AS 'MOVIE NAME'
FROM
    DIRECTOR
        NATURAL JOIN
    MOVIE_DIRECTION
        NATURAL JOIN
    MOVIE
WHERE
    MOVIE.MOV_TITLE = 'EYES WIDE SHUT';
    
#=========================================================================================================================================================================#
## Q3.Write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. Return director first name, last name and movie title.
#=========================================================================================================================================================================#
------------# SELECTING 'DIRECTOR FIRST NAME', 'DIRECTOR LAST NAME' AND 'MOVIE TITLE' FROM 'DIRECTOR' AND 'MOVIE' TABLES TO FIND WHO DIRECTED A MOVIE THAT CASTED A ROLE AS 'SEAN MAGUIRE' #------------
------------# I USED 'DIRECTOR', 'MOVIE_DIRECTION', 'MOVIE' AND 'MOVIE_CAST' TABLES BECAUSE FOR GETTING 'MOVIE TITLE' AND 'DIRECTORS NAME' (THESE 4 TABLES ARE LINK WITH COMMON COLUMN) #------------

SELECT 
    DIRECTOR.DIR_FNAME AS 'DIRECTOR FISRT NAME',
    DIRECTOR.DIR_LNAME AS 'DIRECTOR LAST NAME',
    MOVIE.MOV_TITLE AS 'MOVIE NAME'
FROM
    DIRECTOR
        NATURAL JOIN
    MOVIE_DIRECTION
        NATURAL JOIN
    MOVIE
        NATURAL JOIN
    MOVIE_CAST
WHERE
    MOVIE_CAST.ROLE = 'SEAN MAGUIRE';
    
#======================================================================================================================================================================================================#
## Q4.Write a SQL query to find the actors who have not acted in any movie between 1990 and 2000 (Begin and end values are included.). Return actor first name, last name, movie title and release year. 
#======================================================================================================================================================================================================#
------------# SELECTED 'ACTOR FIRST NAME', 'ACTOR LAST NAME', 'MOVIE TITLE' AND 'MOVIE RELEASED DATE' FROM 'ACTORS' AND 'MOVIE' TABLES AND USED 'DATE_FORMAT' TO GET ONLY MOVIE RELEASE YEAR #------------
------------# TO FIND THE _ACTORS_ WHO HAVE NOT ACTED ANY _MOVIE_ BETWEEN [1990 AND 2000] AND USED "NATURAL JOIN" TO COMPARING COMMON COLUMNS FROM THOSE ALL TABLES TEXT EACH #-----------

SELECT 
    ACTORS.ACT_FNAME AS 'ACTOR FIRST NAME',
    ACTORS.ACT_LNAME AS 'ACTOR LAST NAME',
    MOVIE.MOV_TITLE AS 'MOVIE NAME',
    DATE_FORMAT(MOVIE.MOV_DT_REL, '%Y') AS 'MOVIE RELEASE YEAR'
FROM
    ACTORS
        NATURAL JOIN
    MOVIE_CAST
        NATURAL JOIN
    MOVIE
WHERE
    MOVIE.MOV_YEAR NOT BETWEEN '1990' AND '2000';
    
#===================================================================================================================================================================================================================================================================================================#
## Q5.Write a SQL query to find the directors with number of genres movies. Group the result set on director first name, last name and generic title. Sort the result-set in ascending order by director first name and last name. Return director first name, last name and number of genres movies.
#===================================================================================================================================================================================================================================================================================================#
------------# SELECTED 'DIRECTOR FIRST NAME', 'DIRECTOR LAST NAME', AND 'GENERIC TITLE' FROM 'DIRECTOR' AND 'GENRES' TABLES AND USED 'COUNT' CLAUSE TO GET THE COUNT OF 'GENERIC TITLES' #-----------
------------# GROUPING THE DIRECTOR FIRST NAME, DIRECTOR LAST NAME AND GENERIC TITLES BY USING GROUP BY CLAUSE AND ARRANGING "DIRECTORS FISRT AND LAST NAME" IN ASCENDING ORDER BY USING 'ORDER BY' CLAUSE #-----------

SELECT 
    DIRECTOR.DIR_FNAME AS 'DIRECTOR FIRST NAME',
    DIRECTOR.DIR_LNAME AS 'DIRECTOR LAST NAME',
    COUNT(GENRES.GEN_TITLE) AS 'NUMBER OF GENRES MOVIE'
FROM
    GENRES
        NATURAL JOIN
    MOVIE_GENRES
        NATURAL JOIN
    MOVIE_DIRECTION
        NATURAL JOIN
    DIRECTOR
GROUP BY DIRECTOR.DIR_FNAME , DIRECTOR.DIR_LNAME , GEN_TITLE
ORDER BY DIRECTOR.DIR_FNAME , DIRECTOR.DIR_LNAME;

#======================================================================================================================================================================================================#
## Q6. Write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title.
#======================================================================================================================================================================================================#
------------# SELECTED 'MOVIE TITLE', 'MOVIE YEAR' AND 'GENERIC TITLE' FROM 'MOVIE' AND 'GENRES' TABLES TO GET THE MOVIES WITH YEAR AND GENRES #------------

SELECT 
    MOVIE.MOV_TITLE AS 'MOVIE TITLE',
    MOVIE.MOV_YEAR AS 'MOVIE YEAR',
    GENRES.GEN_TITLE AS 'GENERIC TITLE'
FROM
    GENRES
        NATURAL JOIN
    MOVIE_GENRES
        NATURAL JOIN
    MOVIE;

#======================================================================================================================================================================================================#
## Q7.Write a SQL query to find all the movies with year, genres, and name of the director. 
#======================================================================================================================================================================================================#
------------# SELECTED 'MOVIE YEAR', 'GENERIC TITLE' AND 'DIRECTORS FIRST AND LAST NAMES' FROM 'MOVIE', 'GENRES' AND 'DIRECTORS' TABLES #------------
------------# TO FIND ALL THE MOVIES WITH YEAR, GENRES AND NAME OF THE DIRECTORS #-----------
------------# USED NATURAL JOIN TO TAKE COMMON COLUMN FROM ALL THE TABLES TEXT TO EACH #-----------

SELECT 
    MOVIE.MOV_YEAR AS 'MOVIE YEAR',
    GENRES.GEN_TITLE AS ' GENERIC TITLE',
    CONCAT(DIRECTOR.DIR_FNAME, ' ', DIRECTOR.DIR_LNAME) AS 'DIRECTOR NAME'
FROM
    GENRES
        NATURAL JOIN
    MOVIE_GENRES
        NATURAL JOIN
    MOVIE
        NATURAL JOIN
    MOVIE_DIRECTION
        NATURAL JOIN
    DIRECTOR ;
    
#============================================================================================================================================================================================================================================#
## Q8.Write a SQL query to find the movies released before 1st January 1989. Sort the result-set in descending order by date of release. Return movie title, release year, date of release, duration, and first and last name of the director. 
#============================================================================================================================================================================================================================================#
------------# SELECTED 'MOVIE TITLE', 'MOVIE RELEASE DATE', 'MOVIE TIME' AND 'DIRECTORS FIRST AND LAST NAMES' FROM 'MOVIE' AND 'DIRECTOR' TABLES  #-----------
------------# USED 'DATE FORMAT' FOR 'MOVIE RELEASED DATE' TO GET ONLY YEAR #-----------
------------# USED 'WHERE' TO FIND THE MOVIES RELEASED BEFORE '1989-01-01' #-----------
------------# ARRANGING "MOVIE RELEASED DATE " IN DESCENDING ORDER BY USING 'ORDER BY' CLAUSE #-----------

SELECT 
    MOVIE.MOV_TITLE AS 'MOVIE NAME',
    DATE_FORMAT(MOVIE.MOV_DT_REL, '%Y') AS 'RELEASE YEAR',
    MOVIE.MOV_DT_REL AS 'MOVIE RELEASE DATE',
    MOVIE.MOV_TIME AS 'MOVIE DURATION',
    DIRECTOR.DIR_FNAME,
    DIRECTOR.DIR_LNAME
FROM
    DIRECTOR
        NATURAL JOIN
    MOVIE_DIRECTION
        NATURAL JOIN
    MOVIE
WHERE
    MOVIE.MOV_DT_REL < '1989-01-01'
ORDER BY MOVIE.MOV_DT_REL DESC ;

#=============================================================================================================================================================================================================================================#    