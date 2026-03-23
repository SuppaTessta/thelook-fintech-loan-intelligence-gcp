/* Task: Extract granular 'purpose' data from the nested 'application' column.
BigQuery dot notation is used to access fields within the JSON/Struct record.
*/
SELECT 
  loan_id,
  application.purpose
FROM fintech.loan;

/* Task: Create a reference table for all unique loan purposes across the portfolio.
This deduplicated list helps stakeholders understand the diversity of the loan book.
*/
CREATE TABLE fintech.loan_purposes AS
SELECT DISTINCT 
  application.purpose
FROM fintech.loan;
