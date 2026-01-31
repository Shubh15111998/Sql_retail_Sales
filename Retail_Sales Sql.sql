
-- SQL Retail Sales Analysis
create database sql_project01;

Use sql_project01;

create Table retail_sales (
				transactions_id INT Primary key,
				Sale_date	date,
				sale_time	TIME,
				customer_id	INT,
				gender	varchar(10),
				age	INT,
				category varchar(15),	
				quantiy	INT,
				price_per_unit float,	
				cogs	float,
				total_sale float
);


select * from retail_sales;

select * from retail_sales
where quantiy is NULL
		or
        transactions_id is null
        or 
        sale_time is null
        or 
        customer_id is null
        or
        gender is null
        or 
        age is null
        or
        category is null
        or
        price_per_unit is null
        or 
        cogs is null
        or 
        total_sale is null;

select count(*) as total_sale from retail_sales;

## how many unique customers we have 

select count(distinct customer_id) as unique_total from retail_sales;

## how many categories we have 

select count(distinct category) as unique_total from retail_sales;

## write a sql query to retrieve all columns for sales made on '2022-11-05'?

select * from retail_sales
where Sale_date = "2022-11-05";

## write a sql query to retrieve all transactions where the category is "Clothing" and the quantity sold is more than 10 in the month of nov-2022?

select category from retail_sales
where category = "Clothing" and quantiy >= 4 and to_char(Sale_date, 'YYYY-MM') = '2022=11';

## write a sql query to calculate the total sales (total_Sale) for each category

select category, sum(total_sale) as total_Sales, count(*) as total_orders from retail_sales
group by category;

## write a sql query to find the average age of customers who purchased items from the 'Beauty' category.

select category,  avg(age) as average_age
from retail_sales 
where category = 'Beauty';

-- write a sql query to find all the transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000;

-- write a sql query to find the total number of transactions (transaction_id) made by each gender in each category.

select gender, category, count(transactions_id) as total_transactions from retail_sales
group by gender, category;

-- write a sql query to calculate the average sale for each month. find out best selling month in each year.

select avg(total_sale) as average_sale, year(sale_date) as year_date, month(sale_date) as month_date
from retail_sales
group by month_date, year_date
order by average_sale desc;

-- write a sql query to find the top 5 customers based on the highest total sales.

select customer_id, sum(total_sale) as total_sales from retail_sales
group by customer_id
order by total_sales desc
limit 5;

-- write a sql query to find the number of unique customers who purchased items from each category.

select count(distinct customer_id) as unique_customers, category
from retail_sales
group by category;

-- write a sql query to create each shift and number of orders (example morning <= 12, afternoon between 12 & 17, evening >= 17)

select count(transactions_id) as total_orders,
				case
                when extract(hour from sale_time) < 12 then "morning"
                when extract(hour from sale_time) between 12 and 17 then "afternoon"
                else "evening"
                end as shift
from retail_Sales
group by shift;

-- write a sql query to calculate the average sale for each month. Find out the best selling month in each year.

select year, month, average_sale from (
select extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as average_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank_sales
from retail_sales
group by year, date) as t1
where rank_sales = 1








