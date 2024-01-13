# MARKET BASKET ANALYSIS

<img src="https://github.com/WAKIOM/Market-basket-analysis-ecommerce/blob/22aa076a320c4714a6ae38a7c49b9892283ce413/Market%20basket.jpeg" height="400" width="300" />

# Overview
For this project, I'm acting as a data analyst who works for a retail company. My task is to perform market basket analysis to uncover patterns in customer purchasing behavior, to identify which products tend to be bought together inorder to help the company make informed decisions, to improve sales and improve customer satisfaction.

# Tools 
    Python
    Jupyter Notebook
#### Python Libraries used
    Pandas - Data preprosessing, Cleaning & EDA
    mlxtend - Market Basket Analysis
    Seaborn  - Visualization
    Matplotlib -  Visualization
#### ML Algorithm used
    Apriori algorithm

# High-Level Steps
## 1.  Data Preparation
+  Imported the necessary packages
+  Changed the data types for date column from string to datetime and member number from int to string
+  Checked for null values, no nulls were found
+  Removed duplicates
+  Feature engineering: created Day, Month and Year columns out of the Date column.

## 2.  Exploratory Data Analysis
+ Count of unique customers
+ Count of unique products
+ Average products purchased per customer
+ Average number of visits per customer
+ Total number of products purchased by each customer
+ Total number of unique visits by each customer
+ Top 10 most purchased items: 
+ Count of products purchased every year & percentage increase in products purchased
+ Count of products purchased every month

## 3.  Market Basket Analysis
+ Grouped the data by Member number and date to get the items purchased by a particular member (a basket), then made a list of lists out of the baskets. Then calculated the support metric for every item
+ One hot encoded the list of lists and transformed it into a dataframe
+ Applied the apriori algorithm to the dataframe to get the frequent itemsets, setting the minimum support to 0.005, in order to get itemsets that appear in at least 0.5% of the transactions, at the same time avoiding a large and unnecessarily large number of frequent itemsets 
+ Created rules using the `association_rules` function, using the `lift` metric because it provides measure of the strength of the association between items. Eliminating the possibility of capturing associations occurring due to change
+ Sorted the results by `Zhangs metric` to identify items with high association, because it takes into account both the support and confidence of a rule

## 4.  Visualization
+ Histogram showing frequencies of number of products purchased per customer
+ Histogram  showing frequencies of visits for Customers
+ Bar chart showing top 10 customers in terms of no. of items purchased
+ Line plot showing trends per month for the different years
+ Bar chart showing top 10 most purchased items
+ Heatmap of antecedents and consequents using zhengs metric as values, as it is the most effective metric to identify association between items. filtered for rules where `zhangs metric > 0` because those show high association.


# [Analysis Notebook](https://github.com/WAKIOM/Market-basket-analysis-ecommerce/blob/master/Market%20Basket%20Analysis%20for%20E-commerce.ipynb)


## Interpretation and Insights

####   Exploratory analysis 
+ The total number of unique customers is: `3898`
+ The number of unique items purchased is: `167`
+ The average number of visits per customer is: `4`
+ `1849` customers have visited the store less than 4 times, that is `47.43 %` of the total customers
+ `52.57 %` percent of the total customers have visited the store more than 4 times.
+ The average number items bought per customer is `10`  with over 500 customers falling into this category.
+ `2061` customers have bought less than 10 items, that is `52.87 %` of the total customers 
+ As the number of items bought increases, the number of customers who bought that many items generally decreases. This suggests that most customers tend to buy a smaller number of items.
+ The number of items purchased have increased from the year 2014 to 2015 by `10.85 %`
+ The month with the highest cumulative items purchased is August
+ December has the least cumulative number of items purchased
+ There are significant rise and drops in the number of items sold through the months
####   Market Basket Analysis
+ whole milk, other vegetables, rolls/buns, soda, yogurt are the most frequently boughts items
+ Frankfurters and other vegetables are frequently bought together. This has a lift of `0.1`, which means that customers who buy frankfurters are 10% more likely to also buy other vegetables than customers who do not buy frankfurters.
+ Sausages are frequently bought together with yogurt. This suggests that people who buy other sausages are likely to also buy yogurt
+ Soda and sausages are slightly likely to be bought together

## Recommendations
<font size=3>
    <ul>
<li> Most customers tend to but goods in small quantities while a few buy in bulk, the store could offer bulk discounts to attract more of the customers who tend to buy a large number of items. </li>
<li> The percentage of customers who have shopped less than 4 times is a bit high, or they could be one time buyers. Investigations should be done to check whether it is due to customer churn or they are just infrequent customers who purchase in bulk.</li>
<li> Segment customers based on their purchase frequency and average number of items per basket. You could target infrequent shoppers with promotional offers to encourage them to shop more often, and you could target frequent shoppers with loyalty programs and exclusive discounts </li>
<li> Utilize seasonal trends to inform your promotional campaigns. For example, you could create marketing campaigns during months that show low sales </li>
<li> Place frequently bought items together (sausages and soda; other vegetables and frankfurters, sausages and yoghurt) </li>
<li> Highlight complementary products through cross-selling promotions. This could involve offering discounts on complementary items when a customer purchases a particular product, or it could involve sending targeted emails or notifications to customers about products that they may be interested in based on their past purchases.</li>
    </ul>
 </font>
