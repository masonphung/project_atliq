# AtliQ sales data analysis and dashboard visualization
`SQL`, `PowerBI`, `Tableau`, `Python`, `data manipulation`, `data analysis`, `data visualization`

Mason Phung

## A small data analysis project with SQL and PowerBI.

AtliQ is a B2B hardware & peripheral manufacturer headquartered in Mumbai, they have many regional branches across India. The company provides computer and network equipments for other businesses. In the previous quarter, the company was reported to have declining sales and their Sales director is having trouble tracking where business is falling in the local Indian market. We will help them to determine the issues by analyze and visualize their sales data.

Case questions:
- Are there any trends on customer purchase behavior throughout the years?
- Is the any issues with certain products/markets/customers?
- What are the bottlenecks/problems that cause the decline in sales in certain markets?
- Any suggestions can be made to tackle found issues?

Special thanks to `codebasics` for problem statement and case explanation. Data mining, analysis and visualization by Mason Phung.
Case source: https://youtu.be/CCNd2fUfFkk


![alt text](img/atliq_dashboard_pbi.png)

## Dashboard features
*New dashboard in PowerBI from ver 2.0*
- Interactive dashboard changed based on filters & selection.
- Changable observing parameters: Revenue, Cost and Price - Look the statistics for in different aspects

## The repo contains 3 files
- `atliq_overview.pdf`: Project overview and the explainations of how I did this project
- `atliq_sql_data_analysis.ipynb`: Data mining with Python and analysis using SQL
- `atliq_data_visualization.twb`: Tableau workbook of the dashboard and plot sheets. Data pulled from the local MySQL database
- `atliq_dashboard.pbix`: PowerBI dashboard, built with the data pulled from the local MySQL database

## Tools
- Local database: MySQL 
- Database management: MySQL Benchmark or DBeaver (for its compatibility with MacOS ARM).   
- IDE: Visual Studio Code
- Python libraries: sqlalchemy, pandas, numpy (for data mining, data manipulation)

## Notes
- Create a local MySQL database and initialize using `mysqlalchemy`.
- Import dumps into the database using `DBeaver` or `MySQL Benchmark`.

## Latest update: ver 2.0
- Upload a jupyter notebook includes SQL queries and Python data manipulation process
- Create a refined interactive dashboard using Power BI

## Uploads
- 2024/08/04: Update ver 2.0
- 2023/10/18: Update ver 1.0