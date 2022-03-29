#=========================================================================================================================================================================#
## Q1. WRITE A SQL QUERY TO FIND THE SALARIES OF ALL EMPLOYEES.
#=========================================================================================================================================================================#
---------------# SELECTING THE FIRST_NAME AND LAST_NAME FORM EMPLOYEES TABLE AND CONCATING THEM AND ALSO SELECTING SALARY #---------------

SELECT 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'EMPLOYEE_NAME',
    SALARY
FROM
    EMPLOYEES;

#=========================================================================================================================================================================#
## Q2. WRITE A SQL QUERY TO FIND THE UNIQUE DESIGNATION OF THE EMPLOYEES. RETURN JOB NAME.
#=========================================================================================================================================================================#
---------------# SELECTING JOB_TITLE FROM JOBS TABLE AND FINDING UNIQUE FROM THEM #--------------- 

SELECT DISTINCT
    (JOB_TITLE) AS 'JOB_NAME'
FROM
    JOBS;

#=========================================================================================================================================================================#
## Q3. WRITE A SQL QUERY TO LIST THE EMPLOYEES NAME, INCREASED THEIRE SALARY NY 15%, AND EXPRESSED AS NUMBER OF DALLARS.
#=========================================================================================================================================================================#
---------------# SELECTING THE FIRST_NAME AND SALARY FROM EMPLOYEES TABLE AND PERFORMING INCREASE OF SALARY BY 15% #---------------  

SELECT FIRST_NAME AS EMP_NAME, 
       ROUND((SALARY+(15*SALARY/100)), 2) AS 'SALARY' 
       FROM EMPLOYEES;
       
#=========================================================================================================================================================================#       
## Q4. Write a SQL query to list the employees name and job name as a format of "Employee & Job".
#=========================================================================================================================================================================#
---------------# SELECTING FIRST_NAME FROM EMPLOYEES TABLE ,JOB_TITLE FROM JOBS TABLE AND CONCATING BOTH AND GIVING '&' TO GET 'EMPLOYEE & JOB' FROMAT #---------------
---------------# USING INNER JOIN TO GET OUTPUT FROM THE REFERENCE OF COMMON COLOMNS FROM BOTH THE TABLES #---------------

SELECT 
    CONCAT(EMPLOYEES.FIRST_NAME, ' &  ', JOBS.JOB_TITLE) AS 'EMPLOYEE & JOB'
FROM
    EMPLOYEES
        INNER JOIN
    JOBS ON EMPLOYEES.JOB_ID = JOBS.JOB_ID
ORDER BY 1;                           

#=========================================================================================================================================================================#           
## 5. Write a SQL query to find those employees with hire date in the format like February 22, 1991. Return employee ID, employee name, salary, hire date.
#=========================================================================================================================================================================#
---------------# SELECTING THR FIRST_NAME, LAST_NAME FROM EMPLOYEES AND CONCATING THEM AND ALSO SELECTING SALARY AND HIRE_DATE FROM SAME TABLE #---------------
---------------# AND PERFORMING DATE_FORMAT TO HIRE_DATE TO GET THE FORMAT OF 'FEB 22,1991' #---------------

SELECT 
    EMPLOYEE_ID,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'EMPLOYEE_NAME',
    SALARY,
    DATE_FORMAT(HIRE_DATE, '%M %d, %Y') AS HIRE_DATE
FROM
    employees;
    
#=========================================================================================================================================================================#    
## 6. Write a SQL query to count the number of characters except the spaces for each employee name. Return employee name length.
#=========================================================================================================================================================================#
---------------# SELECTING FIRST_NAME FROM EMPLOYEES AND WRITING QUERY TO FIND THE COUNT OF NO.OF CHARACTERS EXCEPT THE SPACES FOR EACH EMPLOYEE #--------------- 

SELECT 
    FIRST_NAME AS 'EMPLOYEE NAME',
    LENGTH(REPLACE(FIRST_NAME, ' ', '')) AS 'EMPLOYEE NAME LENGTH'
FROM
    EMPLOYEES;

#=========================================================================================================================================================================#    
## 7. Write a SQL query to find the employee ID, salary, and commission of all the employees. 
#=========================================================================================================================================================================#
---------------# SELECTING EMPLOYEE_ID, SALARY, COMMISSION_PCT FROM EMPLOYEES TABLE #---------------
---------------# TO GET COMMISSION ONLY CONVERTING PERCENTAGE IN THE FORM OF DOLLARS WITH HELP OF SALARY #alter 

SELECT 
    EMPLOYEE_ID,
    SALARY,
    ROUND((COMMISSION_PCT * SALARY / 100), 2) AS 'COMMISSION'
FROM
    EMPLOYEES;

#=========================================================================================================================================================================#
## 8. Write a SQL query to find the unique department with jobs. Return department ID, Job name.
#=========================================================================================================================================================================#
---------------# FINDING THE UNIQUE DEPARTMENT WITH JOBS #---------------

SELECT DISTINCT
    (DEPARTMENT_ID) AS 'DEPARTMENT_ID', JOB_ID
FROM
    EMPLOYEES
ORDER BY 2;

#=========================================================================================================================================================================#
## 9. Write a SQL query to find those employees who joined before 1991. Return complete information about the employees.
#=========================================================================================================================================================================#
---------------# SELECTING HIRE_DATE FROM EMPLOYEES TABLE TO FINDING THAT THOSE EMPLOYEES WHO JOINED BEFORE 1991 #---------------
---------------# AND GETTING COMPLETE INFORMATION ABOUT THE EMPLOYEES #---------------

SELECT 
    *
FROM
    employees
WHERE
    HIRE_DATE < '1991-01-01';

#=========================================================================================================================================================================#
## 10. Write a SQL query to compute the average salary of those employees who work as ‘ANALYST’. Return average salary.
#=========================================================================================================================================================================#
---------------# SELECTING SALARY FROM EMPLOYEES TABLE #---------------
---------------# TO COMPUTE THE AVERAGE SALARY ANALYST JOB ROLE #---------------
---------------# USING INNER JOIN TO GET OUTPUT FROM THE REFERENCE OF COMMON COLOMNS FROM BOTH THE TABLES #---------------

SELECT 
    ROUND(AVG(SALARY), 2) AS 'AVERAGE SALARY'
FROM
    EMPLOYEES
        INNER JOIN
    JOBS ON EMPLOYEES.JOB_ID = JOBS.JOB_ID
WHERE
    JOB_TITLE = 'ANALYST';

#=========================================================================================================================================================================#    