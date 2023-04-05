Домашнее задание   
DML в PostgreSQL   

Цель:   
Написать запрос с конструкциями SELECT, JOIN   
Написать запрос с добавлением данных INSERT INTO   
Написать запрос с обновлением данных с UPDATE FROM   
Использовать using для оператора DELETE   


Описание/Пошаговая инструкция выполнения домашнего задания:   
Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.   
Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на результат? Почему?   
Напишите запрос на добавление данных с выводом информации о добавленных строках.   
Напишите запрос с обновлением данные используя UPDATE FROM.   
Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.   
Задание со *:   
Приведите пример использования утилиты COPY   

----------------------------------------------------------------------------------------------

![image](https://user-images.githubusercontent.com/60733068/230026309-1263ac66-bc53-4a16-8777-b91dcfcaa190.png)


1) хочу узнать в каких категориях фильмах снимают актеров наиболее часто
select c."name" as category ,a.first_name || ' ' || a.last_name as actor , count(f.film_id) count_films from film f    
left join film_actor fa using(film_id)     
left join actor a using(actor_id)    
left join film_category fc using(film_id)     
left join category c using(category_id)    
group by     
c."name",a.first_name || ' ' || a.last_name    
order by     
c."name",count(f.film_id) desc,a.first_name || ' ' || a.last_name    

![image](https://user-images.githubusercontent.com/60733068/230027705-1ee62be0-db7c-4d80-959d-4ea4e2f556bc.png)


2) использую join     - порядок влияет так что inner join обрезает данные и может ускорить процесс выборки

select c."name" as category ,a.first_name || ' ' || a.last_name as actor , count(f.film_id) count_films      
from film f      
 join film_actor fa on fa.film_id =f.film_id     
 left join actor a on a.actor_id=fa.actor_id      
 join film_category fc on fc.film_id =f.film_id     
 left join category c on c.category_id=fc.category_id      
group by      
c."name",a.first_name || ' ' || a.last_name     
order by    
c."name",count(f.film_id) desc,a.first_name || ' ' || a.last_name   

![image](https://user-images.githubusercontent.com/60733068/230027751-1e9e2c7a-e918-40ad-857c-f9fc33217741.png)


3)Insert    
select * into fa from film_actor;   

insert into fa(actor_id,film_id,last_update)    
values(1,1,now())   
RETURNING *;    

![image](https://user-images.githubusercontent.com/60733068/230027590-72898795-ab6a-4419-bb97-046fce017c76.png)

4)Update    

update fa     
set actor_id =999   
,last_update=now()    
where     
fa.last_update=(select max(fa.last_update) from fa)     
RETURNING *;        

![image](https://user-images.githubusercontent.com/60733068/230034347-e3dbe040-2f25-425d-83d2-688152cf1995.png)


5)Delete        

delete  from fa     
using (select fa.film_id,fa.actor_id from fa left join film_actor f using(film_id,actor_id) where f.film_id is null) f    
where     
(fa.film_id = f.film_id   
and fa.actor_id= f.actor_id )   
RETURNING fa.*;     

![image](https://user-images.githubusercontent.com/60733068/230033769-856878ac-7fa8-4b70-aa27-012072b6af6c.png)

