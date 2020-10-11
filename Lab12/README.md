# Лабораторная 1(12)

## Работа с cube, rollup и window functions

### Общая суть

Лаборатоная состоит из двух частей. В первой части задания заключаются в практике использования функций T-SQL CUBE и ROLLUP. Вторая часть требует использования оконных функций.
Все задания выполнялись на основе базы данных AdventureWorks SalesLT, созданной в Azure SQL Server в качестве примера.
Для запуска скрипта на питоне требуется указать имя файла с запросом а так же свой логин и пароль от базы данных.

```bash
$ python dbconnect.py SQL/2A.sql azureuser *****
```

## Часть 1

Задания (скопировано)

1. Connect to SalesLT database and browse through all tables to learn about database scheme, data and constraints (especially, 'null' and 'not null' columns).

2. For reporting purpose create following queries to the database:

- A. Report about income from sales by product, client and sales person. Please mind discounts. Also mind that for some combinations of values in these dimensions there are no sales at all, so create two versions of queries with and without zero values.

- B. Report about income from sales by product, client and country (region) for billing, shipping and client residency as they can be different. Is it case according our data? But you should generalize in any case. Please mind discounts. You should include in that report only data that supported by sales (so no zero entries except discounted price is zero).

- C. Report about income from sales and provided discounts by location in form of hierarchy city>state/province>country/region. In that report you can rely on unique geographical names, but in general it is not the case. Think about how to solve that task in case that there is a possibility of existence of multiple cities in the same province with the same name. For big cities someone would need more detailed report that can include city districts, solve this task for extra points.

- D. Report about income from sales and provided discounts by product and hierarchy of product categories (high level category-> next level category->...->low level category->product). Please mind that some products can be outside (any) category or be only partially categorized (be not in low level of hierarchy). You can rely on you data to solve to solve this task (especially on that how much subcategories in the current data set), but try to think how to solve this task in general (with arbitrary category tree).

- E. Create integral report on number of product sales by product, client, sales person and hierarchy of regions.

For all your results report about number of rows returned by your select statement. In that assignment you should use `CUBE`, `ROLLUP` and `GROUPING SETS` capabilities, as well as `grouping()` function. Please, avoid to use `UNION` and `UNION ALL` in favor of them (if it's possible).

Решения заданий указанны в файле [cube_rollup.md](cube_rollup.md)

## Часть 2

Задания (скопировано)

All exercises in that paragraph based on AdventureWork database.

1. Create reports about ranking for sales persons:

- A. Rank your sales persons by number of clients, report should include rank, sales person id and client number in descending order.

- B. Rank your sales persons by number of sales, your report should include all sales persons with id, dense rank and number of sales in descending order.

- C. Rank your sales person by income from sales, your report should include all sales persons with id, rank and income in descending order.

2. Create reports about customer base:

- A. Rank regions / states in the country by number of customers (use main office address), your report should include country, state or region, number of customers and percent rank ordered by country (alphabetically) and number of clients (descending). In case of equality in client numbers order region or states alphabetically.

- B. Include in previous report customers without information about address. Use dense rank instead of percent rank in that report.

- C. Rank cities in the country by number of customers (use main office address), your report should include country, state or region, city, number of clients, rank (use plane rank here) and difference in number of client with previous position in by country ranking (for first position should be null). Order your report by country name (alphabetically), number of clients (descending) and city name (alphabetically)

Решения заданий указанны в файле [window_func.md](window_func.md)

## Дополнительно

Ответы на доп вопросы написаны в [addition.md](addition.md)
Сами крипты представленны в виде SQL-файлов в каталоге SQL
