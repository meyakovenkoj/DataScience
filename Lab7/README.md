# Get started

First we load ipython package sql
It can be installed by
```bash
pip install ipython-sql
```


```python
%load_ext sql
```

Connect to our database in *docker*


```python
# PostgreSQL local
%sql postgresql://postgres@localhost:5432/datascience
```


```python
%sql select madlib.version();
```

     * postgresql://postgres@localhost:5432/datascience
    1 rows affected.





<table>
    <tr>
        <th>version</th>
    </tr>
    <tr>
        <td>MADlib version: 1.17.0, git revision: unknown, cmake configuration time: Sat Dec 19 21:45:13 UTC 2020, build type: RelWithDebInfo, build system: Linux-4.19.121-linuxkit, C compiler: gcc 5.4.0, C++ compiler: g++ 5.4.0</td>
    </tr>
</table>



## Load data
Create table `survey` to load data. All rows are integers


```python
%%sql
DROP TABLE IF EXISTS survey;

create table survey(mydepv integer, 
                    price integer, 
                    income integer, 
                    age integer);
```

     * postgresql://postgres@localhost:5432/datascience
    Done.
    Done.





    []



Load from file. it was downloaded from [Hyper MEPhIx](https://hyper.mephi.ru/assets/courseware/v1/345e8b1c6ea11120575066ec4ac58f4a/asset-v1:MEPhIx+CS712DS+2020Fall+type@asset+block/survey.csv)



```python
%%sql
COPY survey(mydepv, price, income, age)
FROM '/workdir/DataScience/Lab7/survey.csv'
DELIMITER ','
CSV HEADER;
```

     * postgresql://postgres@localhost:5432/datascience
    750 rows affected.





    []



Check rows - Alright :)


```python
%sql select * from survey limit 10;
```

     * postgresql://postgres@localhost:5432/datascience
    10 rows affected.





<table>
    <tr>
        <th>mydepv</th>
        <th>price</th>
        <th>income</th>
        <th>age</th>
    </tr>
    <tr>
        <td>1</td>
        <td>10</td>
        <td>33</td>
        <td>37</td>
    </tr>
    <tr>
        <td>0</td>
        <td>20</td>
        <td>21</td>
        <td>55</td>
    </tr>
    <tr>
        <td>1</td>
        <td>30</td>
        <td>59</td>
        <td>55</td>
    </tr>
    <tr>
        <td>1</td>
        <td>20</td>
        <td>76</td>
        <td>44</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>24</td>
        <td>37</td>
    </tr>
    <tr>
        <td>0</td>
        <td>20</td>
        <td>22</td>
        <td>32</td>
    </tr>
    <tr>
        <td>1</td>
        <td>10</td>
        <td>28</td>
        <td>32</td>
    </tr>
    <tr>
        <td>1</td>
        <td>10</td>
        <td>49</td>
        <td>38</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>76</td>
        <td>43</td>
    </tr>
    <tr>
        <td>1</td>
        <td>20</td>
        <td>59</td>
        <td>55</td>
    </tr>
</table>



## Modify data
Add columns `price20` and `price30`


```python
%%sql
alter table survey 
add column price20 integer;
```

     * postgresql://postgres@localhost:5432/datascience
    Done.





    []




```python
%%sql
alter table survey 
add column price30 integer;
```

     * postgresql://postgres@localhost:5432/datascience
    Done.





    []



Set them as 1 or 0 for prices = 10 or 20 or 30


```python
%%sql
update survey set price20=1 where price=20;
update survey set price20=0 where price!=20;
update survey set price30=1 where price=30;
update survey set price30=0 where price!=30;
```

     * postgresql://postgres@localhost:5432/datascience
    250 rows affected.
    500 rows affected.
    250 rows affected.
    500 rows affected.





    []



Check them


```python
%sql select * from survey limit 10;
```

     * postgresql://postgres@localhost:5432/datascience
    10 rows affected.





<table>
    <tr>
        <th>mydepv</th>
        <th>price</th>
        <th>income</th>
        <th>age</th>
        <th>price20</th>
        <th>price30</th>
    </tr>
    <tr>
        <td>1</td>
        <td>30</td>
        <td>59</td>
        <td>55</td>
        <td>0</td>
        <td>1</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>24</td>
        <td>37</td>
        <td>0</td>
        <td>1</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>76</td>
        <td>43</td>
        <td>0</td>
        <td>1</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>45</td>
        <td>32</td>
        <td>0</td>
        <td>1</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>21</td>
        <td>46</td>
        <td>0</td>
        <td>1</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>49</td>
        <td>44</td>
        <td>0</td>
        <td>1</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>31</td>
        <td>32</td>
        <td>0</td>
        <td>1</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>22</td>
        <td>32</td>
        <td>0</td>
        <td>1</td>
    </tr>
    <tr>
        <td>0</td>
        <td>30</td>
        <td>29</td>
        <td>32</td>
        <td>0</td>
        <td>1</td>
    </tr>
    <tr>
        <td>1</td>
        <td>30</td>
        <td>59</td>
        <td>55</td>
        <td>0</td>
        <td>1</td>
    </tr>
</table>



Create table with columns of dependent and independent


```python
%%sql
DROP TABLE IF EXISTS survey2;
CREATE TABLE survey2 (
    mydepv boolean,
    ind_values integer[]
);
```

     * postgresql://postgres@localhost:5432/datascience
    Done.
    Done.





    []



Insert values MYDEPV and array of others


```python
%%sql
insert into survey2(mydepv, ind_values)
select survey.mydepv::bool, 
ARRAY[1, 
      survey.income, 
      survey.age, 
      survey.price20, 
      survey.price30] as arr from survey;
```

     * postgresql://postgres@localhost:5432/datascience
    750 rows affected.





    []



Check them


```python
%sql select * from survey2 limit 10;
```

     * postgresql://postgres@localhost:5432/datascience
    10 rows affected.





<table>
    <tr>
        <th>mydepv</th>
        <th>ind_values</th>
    </tr>
    <tr>
        <td>True</td>
        <td>[1, 59, 55, 0, 1]</td>
    </tr>
    <tr>
        <td>False</td>
        <td>[1, 24, 37, 0, 1]</td>
    </tr>
    <tr>
        <td>False</td>
        <td>[1, 76, 43, 0, 1]</td>
    </tr>
    <tr>
        <td>False</td>
        <td>[1, 45, 32, 0, 1]</td>
    </tr>
    <tr>
        <td>False</td>
        <td>[1, 21, 46, 0, 1]</td>
    </tr>
    <tr>
        <td>False</td>
        <td>[1, 49, 44, 0, 1]</td>
    </tr>
    <tr>
        <td>False</td>
        <td>[1, 31, 32, 0, 1]</td>
    </tr>
    <tr>
        <td>False</td>
        <td>[1, 22, 32, 0, 1]</td>
    </tr>
    <tr>
        <td>False</td>
        <td>[1, 29, 32, 0, 1]</td>
    </tr>
    <tr>
        <td>True</td>
        <td>[1, 59, 55, 0, 1]</td>
    </tr>
</table>



## Create logistic regression with MADLib


```python
%%sql
DROP TABLE IF EXISTS survey_logregr, survey_logregr_summary;
SELECT madlib.logregr_train('survey2',
              'survey_logregr',
              'mydepv',
              'ind_values');
```

     * postgresql://postgres@localhost:5432/datascience
    Done.
    1 rows affected.





<table>
    <tr>
        <th>logregr_train</th>
    </tr>
    <tr>
        <td></td>
    </tr>
</table>



### Summary


```python
%%sql
SELECT unnest(array['intercept',
                    'income', 
                    'age', 
                    'price20', 
                    'price30']) as attribute,
       unnest(coef) as coefficient,
       unnest(std_err) as standard_error,
       unnest(z_stats) as z_stat,
       unnest(p_values) as pvalue,
       unnest(odds_ratios) as odds_ratio
    FROM survey_logregr;
```

     * postgresql://postgres@localhost:5432/datascience
    5 rows affected.





<table>
    <tr>
        <th>attribute</th>
        <th>coefficient</th>
        <th>standard_error</th>
        <th>z_stat</th>
        <th>pvalue</th>
        <th>odds_ratio</th>
    </tr>
    <tr>
        <td>intercept</td>
        <td>-6.02116057636787</td>
        <td>0.532440923644448</td>
        <td>-11.3085983983993</td>
        <td>1.18974837145447e-29</td>
        <td>0.00242685141358459</td>
    </tr>
    <tr>
        <td>income</td>
        <td>0.128759374924942</td>
        <td>0.00923035837106702</td>
        <td>13.9495531753723</td>
        <td>3.16582525170149e-44</td>
        <td>1.13741640032794</td>
    </tr>
    <tr>
        <td>age</td>
        <td>0.0350637796423411</td>
        <td>0.0117900836733219</td>
        <td>2.97400600486677</td>
        <td>0.00293939322817078</td>
        <td>1.03568576236067</td>
    </tr>
    <tr>
        <td>price20</td>
        <td>-0.744177494951807</td>
        <td>0.264387873296036</td>
        <td>-2.81471871487294</td>
        <td>0.00488199444444116</td>
        <td>0.475124931924531</td>
    </tr>
    <tr>
        <td>price30</td>
        <td>-2.21028046675832</td>
        <td>0.311075548871486</td>
        <td>-7.10528511410408</td>
        <td>1.20074395698392e-12</td>
        <td>0.109669885444447</td>
    </tr>
</table>



Create results table with odds_ratio and prediction


```python
%%sql
drop table if exists res_survey;
create table res_survey(mydepv integer, 
                        price integer, 
                        income integer, 
                        age integer,
                        price20 integer,
                        price30 integer,
                        odds_ratio real, 
                        prediction real);
```

     * postgresql://postgres@localhost:5432/datascience
    Done.
    Done.





    []



Put values to result table and count odds\_ratio as _coef1 + coef2\*param1 + coef3\*param2 + coef4\*param3 + coef5\*param4_


```python
%%sql
insert into res_survey
select s.mydepv,
        s.price, 
        s.income, 
        s.age, 
        s.price20, 
        s.price30,
        (coef[1] + coef[2] * s.income + 
        coef[3] * s.age + 
        coef[4] * s.price20 + 
        coef[5] * s.price30) as odds_ratio,
        0 as prediction
from survey_logregr, survey as s;
```

     * postgresql://postgres@localhost:5432/datascience
    750 rows affected.





    []



Count prediction as _exp(odds\_ratio) / (1 + exp(odds\_ratio))_


```python
%%sql
update res_survey set prediction = (exp(odds_ratio) / (1+exp(odds_ratio)));
```

     * postgresql://postgres@localhost:5432/datascience
    750 rows affected.





    []



Make predictions with coefs


```python
%%sql
select exp_odds_ratio / (1 + exp_odds_ratio) as prediction
from
(select  exp(coef[1] + coef[2] * 58 + 
        coef[3] * 25 + 
        coef[4] * 1 + 
        coef[5] * 0) as exp_odds_ratio
from survey_logregr) as tmp;
```

     * postgresql://postgres@localhost:5432/datascience
    1 rows affected.





<table>
    <tr>
        <th>prediction</th>
    </tr>
    <tr>
        <td>0.829105381494624</td>
    </tr>
</table>




```python
%%sql
select exp_odds_ratio / (1 + exp_odds_ratio) as prediction
from
(select  exp(coef[1] + coef[2] * 9.490 + 
        coef[3] * 51 + 
        coef[4] * 1 + 
        coef[5] * 0) as exp_odds_ratio
from survey_logregr) as tmp;
```

     * postgresql://postgres@localhost:5432/datascience
    1 rows affected.





<table>
    <tr>
        <th>prediction</th>
    </tr>
    <tr>
        <td>0.0228618415177979</td>
    </tr>
</table>



Count overall with \+ from predicted data


```python
%%sql
select sum(mydepv) as mydepv, sum(prediction)::integer as predicted from res_survey;
```

     * postgresql://postgres@localhost:5432/datascience
    1 rows affected.





<table>
    <tr>
        <th>mydepv</th>
        <th>predicted</th>
    </tr>
    <tr>
        <td>324</td>
        <td>324</td>
    </tr>
</table>


