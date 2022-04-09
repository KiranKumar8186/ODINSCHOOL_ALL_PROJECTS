#=========================================================================================================================================================================#
## Q1. Write a SQL query to find those reviewers who have rated nothing for some movies. Return reviewer name.
#=========================================================================================================================================================================#
-------------# SELECTING REVIEWER NAME FROM REVIEWER TO FIND THAT THOSE REVIEWERS WHO HAVE RATED NOTHING FOR SOME MOVIES FROM TAKING REFERENCE OF TABLE RATING WHICH IS HAVING RATING COLUMN

SELECT 
    REVIEWER.REV_NAME AS 'REVIEWER NAME'
FROM
    REVIEWER
        NATURAL JOIN
    RATING
WHERE
    RATING.REV_STARS IS NULL; 
    
#=========================================================================================================================================================================#
## Q2. Write a SQL query to find the movies, which have been reviewed by any reviewer body except by 'Paul Monks'. Return movie title.
#=========================================================================================================================================================================#
----------------# SELECTING MOVIE TITLE FROM MOVIE TABLE
----------------# AND TAKING 'RATING AND REVIEWER' TABLES TO FIND THE MOVIE WHICH HAVE BEEN REVIEWED BY ANY REVIEWER EXCEPT BY "PAUL MONKS"

SELECT 
    MOVIE.MOV_TITLE AS 'MOVIE TITLE'
FROM
    MOVIE
WHERE
    MOV_ID IN (SELECT 
            MOV_ID
        FROM
            RATING
        WHERE
            REV_ID NOT IN (SELECT 
                    REV_ID
                FROM
                    REVIEWER
                WHERE
                    REV_NAME = 'PAUL MONKS'));
#=========================================================================================================================================================================#
## Q3. Write a SQL query to find the lowest rated movies. Return reviewer name, movie title, and number of stars for those movies. 
#=========================================================================================================================================================================#
----------------# SELECTING REVIEWER NAME, MOVIE TITLE AND REVIEWER STARS FROM 'REVIEWER', 'MOVIE' AND 'RATING' TABLES
----------------# TO FIND THE LOWESR RATED MOVIES 

SELECT 
    REVIEWER.REV_NAME AS ' REVIEWER NAME',
    MOVIE.MOV_TITLE AS 'MOVIE TITLE',
    RATING.REV_STARS AS 'NUMBER OF STARS FOR MOVIES'
FROM
    MOVIE
        NATURAL JOIN
    RATING
        NATURAL JOIN
    REVIEWER
WHERE
    RATING.REV_STARS = (SELECT 
            MIN(RATING.REV_STARS)
        FROM
            RATING
        WHERE
            REV_STARS != 0); 
            
#=========================================================================================================================================================================#
## Q4. Write a SQL query to find the movies directed by 'James Cameron'. Return movie title.
#=========================================================================================================================================================================#
----------------# SELECTING MOVIE TITLE FROM MOVIE TABLE
----------------# FIND THE MOVIES DIRECTED BY 'JAMES CAMERON' USING 'MOVIE', 'MOVIE_DIRECTION' AND 'DIRECTOR' TABLES AND ALSO USED NATURAL JOIN  

SELECT 
    MOVIE.MOV_TITLE AS 'MOVIE TITLE'
FROM
    MOVIE
        NATURAL JOIN
    MOVIE_DIRECTION
        NATURAL JOIN
    DIRECTOR
WHERE
    DIRECTOR.DIR_FNAME = 'JAMES' AND DIRECTOR.DIR_LNAME = 'CAMERON';     
    
#=========================================================================================================================================================================#
## Q5. Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies. 
#=========================================================================================================================================================================#
----------------# SELECTED MOVIE TITLE FROM MOVIE TABLE
----------------# AND FINDING THE NAME OF THOSE MOVIES WHERE ONE OR MORE ACTORS ACTED IN 2 OR MORE MOVIES

SELECT 
    MOVIE.MOV_TITLE AS 'MOVIE NAME'
FROM
    MOVIE
WHERE
    MOV_ID IN (SELECT 
            MOV_ID
        FROM
            MOVIE_CAST
        WHERE
            ACT_ID IN (SELECT 
                    ACT_ID
                FROM
                    ACTORS
                WHERE
                    ACT_ID IN (SELECT 
                            ACT_ID
                        FROM
                            MOVIE_CAST
                        GROUP BY ACT_ID
                        HAVING COUNT(ACT_ID) > 1)));
                        
#==================================================================================================================================================================#
## Q6. Given a relation R( A, B, C, D) and Functional Dependency set FD = { AB → CD, B → C }, determine whether the given R is in 2NF? If not, convert it into 2 NF.
#==================================================================================================================================================================#

-- FD = { AB → CD, B → C }
-- R (A, B, C, D)

                          ---------------## LET US CALCULATE THE CLOSURE OF AB ##---------------

-- AB = A, B, C, D 
-- Since the closure of AB contains all the attributes of R, hence AB is Candidate Key
-- And there are no other Candidate Key that gives all attributes.
-- Hence there will be only one candidate key AB. So, AB will the Primary Key.


                          ---------------## 2nd NORMAL FORM (NO PARTIAL DEPENDENCY) ##----------------

-- NO NON-PRIMARY ATTRIBUTE SHOULD BE PARTIALLY DEPENDENT ON CANDIDATE KEY 'AB'
-- FD : AB -> CD is satisfies 2NF, non-prime attributes CD are fully depending on Candidate Key AB.
-- FD : B -> C is not satisfies 2NF, non-prime attribute C is partially depending on Candidate Key AB (B -> C).

-- AS FUNCTIONAL DEPENDENCY (B -> C), THE ABOVE GIVEN TABLE R(A, B, C, D) IS NOT IN 2NF. SO, CONVERT THE TABLE IN 2NF.
-- Since FD : B -> C, Given table was not in 2NF, Let's change the table
-- R1(B, C)
-- Since FD ; AB -> CD, we can create table like R2(A, B, C, D), but this will again have a problem of partial dependency (B -> C)
-- Then table will be R2(A, B, D).
-- "Finally, converted tables are in 2NF"

#====================================================================================================================================================================#
## Q7. Given a relation R( P, Q, R, S, T) and Functional Dependency set FD = { PQ → R, S → T }, determine whether the given R is in 2NF? If not, convert it into 2 NF.
#====================================================================================================================================================================#

-- FD = { PQ → R, S → T }
-- R(P, Q, R, S, T)

                      -------------## LET US CALCULATE THE CLOSURE OF PQ AND S ##-------------

-- PQ = P, Q, R
-- S = S, T
-- Attributes PQ and S are individually not giving the all attributes.
-- Hence PQS will be the integral part of the Candidate Key. Lets calculate closure of PQS.
-- PQS = P, Q, R, S, T
-- Since the closure of PQS contains all the attributes of R(given table), hence PQS is Candidate Key.
-- And there is no other Candidate Key which gives all attributes.
-- PQS will be the Primery Key for table R.

                      -------------## 2nd NORMAL FORM (NO PARTIAL DEPENDENCY) ##--------------

-- Here given table 'R' has 5 attributes (P,Q,R,S,T) and CK is PQS, Prime attributes are (P,Q,S) and non prime attributes are (R,T).
-- FD: PQ -> R is not satisfies 2NF, non prime attribute R is partially depending on Candidate Key PQS.
-- FD: S -> T is not satisfies 2Nf, non prime attribut T is partially depending on Candidate Key PQS.

-- AS FD: (PQ -> R) AND (S -> T), THE ABOVE GIVEN TABLEL IS NOT IN 2NF. LET'S CONVERT TABLE IN 2NF.
-- Since FD: PQ -> R, the given table is not in 2NF, let's decompose the table
-- R1(P, Q, R)
-- Since FD: S -> T, the given table is not in 2NF, let's decompose the table
-- R2(S,T)
-- Finally converted tables R1 and R2 are in 2NF

#============================================================================================================================================================================================================#
## Q8. Given a relation R( P, Q, R, S, T, U, V, W, X, Y) and Functional Dependency set FD = { PQ → R, PS → VW, QS → TU, P → X, W → Y }, determine whether the given R is in 2NF? If not, convert it into 2 NF.
#============================================================================================================================================================================================================#

-- GIVEN FUNCTION DEPENDENCY
-- PQ → R
-- PS → VW
-- QS → TU
-- P → X
-- W → Y
-- GIVEN TABLE 
-- R(P, Q, R, S, T, U, V, W, X, Y)
-- Individual attributes not giving all attributes.
-- Hence PQS will be the integral part of the Candidate Key. Lets calculate closure of PQS.

                      -------------## LET US CALCULATE THE CLOSURE OF PQS ##-------------

-- PQS = P, Q, R, S, V, W, T, U, X, Y
-- Since the closure of PQS contains all the attributes of R(given table), hence PQS is Candidate Key.
-- And there is no other Candidate Key which gives all attributes.
-- PQS will be the Primery Key for table R.

                      -------------## 2nd NORMAL FORM (NO PARTIAL DEPENDENCY) ##--------------

-- Here given table 'R' has 10 attributes (P,Q,R,S,T,U,V,W,X,Y) and CK is PQS, Prime attributes are (P,Q,S) and non prime attributes are (R,T,U,V,W,X,Y).
-- FD: PQ → R is not satisfies 2NF, non-prime attribute R is partially depending on Candidate Key PQS (I.E.,KEY SHOULD NOT BE BROKEN).
-- FD: PS → VW is not satisfies 2NF, non-prime attribute VW is partially depending on Candidate Key PQS.
-- FD: QS → TU is not satisfies 2NF, non-prime attribute TU is partially depending on Candidate Key PQS.
-- FD: P → X is not satisfies 2NF, non-prime attribute X is partially depending on Candidate Key PQS.
-- FD: W → Y is does not voilate the 2NF, as the non-prime attribute Y is dependent on the non-prime attribute W, which is not related to the definition of 2NF.

-- AS FD: {PQ → R, PS → VW, QS → TU, P → X}, THE ABOVE GIVEN TABLE R( P, Q, R, S, T, U, V, W, X, Y) IS NOT IN 2NF. LET'S CONVERT THE TABLE R( P, Q, R, S, T, U, V, W, X, Y) IN 2NF.
-- Since FD: PQ -> R, the given table is not in 2NF, let's decompose the table
-- R1(P, Q, R)
-- Since FD: PS -> VW, the given table is not in 2NF, let's decompose the table
-- R2(P, S, V, W)
-- Since FD: QS -> TU, the given table is not in 2NF, let's decompose the table
-- R3(Q, S, T, U)
-- Since FD: P -> X, the given table is not in 2NF, let's decompose the table
-- R4(P, X)
-- Since FD: W → Y is does not voilate the 2NF,But here non prime attributes W is depending on prime attribute PS (PS -> V , PS -> W). So we can create table like
-- R5(P, S, Y) 
-- Finally decomposed tables are 2NF.

#============================================================================================================================================================================================================#
-- Q9. Given a relation R( X, Y, Z, W, P) and Functional Dependency set FD = { X → Y, Y → P, and Z → W}, determine whether the given R is in 3NF? If not, convert it into 3 NF.
#============================================================================================================================================================================================================#

-- GIVEN FUNCTION DEPENDENCY
-- X → Y
-- Y → P
-- Z → W
-- GIVEN TABLE
-- R( X, Y, Z, W, P)
-- Individual attributes not giving all attributes.
-- Hence XZ will be the integral part of the Candidate Key. Lets calculate closure of XP. 

                      -------------## LET US CALCULATE THE CLOSURE OF XZ ##-------------
 
-- XZ = X, Y, P, Z, W
-- Since the closure of XZ contains all the attributes of R(given table), hence XZ is Candidate Key.
-- And there is no other Candidate Key which gives all attributes.
-- XZ will be the Primery Key for table R.

-- BEFORE GOING TO CHECK 3NF WE HAVE TO MAKE SURE THAT THE TABLE IS IN 2NF

                      -------------## 2nd NORMAL FORM (NO PARTIAL DEPENDENCY) ##--------------

-- Here given table has 5 attributes (X, Y, Z, W, P) and CD is XZ. Prime Attributes are (X,Z) and non-prime attributes are (Y, W, P).
-- FD: X → Y is not satisfies 2NF, non-prime attribute Y is partially depending on Candidate Key XZ.
-- FD: Y → P is not voilating the 2NF, as the non-prime attribute Y is dependent on the non-prime attribute W, which is not related to the definition of 2NF.
-- FD: Z → W is not satisfies 2NF, non-prime attribute W is partially depending on Candidate Key XZ.

-- The given table 'R' is not in 2NF. Because NPA's are partially depending on Candidate Key XZ.
-- Lets split the table to get 2NF
-- Since FD: X -> Y, the given table is not in 2NF. Let's decompose table
-- R1(X,Y)

---# HERE, [FD: Y -> P] IS NOT VOILATING THE 2ND NORMAL FORM. BUT, NON PRIME ATTRIBUTE IS DEPENDING ON NON PRIME ATTRIBUTE. ITS VOILATING 3RD NORMAL FORM THAT WE WILL SOLVE IN NEXT STEP

-- Since FD: Z -> W, the given table is not in 2NF. Let's decompose table
-- R2(Z,W) 

                      -------------## 3Rd NORMAL FORM (NO TRANSITIVE DEPENDENCY) ##-------------

-- From above tables are in 2NF
-- But there is 'transitive dependency' which is non prime attribute P is dependent on non prime attribute Y. 
-- This FD: Y -> P is not in 3NF. Let's decompose the table
-- The "NPA" 'P' dependent on Non-Prime Attribute 'Y' and Non-Prime Attribute 'Y' is dependent on Prime Attribute 'X'. 
-- So, here the Non-Prime Attribute 'P' is also dependent on Prime Attribute 'X' through Non-Prime Attribute 'Y'. Then the table will be 
-- R3(X, P)
-- Final tables are R1(X, Y), R3(X,P), R2(Z,W)

#============================================================================================================================================================================================================#
## Q10. Given a relation R( P, Q, R, S, T, U, V, W, X, Y) and Functional Dependency set FD = { PQ → R, P → ST, Q → U, U → VW, and S → XY}, determine whether the given R is in 3NF? If not, convert it into 3 NF.
#============================================================================================================================================================================================================#    

-- GIVEN FUNCTION DEPENDENCY
-- PQ → R
-- P → ST
-- Q → U
-- U → VW
-- S → XY
-- GIVEN TABLE
-- R( P, Q, R, S, T, U, V, W, X, Y )
-- Individual attributes not giving all attributes.
-- Hence PQ will be the integral part of the Candidate Key. Lets calculate closure of PQ.

                      -------------## LET US CALCULATE THE CLOSURE OF PQ ##-------------

-- PQ = P, Q, R, S, T, U, V, W, X, Y
-- Since the closure of PQ contains all the attributes of R(given table), hence PQ is Candidate Key.
-- And there is no other Candidate Key which gives all attributes.
-- PQ will be the Primery Key for table R.

-- BEFORE GOING TO CHECK 3NF WE HAVE TO MAKE SURE THAT THE TABLE IS IN 2NF

                      -------------## 2nd NORMAL FORM (NO PARTIAL DEPENDENCY) ##--------------

-- Here given table has 10 attributes (P, Q, R, S, T, U, V, W, X, Y) and Candidate Key is PQ. Prime Attributes are (P,Q) and non-prime attributes are (R,S,T,U,V,W,X,Y).
-- FD: PQ → R is satisfies 2NF, non prime attribute R is fully dependent on Candidate Key PQ.
-- FD: P → ST is not satisfies 2NF, non-prime attributes ST are partially dependent on Candidate Key PQ.
-- FD: Q → U is not satisfies 2NF, non-prime attribute U is partially dependent on Candidate Key PQ. 
-- FD: U → VW is not voilating the 2NF, as the non-prime attribute VW is dependent on the non-prime attribute U, which is not related to the definition of 2NF.
-- FD: S → XY is also not voilating the 2NF, as the non-prime attributes XY are dependent on the non-prime attribute S.

-- The given table 'R' is not in 2NF. Because NPA's are partially depending on Candidate Key PQ.
-- Lets split the table to get 2NF
-- Since FD: PQ → R, the given table is not in 2NF. Let's decompose table
-- R1(P, Q, R)
-- Since FD: P → ST, the given table is not in 2NF. Let's decompose table
-- R2(P, S, T)
-- Since FD: Q → U, the given table is not in 2NF. Let's decompose table
-- R3(Q, U)

---# HERE, [FD: U → VW] AND [FD: S → XY] ARE NOT VOILATING THE 2ND NORMAL FORM. BUT, NON PRIME ATTRIBUTES ARE DEPENDING ON NON PRIME ATTRIBUTES. THESE ARE VOILATING 3RD NORMAL FORM.

                      -------------## 3Rd NORMAL FORM (NO TRANSITIVE DEPENDENCY) ##-------------
                      
-- From above tables are in 2NF
-- But there is 'transitive dependency' which is non prime attribute 'VW' is dependent on non prime attribute 'U' and NPA 'XY' is dependent on NPA 'S'. 
-- This FD: Y -> P is not in 3NF. Let's decompose the table

-- The non-prime attribute 'VW' dependent on non-prime attribute 'U' and non-prime attribute 'U' is dependent on prime attribute 'Q' [ FROM FD: Q -> U]. 
-- So, here the NPA 'VW' is alse dependent on Prime Attribute 'Q' through NPA 'U'. Then the table will be 
-- R4(Q, V, W)

-- The non-prime attribute 'XY' dependent on non-prime attribute 'S' and non-prime attribute 'S' is dependent on prime attribute 'P' [FROM FD: P -> ST, WE CAN WRITE THIS LIKE {P -> S} AND {P ->T}]. 
-- So, here the Non-Prime Attribute 'XY' is also dependent on Prime Attribute 'P' through Non-Prime Attribute 'S'. Then the table will be 
-- R5(P, X, Y)

-- Final tables after satisfying the 3rd Normal Form
-- R1(P, Q, R), R2(P, S, T), R3(Q, U), R4(Q, V, W), R5(P, X, Y)
##===========================================================================================================================================================================================================##