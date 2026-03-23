/* Step 1: Ingest external state-to-region mapping data from Cloud Storage.
This allows for geographic segmentation that isn't present in the raw loan data.
*/
LOAD DATA OVERWRITE fintech.state_region
(
  state string,
  subregion string,
  region string
)
FROM FILES (
  format = 'CSV',
  uris = ['gs://sureskills-lab-dev/future-workforce/da-capstone/temp_35_us/state_region_mapping/state_region_*.csv']
);

/* Step 2: Create a unified table by joining loan data with the newly ingested regional data.
This 'Silver' layer table serves as the primary source for regional analysis.
*/
CREATE OR REPLACE TABLE fintech.loan_with_region AS
SELECT
  lo.loan_id,
  lo.loan_amount,
  sr.region
FROM fintech.loan lo
INNER JOIN fintech.state_region sr
  ON lo.state = sr.state;
