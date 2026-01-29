USE [Bank Loan DB]

SELECT * FROM bank_loan_data

--Total_Loan_Application
SELECT COUNT(id) AS Total_Loan_Applications FROM bank_loan_data

--MTD_Total_Applications
SELECT COUNT(id) AS MTD_Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--PMTD_Total_Applications
SELECT COUNT(id) AS PMTD_Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)=2021

--Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

--MTD Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)=2021

--PMTD Total Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)=2021

--Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data

--MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)=2021

--PMTD Total Amount Received
SELECT SUM(total_payment) AS PMTD_Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)=2021

--Average Interest Rate
SELECT ROUND(AVG(int_rate),4)*100 AS Avg_Interest_Rate FROM bank_loan_data

--MTD Average Interest
SELECT ROUND(AVG(int_rate),4)*100 AS  MTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)=2021

--PMTD Average Interest
SELECT ROUND(AVG(int_rate),4)*100 AS  PMTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)=2021

--Avg DTI
SELECT  ROUND(AVG(dti),4)*100 AS Avg_DTI FROM bank_loan_data

--MTD Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)=2021

--PMTD Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)=2021


SELECT loan_status FROM bank_loan_data

--Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100) 
	/ 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

--Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

--Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--LOAN STATUS
	SELECT
        loan_status,
        COUNT(id) AS Total_Loan_Applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status


SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

--Overview

--Monthly Trends by issue date
SELECT 
    MONTH(issue_date) AS Month_Number,
    DATENAME(MONTH,issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date),DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


--Regional Analysis by State
SELECT 
    address_state,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY  address_state
ORDER BY  SUM(loan_amount) DESC


--Loan Term Analysis
SELECT 
    term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY  term
ORDER BY  term

--emp_length Analysis
SELECT 
    emp_length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY  emp_length
ORDER BY COUNT(id) DESC

--Loan purpose Analysis
SELECT 
    purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC

--home ownership Analysis
SELECT 
    home_ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC


--Details
SELECT 
    home_ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
WHERE grade = 'A' AND address_state ='CA'
GROUP BY home_ownership
ORDER BY COUNT(id) DESC
