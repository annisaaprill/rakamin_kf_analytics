CREATE TABLE `kimia_farma.analysis_table` AS
SELECT
    t.transaction_id,
    t.date,
    c.branch_id,
    c.branch_name,
    c.kota,
    c.provinsi,
    c.rating AS branch_rating,
    t.customer_name,
    t.product_id,
    p.product_name,
    t.price,
    t.discount_percentage,
    CASE 
        WHEN t.price <= 50000 THEN 0.1
        WHEN t.price <= 100000 THEN 0.15
        WHEN t.price <= 300000 THEN 0.2
        WHEN t.price <= 500000 THEN 0.25
        ELSE 0.3
    END AS persentase_gross_laba,
    t.price * (1 - t.discount_percentage) AS nett_sales,
    t.price * (1 - t.discount_percentage) * 
        CASE 
            WHEN t.price <= 50000 THEN 0.1
            WHEN t.price <= 100000 THEN 0.15
            WHEN t.price <= 300000 THEN 0.2
            WHEN t.price <= 500000 THEN 0.25
            ELSE 0.3
        END AS nett_profit,
    t.rating AS transaction_rating
FROM
    `kimia_farma.kf_final_transaction` t
JOIN
    `kimia_farma.kf_kantor_cabang` c ON t.branch_id = c.branch_id
JOIN
    `kimia_farma.kf_inventory` i ON t.product_id = i.product_id
JOIN
    `kimia_farma.kf_product` p ON t.product_id = p.product_id;
