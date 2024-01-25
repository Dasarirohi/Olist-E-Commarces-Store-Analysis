
select count(*) from olist_customers_dataset;
 
 -- KPI  1 Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
SELECT 
    IF(WEEKDAY(olist_orders_dataset.order_purchase_timestamp) IN (5, 6), 'Weekend', 'Weekday') AS day_type, 
    SUM(olist_order_payments_dataset.payment_value) AS total_payment
FROM 
    olist_orders_dataset 
    INNER JOIN olist_order_payments_dataset ON olist_orders_dataset.order_id = olist_order_payments_dataset.order_id
GROUP BY 
    day_type; 
    
    SELECT 
    IF(WEEKDAY(olist_orders_dataset.order_purchase_timestamp) IN (5, 6), 'Weekend', 'Weekday') AS day_type, 
    ROUND(SUM(olist_order_payments_dataset.payment_value), 1) AS total_payment
FROM 
    olist_orders_dataset 
    INNER JOIN olist_order_payments_dataset ON olist_orders_dataset.order_id = olist_order_payments_dataset.order_id
GROUP BY 
    day_type;

    
    -- KPI 2  Number of Orders with review score 5 and payment type as credit card.

select count(r.order_id), r.review_score, p. payment_type
from olist_order_reviews_dataset r  join olist_order_payments_dataset p on r.order_id = p.order_id
where review_score = 5 and payment_type = "credit_card";

 -- KPI 3 Average number of days taken for order_delivered_customer_date for pet_shop

select
 p.product_category_name,
ROUND(AVG(DATEDIFF(od.order_delivered_customer_date,od.order_purchase_timestamp))) AS AVG_Delivery_Days
 FROM olist_products_dataset p
 INNER JOIN olist_order_items_dataset  oi  ON p.product_id = oi.product_id
 INNER JOIN olist_orders_dataset od ON oi.order_id = od.order_id
 WHERE p.product_category_name = "pet_shop"
 GROUP BY
  p.product_category_name;
  
  
  -- KPI 4  Average price and payment values from customers of sao paulo city

SELECT 
  c.customer_city,
ROUND(AVG(i.price)) AS Average_Price,
ROUND(AVG(p.payment_value)) AS Average_Payment
FROM olist_customers_dataset c 
INNER JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
INNER JOIN olist_order_items_dataset i ON o.order_id = i.order_id
INNER JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE c.customer_city = "sao paulo"
GROUP BY c.customer_city;


-- KPI 5 Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores

SELECT review_score, avg(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS avg_shipping_days
FROM olist_orders_dataset o
INNER JOIN olist_order_reviews_dataset r
  ON o.order_id = r.order_id
GROUP BY review_score;

SELECT review_score, sum(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS sum_shipping_days
FROM olist_orders_dataset o
INNER JOIN olist_order_reviews_dataset r
  ON o.order_id = r.order_id
GROUP BY review_score;

SELECT review_score, count(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS count_shipping_days
FROM olist_orders_dataset o
INNER JOIN olist_order_reviews_dataset r
  ON o.order_id = r.order_id
GROUP BY review_score;

 select * from olist_orders_dataset;
