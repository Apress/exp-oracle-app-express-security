SELECT
 customer_name,
 cust_first_name,
 cust_last_name
FROM
 demo_customers
WHERE
 customer_name = '&P1_SEARCH.'