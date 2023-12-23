-- NON GRADED CHALLENGE 7 - PHASE 0
-- By Catherine Helenna Mulyadi </center>
-- RMT - 027

-- This assignment aims to practice SQL functions: convert data types when doing Data Query Language (DQL),
-- group and sort data, and perform subqueries.

-- Objectives:
-- 1. shows number of registered patents containing ßthe word 'data' between 2012 and 2023.

-- import auth and bigquery to access data from google cloud
from google.colab import auth
from google.cloud import bigquery
import pandas as pd

auth.authenticate_user()
-- input project_id from google cloud, enable API
project_id = "patents-public-data-408711"
client = bigquery.Client(project=project_id)

-- put query here
-- access the dataset
query = """SELECT*FROM patents-public-data. uspto_oce_cancer.publications"""

-- Set up the query 
query_job = client.query(query).to_dataframe()
query_job

-- TASK COMPLETION
-- -----------------------------------------------
-- CONDITIONS:
-- the patents were registered in 2012 to 2023
-- the patents contain the keyword "data"

-- PROCESS
-- -----------------------------------------------
-- initially, select the columns you want to display on the table: year, month, and count total_patent
-- from subquery, define more specificly what kind of data included in year, month, and total_patent
-- create the conditions.
-- display the cumulative number of patents sorted by largest year and smallest month.

data_output = """
SELECT
  year,
  month,
  COUNT(DISTINCT Patent_Title) AS total_patent
FROM (
  SELECT
    LEFT(CAST(Filing_Date AS STRING), 4) AS year,
    SUBSTR(CAST(Filing_Date AS STRING), 5, 2) AS month,
    Patent_Title
  FROM `patents-public-data.uspto_oce_cancer.publications`
  WHERE
    Filing_Date BETWEEN '2012-01-01' AND '2023-12-31'
    AND Patent_Title LIKE '%data%'
)
GROUP BY month, year
ORDER BY year DESC, month ASC;
"""

-- Set up the query
data_output_job = client.query(data_output).to_dataframe()
data_output_job