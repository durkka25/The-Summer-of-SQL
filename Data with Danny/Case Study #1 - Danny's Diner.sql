--Data with Danny: Case Study #1 - Danny's Diner

--1. What is the total amount each customer spent at the restaurant?
select customer_id
    ,sum(price) as total_spend
from sales 
join menu on sales.product_id=menu.product_id
group by 1

--2. How many days has each customer visited the restaurant?
select customer_id
    ,count (distinct order_date) as days_visited
from sales 
group by 1

--3. What was the first item from the menu purchased by each customer?
--4. What is the most purchased item on the menu and how many times was it purchased by all customers?
--5. Which item was the most popular for each customer?
--6. Which item was purchased first by the customer after they became a member?
--7. Which item was purchased just before the customer became a member?
--8. What is the total items and amount spent for each member before they became a member?
--9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
--10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customers A and B have at the end of January?