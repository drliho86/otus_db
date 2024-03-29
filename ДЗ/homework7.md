Домашнее задание    
Посчитать кол-во очков по всем игрокам за текущий год и за предыдущий.    

Цель:    
Научиться использовать функцию LAG и CTE    


Описание/Пошаговая инструкция выполнения домашнего задания:    
Создайте таблицу и наполните ее данными    
CREATE TABLE statistic(    
player_name VARCHAR(100) NOT NULL,    
player_id INT NOT NULL,    
year_game SMALLINT NOT NULL CHECK (year_game > 0),    
points DECIMAL(12,2) CHECK (points >= 0),    
PRIMARY KEY (player_name,year_game)    
);    
заполнить данными    
INSERT INTO    
statistic(player_name, player_id, year_game, points)    
VALUES    
('Mike',1,2018,18),    
('Jack',2,2018,14),    
('Jackie',3,2018,30),    
('Jet',4,2018,30),    
('Luke',1,2019,16),    
('Mike',2,2019,14),    
('Jack',3,2019,15),    
('Jackie',4,2019,28),    
('Jet',5,2019,25),    
('Luke',1,2020,19),    
('Mike',2,2020,17),    
('Jack',3,2020,18),    
('Jackie',4,2020,29),    
('Jet',5,2020,27);    
написать запрос суммы очков с группировкой и сортировкой по годам    
написать cte показывающее тоже самое    
используя функцию LAG вывести кол-во очков по всем игрокам за текущий код и за предыдущий.    

-----------------------------------------------------------------------------------------------------------------------------------------------

+ CREATE TABLE statistic(    
player_name VARCHAR(100) NOT NULL,    
player_id INT NOT NULL,    
year_game SMALLINT NOT NULL CHECK (year_game > 0),    
points DECIMAL(12,2) CHECK (points >= 0),    
PRIMARY KEY (player_name,year_game)    
);  

+ INSERT INTO    
statistic(player_name, player_id, year_game, points)    
VALUES    
('Mike',1,2018,18),    
('Jack',2,2018,14),    
('Jackie',3,2018,30),    
('Jet',4,2018,30),    
('Luke',1,2019,16),    
('Mike',2,2019,14),    
('Jack',3,2019,15),    
('Jackie',4,2019,28),    
('Jet',5,2019,25),    
('Luke',1,2020,19),    
('Mike',2,2020,17),    
('Jack',3,2020,18),    
('Jackie',4,2020,29),    
('Jet',5,2020,27); 

+ select 	    
	year_game     
	,sum(points) points_sum    
from statistic    
group by    
	year_game     
order by    
	year_game;    
  
  ![image](https://user-images.githubusercontent.com/60733068/232181474-5b4beeaf-b549-44a5-81fc-15751f74f96b.png)

+ with cte as (     
select      
	year_game      
	,sum(points) points_sum     
from statistic     
group by     
	year_game      

)     
select *      
	from cte      
	order by     
year_game       
  
  ![image](https://user-images.githubusercontent.com/60733068/232181532-6947243b-82a4-4c6a-97e1-119ffd8abefd.png)

+ select    
	player_name    
	,year_game,points    
	,lag(points) over (partition by player_name order by year_game) as "LY points"    
from statistic;      
  
  ![image](https://user-images.githubusercontent.com/60733068/232181626-ed005cdf-c64b-42c1-8535-456951dd1397.png)
