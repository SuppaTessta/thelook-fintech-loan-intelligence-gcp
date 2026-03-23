/* Task: Aggregate total loan volume by year to identify growth trends.
*/
SELECT 
  issue_year, 
  SUM(loan_amount) AS total_amount
FROM fintech.loan
GROUP BY issue_year;

/* Task: Create a reporting table for the 'Loan Insights' dashboard to track count by year.
*/
CREATE TABLE fintech.loan_count_by_year AS
SELECT 
  issue_year, 
  COUNT(loan_id) AS loan_count
FROM fintech.loan
GROUP BY issue_year;

/* Task: Stakeholder Metric - Outstanding Loan Calculation.
This query (generated for the Looker dashboard) calculates the total amount 
for all loans not yet 'Fully Paid'.
*/
SELECT 
  COALESCE(SUM(CASE WHEN (loan.loan_status <> 'Fully Paid' OR loan.loan_status IS NULL) 
    THEN loan.loan_amount 
    ELSE NULL END), 0) AS loan_outstanding_loans_amount 
FROM `cloud-training-demos.fintech.loan` AS loan 
LIMIT 500;
