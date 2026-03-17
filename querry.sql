---1) Выбрать все данные об игроках.
SELECT *
FROM Players
ORDER BY player_id

---2) Выбрать имена игроков без повторений.
SELECT DISTINCT "name"
FROM Players

---3) Выбрать данные об игроках старше 30 лет. Результат отсортировать по фамилии в лексикографическом порядке. 
SELECT *
FROM Players
WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE,date_of_birth)) > 30
ORDER BY surname

---4) Выбрать фамилию, имя, отчество, дату рождения игрока. В результат должны войти игроки с фамилией, начинающейся на 
---«К» или «М» и состоящей из 4 букв. Результат отсортировать по убыванию возраста и по фамилии, имени, отчеству в порядке об
---ратом лексикографическому. 
SELECT surname,"name",patronymic,date_of_birth
FROM Players
WHERE surname LIKE 'K___' OR surname LIKE 'M___'
ORDER BY date_of_birth ASC, surname, "name", patronymic DESC

---5) Выбрать спонсоров, в названии которых есть символы «?», «_», «*», «&» и нет символов «%» и «?».
SELECT sponsor_name
FROM Sponsors
WHERE (sponsor_name LIKE '%&%' 
OR sponsor_name LIKE '%!_%' ESCAPE '!' 
OR sponsor_name LIKE '%*%' 
OR sponsor_name LIKE '%?%') 
AND sponsor_name NOT LIKE '%!%' 
AND sponsor_name NOT LIKE '%!%%' ESCAPE '!'

---6) Выбрать фамилии, имена, отчества игроков в возрасте от 18 до 21 года. 
SELECT surname, name, patronymic
FROM Players
WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE,date_of_birth)) BETWEEN 18 AND 21 

---7) Выбрать все данные о тренерах с id = 1, 3, 4, 7, 10.
SELECT *
FROM Trainers
WHERE trainer_id IN (1,3,4,7,10)

---8) Выбрать id тренера, у которого не указан телефон.
SELECT trainer_id AS trainer_without_phone_number
FROM Trainers
WHERE phone_number LIKE ''

---9) Выбрать максимальный возраст тренера. 
SELECT MAX(EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)))
FROM Trainers

---10) Выбрать минимальный и средний сроки заключения контрактов за некоторый срок. 
SELECT MIN(EXTRACT(YEAR FROM end_date) - EXTRACT(YEAR FROM start_date)) AS min_term_of_contract, 
AVG(EXTRACT(YEAR FROM end_date) - EXTRACT(YEAR FROM start_date)) AS middle_term_of_contract
FROM Contracts
WHERE EXTRACT(YEAR FROM start_date) BETWEEN 2000 AND 2010

---11) Выбрать фамилию, имя, отчество игрока, дату рождения, пол, национальность. Результат отсортировать 
---по национальности в лексикографическом порядке, возрасту в убывающем порядке, 
---фамилии в порядке обратном лексикографическому и имени отчеству в лексикографическом порядке.  
SELECT surname,"name",patronymic, date_of_birth, Nationalities.nationality_name
FROM Players
	JOIN Nationalities ON Players.nationality_id = Nationalities.nationality_id
ORDER BY Nationalities.nationality_name, date_of_birth, surname DESC, "name", patronymic

--12)Выбрать фамилию и инициалы игроков, национальность, дату принятия состава, фамилию и имя (в одном столбце) тренера, 
--фамилию руководителя, дату начала и окончания контракта, название спонсора.
SELECT CONCAT(P."name",' ',SUBSTRING(P.surname, 1,1),' ',SUBSTRING(P.patronymic, 1,1)) AS full_name, 
nationality_name,approval_date, T.surname  || ' ' || T."name" AS trainer, A.surname, C.start_date, C.end_date, sponsor_name
FROM Players P
	JOIN Nationalities N ON P.nationality_id = N.nationality_id
	JOIN Contracts C ON P.player_id = C.player_id
	JOIN SponsorPayments SP USING (contract_id)
	JOIN Sponsors S USING (sponsor_id)
	JOIN ApprovalOfCoachingStaff ACS ON ACS.approval_date BETWEEN C.start_date AND C.end_date
	JOIN CoachingStaff CS USING (coaching_staff_id)
	JOIN Trainers T USING (trainer_id)
	JOIN Administration A USING (head_id)

--13) Выбрать общую сумму, которую вложил спонсор с каким-то конкретным названием (конкретное значение подставьте сами). 
SELECT 'Apple', SUM(payment)
FROM SponsorPayments
	JOIN Sponsors S ON S.sponsor_id = SponsorPayments.sponsor_id 
WHERE S.sponsor_name LIKE 'Apple'

--14) Выбрать фамилию, имя, отчество руководителя и общее количество утвержденных тренеров. Результат отсортировать по 
--количеству. 
SELECT surname, "name", patronymic, COUNT(approval_date)
FROM Administration D
	JOIN ApprovalOfCoachingStaff A ON D.head_id = A.head_id
GROUP BY D.head_id, surname, "name", patronymic
ORDER BY COUNT(approval_date)

--15) Выбрать среднюю стоимость российских игроков.
SELECT 'russian' AS player_nationality, AVG(salary)
FROM Players P
	JOIN Nationalities N ON P.nationality_id = N.nationality_id
WHERE N.nationality_name = 'russian'

--16) Для каждого игрока выбрать количество контрактов. 
SELECT surname, "name", patronymic, COUNT(contract_id) AS count_of_contracts
FROM Players P
	JOIN Contracts C ON P.player_id = C.player_id
GROUP BY P.player_id, surname, "name", patronymic

--17) Выбрать все данные об игроках, с которыми заключен только один контракт.
SELECT P.player_id, surname, "name", patronymic, date_of_birth, passport_series, passport_number, division_number, date_of_issue, 
issued_by_whom, team_number, height, weight, phone_number, salary, nationality_id, position_id, 
COUNT(contract_id) AS count_of_contracts
FROM Players P
	JOIN Contracts C ON P.player_id = C.player_id
GROUP BY P.player_id, surname, "name", patronymic, date_of_birth, passport_series, passport_number, division_number, date_of_issue, 
issued_by_whom, team_number, height, weight, phone_number, salary, nationality_id, position_id
HAVING COUNT(contract_id) = 1

--18) Выбрать спонсоров, потративших на игроков более 1000 000 и заключивших контракт как минимум с 3 игроками.
SELECT sponsor_name
FROM SponsorPayments SP
	JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
	JOIN Contracts C ON C.contract_id = SP.contract_id
GROUP BY sponsor_name
HAVING SUM(payment) > 1000000 AND COUNT(DISTINCT C.player_id) >= 3

--19) Выбрать для каждого игрока дату начала последнего заключенного контракта. 
SELECT P.player_id, MAX(start_date) AS begining_of_last_contract
FROM PLayers P
	JOIN Contracts C ON C.player_id = P.player_id 
GROUP BY P.player_id

--20) Выбрать названия спонсоров, которые спонсируют только одного игрока. 
SELECT sponsor_name
FROM SponsorPayments SP
	JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
	JOIN Contracts C ON C.contract_id = SP.contract_id
GROUP BY sponsor_name
HAVING COUNT(DISTINCT C.player_id) = 1

--21) Вывести в первом столбце фамилии, имена, отчества тренеров, во втором – название биологического возраста по клас
--сификации Всемирной организации здравоохранения (от 25 до 44 лет – молодой возраст, 44–60 лет – средний возраст, 60
--75 лет – пожилой возраст, 75–90 лет – старческий возраст, после 90 – долгожители.).
SELECT CONCAT(surname, ' ', "name", ' ', patronymic) AS full_name, CASE
	WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) BETWEEN 25 AND 44 THEN 'молодой возраст'
	WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) BETWEEN 44 AND 60 THEN 'средний возраст'
	WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) BETWEEN 60 AND 75 THEN 'пожилой возраст'
	WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) BETWEEN 75 AND 90 THEN 'старческий возраст'
	WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) > 90 THEN 'долгожитель'
	END AS classification
FROM Trainers

--22) Для каждого состава (выбрать id, дату принятия) вывести в разных столбцах количество игроков до 23 лет, 
--количество игроков от 24 до 28 лет и количество игроков старше 28, а также вывести средний возраст игроков.
SELECT coaching_staff_id, approval_date, 
	COUNT(CASE WHEN EXTRACT(YEAR FROM AGE(approval_date, date_of_birth)) <= 23 THEN 1 ELSE 0 END), 
	COUNT(CASE WHEN EXTRACT(YEAR FROM AGE(approval_date, date_of_birth)) BETWEEN 24 AND 28 THEN 1 ELSE 0 END),
	COUNT(CASE WHEN EXTRACT(YEAR FROM AGE(approval_date, date_of_birth)) > 28 THEN 1 ELSE 0 END), 
	AVG(EXTRACT(YEAR FROM AGE(approval_date, date_of_birth)))
FROM ApprovalOfCoachingStaff A
	JOIN Contracts C ON A.approval_date BETWEEN C.start_date AND C.end_date
	JOIN Players P ON P.player_id = C.player_id
GROUP BY coaching_staff_id , approval_date

--23) Выбрать фамилии и национальность игроков, имеющих более трех контрактов и тренирующихся у Wayne Gretzky Douglas.
SELECT DISTINCT P.surname, N.nationality_name
FROM PLayers P
	JOIN Nationalities N ON P.nationality_id = N.nationality_id
	JOIN Contracts C ON P.player_id = C.player_id
	JOIN TrainerContracts TC ON C.end_date BETWEEN TC.start_date AND TC.end_date OR 
								TC.end_date BETWEEN C.start_date AND C.end_date
	JOIN Trainers T ON TC.trainer_id = T.trainer_id
WHERE T."name" LIKE 'Wayne' AND T.surname LIKE 'Gretzky' AND T.patronymic LIKE 'Douglas'

--24) Выбрать id и фамилии, имена, отчества игроков, у которых срок завершения контракта истек в прошлом месяце. 
SELECT P.player_id, surname, "name", patronymic
FROM Players P
	JOIN Contracts C ON P.player_id = C.player_id
WHERE DATE_TRUNC('month', end_date) = DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'

--25) Для каждого года заключения контрактов вывести количество контрактов, заключенных с российскими игроками.
--В результат должны войти только года, в которые заключено более 2 контрактов.
SELECT start_date, COUNT(P.player_id)
FROM Players P
	JOIN Nationalities N ON P.nationality_id = N.nationality_id
	JOIN Contracts C ON P.player_id = C.player_id
WHERE nationality_name LIKE 'russian'
GROUP BY start_date
HAVING COUNT(contract_id) > 2

--26) Выбрать название спонсоров, которые заключают договора как минимум на три года.
SELECT sponsor_name
FROM SponsorPayments SP
	JOIN Contracts C ON C.contract_id = SP.contract_id
	JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
GROUP BY sponsor_name, S.sponsor_id
HAVING MIN(EXTRACT(YEAR FROM end_date) - EXTRACT(YEAR FROM start_date)) >= 3

--27) Выбрать все данные о самом старшем тренере.
SELECT *
FROM Trainers
WHERE date_of_birth = (SELECT MIN(date_of_birth) FROM Trainers)

--28) Выбрать id и название спонсора, который оплачивает только одного русского игрока. 
SELECT S.sponsor_id, S.sponsor_name
FROM Players P
	JOIN Nationalities N ON P.nationality_id = N.nationality_id
	JOIN Contracts C ON P.player_id = C.player_id
	JOIN SponsorPayments SP ON C.contract_id = SP.contract_id
	JOIN Sponsors S ON SP.sponsor_id = S.sponsor_id
WHERE N.nationality_name LIKE 'russian'
GROUP BY S.sponsor_id, S.sponsor_name
HAVING COUNT(DISTINCT P.player_id) = 1

--!29) Выбрать данные состава, который имеет наибольшее количество забитых голов. 
SELECT coaching_staff_id, head_id, approval_date
FROM ApprovalOfCoachingStaff
WHERE coaching_staff_id IN (SELECT A.coaching_staff_id
							FROM ApprovalOfCoachingStaff A
								JOIN Matches M ON A.coaching_staff_id = M.coaching_staff_id
							GROUP BY A.coaching_staff_id
							HAVING SUM(scored_goals) = (SELECT MAX(count_goals)
														FROM (SELECT SUM(scored_goals) AS count_goals
															  FROM ApprovalOfCoachingStaff A
																  JOIN Matches M ON A.coaching_staff_id = M.coaching_staff_id
															  GROUP BY A.coaching_staff_id)))

SELECT coaching_staff_id, head_id, approval_date
FROM ApprovalOfCoachingStaff
WHERE coaching_staff_id IN (SELECT A.coaching_staff_id
							FROM ApprovalOfCoachingStaff A
								JOIN Matches M ON A.coaching_staff_id = M.coaching_staff_id
							GROUP BY A.coaching_staff_id
							HAVING SUM(scored_goals) >= ALL (SELECT SUM(scored_goals)
															 FROM ApprovalOfCoachingStaff A
																JOIN Matches M ON A.coaching_staff_id = M.coaching_staff_id
															 GROUP BY A.coaching_staff_id))

--30) Выбрать фамилию и инициалы тренеров, которые в составе, имеющем более 1 тренера. 
SELECT CONCAT(surname, ' ', SUBSTRING("name", 1, 1), ' ', SUBSTRING(patronymic, 1, 1)) AS full_name
FROM Trainers T
JOIN CoachingStaff C ON T.trainer_id = C.trainer_id
WHERE coaching_staff_id IN (SELECT coaching_staff_id
							FROM Trainers T
							JOIN CoachingStaff C ON T.trainer_id = C.trainer_id
							GROUP BY coaching_staff_id
							HAVING COUNT(T.trainer_id) > 1)

--31) Выбрать название спонсора, который заключил договоры с наибольшим количеством игроков из Германии.
SELECT sponsor_name
FROM SponsorPayments SP
	JOIN Contracts C ON C.contract_id = SP.contract_id
	JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
	JOIN Players P ON P.player_id = C.player_id
	JOIN Nationalities N ON N.nationality_id = P.nationality_id
WHERE N.nationality_name LIKE 'german'
GROUP BY sponsor_name, S.sponsor_id
HAVING COUNT(DISTINCT P.player_id) = (SELECT MAX(count_players)
									  FROM	(SELECT S.sponsor_id, S.sponsor_name, COUNT(DISTINCT P.player_id) AS count_players
											FROM SponsorPayments SP
												JOIN Contracts C ON C.contract_id = SP.contract_id
												JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
												JOIN Players P ON P.player_id = C.player_id
												JOIN Nationalities N ON N.nationality_id = P.nationality_id
											WHERE N.nationality_name LIKE 'german'
											GROUP BY sponsor_name, S.sponsor_id))

SELECT sponsor_name
FROM SponsorPayments SP
	JOIN Contracts C ON C.contract_id = SP.contract_id
	JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
	JOIN Players P ON P.player_id = C.player_id
	JOIN Nationalities N ON N.nationality_id = P.nationality_id
WHERE N.nationality_name LIKE 'german'
GROUP BY sponsor_name, S.sponsor_id
HAVING COUNT(DISTINCT P.player_id) >= ALL (SELECT COUNT(DISTINCT P.player_id)
											FROM SponsorPayments SP
												JOIN Contracts C ON C.contract_id = SP.contract_id
												JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
												JOIN Players P ON P.player_id = C.player_id
												JOIN Nationalities N ON N.nationality_id = P.nationality_id
											WHERE N.nationality_name LIKE 'german'
											GROUP BY S.sponsor_id)

--32) Выбрать спонсора, у которого наибольшее количество договоров с одним и тем же игроком.
SELECT S.sponsor_name
FROM SponsorPayments SP
	JOIN Contracts C ON C.contract_id = SP.contract_id
	JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
GROUP BY S.sponsor_id, C.player_id, S.sponsor_name
HAVING COUNT(C.contract_id) = (SELECT MAX(count_contracts)
							   FROM	(SELECT COUNT(C.contract_id) AS count_contracts
									 FROM SponsorPayments SP
										JOIN Contracts C ON C.contract_id = SP.contract_id
										JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
									 GROUP BY S.sponsor_id, C.player_id))
									 
								

SELECT S.sponsor_name
FROM SponsorPayments SP
	JOIN Contracts C ON C.contract_id = SP.contract_id
	JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
GROUP BY S.sponsor_id, C.player_id, S.sponsor_name
HAVING COUNT(C.contract_id) >= ALL (SELECT COUNT(C.contract_id) AS count_contracts_for_player
									 FROM SponsorPayments SP
										JOIN Contracts C ON C.contract_id = SP.contract_id
										JOIN Sponsors S ON S.sponsor_id = SP.sponsor_id
									 GROUP BY S.sponsor_id, C.player_id)

--33) Выбрать фамилии и инициалы руководителей, в чьем составе есть или были игроки, дата завершения контракта с которыми истекает 
--в текущем месяце.
SELECT CONCAT(A."name",' ',SUBSTRING(A.surname, 1,1),' ',SUBSTRING(A.patronymic, 1,1)) AS full_name
FROM Administration A
	JOIN ApprovalOfCoachingStaff ACS ON ACS.head_id = A.head_id
	JOIN Contracts C ON ACS.approval_date BETWEEN C.start_date AND C.end_date
WHERE DATE_TRUNC('month', C.end_date) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY A.head_id

--34) Выбрать тройку игроков, с которыми заключены последние контракты.
EXPLAIN ANALYZE
SELECT CONCAT(P1."name",' ',SUBSTRING(P1.surname, 1,1),' ',SUBSTRING(P1.patronymic, 1,1)) AS first_player, 
	   CONCAT(P2."name",' ',SUBSTRING(P2.surname, 1,1),' ',SUBSTRING(P2.patronymic, 1,1)) AS second_player, 
	   CONCAT(P3."name",' ',SUBSTRING(P3.surname, 1,1),' ',SUBSTRING(P3.patronymic, 1,1)) AS third_player
FROM Contracts C1
	CROSS JOIN Contracts C2 
	CROSS JOIN Contracts C3
	JOIN Players P1 ON P1.player_id = C1.player_id
	JOIN Players P2 ON P2.player_id = C2.player_id
	JOIN Players P3 ON P3.player_id = C3.player_id
WHERE C1.player_id < C2.player_id AND
	  C2.player_id < C3.player_id AND
     EXTRACT(EPOCH FROM C1.start_date) +
	 EXTRACT(EPOCH FROM C2.start_date) +
	 EXTRACT(EPOCH FROM C3.start_date) >= ALL (SELECT EXTRACT(EPOCH FROM C1.start_date) +
													   EXTRACT(EPOCH FROM C2.start_date) +
													   EXTRACT(EPOCH FROM C3.start_date) AS sum_start_date
												 FROM Contracts C1
													CROSS JOIN Contracts C2 
													CROSS JOIN Contracts C3
												 WHERE C1.player_id < C2.player_id AND
													  C2.player_id < C3.player_id)

EXPLAIN ANALYZE
SELECT CONCAT("name",' ',SUBSTRING(surname, 1,1),' ',SUBSTRING(patronymic, 1,1)) AS players_with_last_contracts
FROM (SELECT P."name", P.surname, P.patronymic, MAX(C.start_date) AS start_date
      FROM Contracts C
	      JOIN Players P USING (player_id)
      GROUP BY P.player_id, P."name", P.surname, P.patronymic)
ORDER BY start_date DESC
LIMIT 3

--35) Выбрать названия спонсоров, которые не заключали контракты последние 8 месяцев.
SELECT S.sponsor_name
FROM SPonsors S
WHERE NOT EXISTS (SELECT 1
                   FROM Contracts C
				   		JOIN SponsorPayments SP USING (contract_id)
				   WHERE SP.sponsor_id = S.sponsor_id AND
				         EXTRACT(YEAR FROM AGE(C.start_date)) = 0 AND
				         EXTRACT(MONTH FROM AGE(C.start_date)) < 8)

--36) Выбрать данные обо всех игроках и для тех, у кого истекает контракт в этом году, в отдельном столбце указать сообщение 
--«продлить контракт». 
SELECT P.*, CASE 
				WHEN EXTRACT(YEAR FROM C.end_date) = EXTRACT(YEAR FROM CURRENT_DATE) THEN 'продлить контракт' 
				ELSE '' 
			END AS recomendation
FROM Players P
	JOIN Contracts C USING (player_id)
WHERE C.end_date >= CURRENT_DATE

--37) Выбрать для каждого игрока прибыль по контракту актуальному на 12 апреля 2019 года. 
SELECT player_id, payment
FROM SponsorPayments SP
	JOIN Contracts C USING (contract_id)
WHERE '2019-04-12' BETWEEN C.start_date AND C.end_date

--38) Выбрать однофамильцев-тезок среди тренеров и игроков.
SELECT DISTINCT P1.player_id, P1."name", P1.surname, P1.patronymic
FROM Players P1
	     LEFT JOIN Trainers T ON T."name" LIKE P1."name" AND
	                        T.surname LIKE P1.surname
	     LEFT JOIN Players P2 ON P1."name" LIKE P2."name" AND
	                        P1.surname LIKE P2.surname AND
						    P1.player_id != P2.player_id
WHERE T.surname IS NOT NULL OR
      P2.surname IS NOT NULL
UNION ALL
SELECT DISTINCT T1.trainer_id, T1."name", T1.surname, T1.patronymic
FROM Trainers T1
	     LEFT JOIN Players P ON T1."name" LIKE P."name" AND
	                        T1.surname LIKE P.surname
	     LEFT JOIN Trainers T2 ON T1."name" LIKE T2."name" AND
	                        T1.surname LIKE T2.surname AND
						    T1.trainer_id != T2.trainer_id
WHERE T2.surname IS NOT NULL OR
      P.surname IS NOT NULL


SELECT P1."name",P1.surname, P1.patronymic
FROM Players P1
WHERE EXISTS (SELECT 1
              FROM Players P2
			  WHERE P1.surname LIKE P2.surname AND
			        P1."name" LIKE P2."name" AND
			        P1.player_id != P2.player_id)
	  OR
	  EXISTS  (SELECT 1
              FROM Trainers T
			  WHERE P1.surname LIKE T.surname AND
			        P1."name" LIKE T."name")
UNION ALL 
SELECT T1."name", T1.surname, T1.patronymic
FROM Trainers T1
WHERE EXISTS (SELECT 1
              FROM Trainers T2
			  WHERE T1.surname LIKE T2.surname AND
			        T1."name" LIKE T2."name" AND
			        T1.trainer_id != T2.trainer_id)
	  OR
	  EXISTS  (SELECT 1
              FROM Players P
			  WHERE T1.surname LIKE P.surname AND
			        P."name" LIKE T1."name")

--39) Выбрать всех однофамильцев по всей базе данных.
EXPLAIN ANALYZE
SELECT P1."name",P1.surname, P1.patronymic
FROM Players P1
WHERE EXISTS (SELECT 1
              FROM Players P2
			  WHERE P1.surname LIKE P2.surname AND
			        P1.player_id != P2.player_id)
	  OR
	  EXISTS  (SELECT 1
              FROM Trainers T
			  WHERE P1.surname LIKE T.surname)
	  OR
	  EXISTS  (SELECT 1
              FROM Administration A
			  WHERE P1.surname LIKE A.surname)
UNION ALL 
SELECT T1."name", T1.surname, T1.patronymic
FROM Trainers T1
WHERE EXISTS (SELECT 1
              FROM Trainers T2
			  WHERE T1.surname LIKE T2.surname AND
			        T1.trainer_id != T2.trainer_id)
	  OR
	  EXISTS  (SELECT 1
              FROM Players P
			  WHERE T1.surname LIKE P.surname)
	  OR
	  EXISTS  (SELECT 1
              FROM Administration A
			  WHERE T1.surname LIKE A.surname)
UNION ALL
SELECT A1."name", A1.surname, A1.patronymic
FROM Administration A1
WHERE EXISTS (SELECT 1
              FROM Administration A2
			  WHERE A1.surname LIKE A2.surname AND
			        A1.head_id != A2.head_id)
	  OR
	  EXISTS  (SELECT 1
              FROM Trainers T
			  WHERE A1.surname LIKE T.surname)
	  OR
	  EXISTS  (SELECT 1
              FROM Players P
			  WHERE A1.surname LIKE P.surname)

			  
EXPLAIN ANALYZE
WITH AllPeople ("name", surname, patronymic)
AS
(SELECT P."name",P.surname, P.patronymic
FROM Players P
UNION ALL 
SELECT T."name", T.surname, T.patronymic
FROM Trainers T
UNION ALL
SELECT A."name", A.surname, A.patronymic
FROM Administration A)

SELECT *
FROM AllPeople
WHERE surname IN (SELECT surname
                  FROM AllPeople
                  GROUP BY surname
                  HAVING COUNT(*) > 1)


EXPLAIN ANALYZE
SELECT DISTINCT P1.player_id, P1."name", P1.surname, P1.patronymic
FROM Players P1
	     LEFT JOIN Trainers T ON T.surname LIKE P1.surname
	     LEFT JOIN Players P2 ON P1.surname LIKE P2.surname AND
						    P1.player_id != P2.player_id
		 LEFT JOIN Administration A ON A.surname LIKE P1.surname
WHERE T.surname IS NOT NULL OR
      P2.surname IS NOT NULL OR
	  A.surname IS NOT NULL
UNION ALL
SELECT DISTINCT T1.trainer_id, T1."name", T1.surname, T1.patronymic
FROM Trainers T1
	     LEFT JOIN Players P ON T1.surname LIKE P.surname
	     LEFT JOIN Trainers T2 ON T1.surname LIKE T2.surname AND
						    T1.trainer_id != T2.trainer_id
         LEFT JOIN Administration A ON A.surname LIKE T1.surname
WHERE T2.surname IS NOT NULL OR
      P.surname IS NOT NULL OR
	  A.surname IS NOT NULL
UNION ALL
SELECT DISTINCT A1.head_id, A1."name", A1.surname, A1.patronymic
FROM Administration A1
	     LEFT JOIN Players P ON A1.surname LIKE P.surname
		 LEFT JOIN Administration A2 ON A1.surname LIKE A2.surname AND
						                A1.head_id != A2.head_id
	     LEFT JOIN Trainers T ON A1.surname LIKE T.surname
WHERE T.surname IS NOT NULL OR
      P.surname IS NOT NULL OR
	  A2.surname IS NOT NULL

--40) Выбрать общее количество однофамильцев по всей БД. 
WITH AllPeople ("name", surname, patronymic)
AS
(SELECT P."name",P.surname, P.patronymic
FROM Players P
UNION ALL 
SELECT T."name", T.surname, T.patronymic
FROM Trainers T
UNION ALL
SELECT A."name", A.surname, A.patronymic
FROM Administration A)

SELECT COUNT(*) AS people_with_same_surname
FROM AllPeople
WHERE surname IN (SELECT surname
                  FROM AllPeople
                  GROUP BY surname
                  HAVING COUNT(*) > 1)


WITH AllPeople (surname, gs)
AS
(SELECT surname, ROW_NUMBER() OVER ()
 FROM  (SELECT P.surname
		FROM Players P
		UNION ALL 
		SELECT T.surname
		FROM Trainers T
		UNION ALL
		SELECT A.surname
		FROM Administration A))

SELECT COUNT(*) AS people_with_same_surname
FROM AllPeople ALL1
WHERE EXISTS (SELECT 1
			  FROM AllPeople ALL2
			  WHERE ALL1.surname LIKE ALL2.surname AND
			        ALL1.gs != ALL2.gs)


SELECT COUNT(*) AS people_with_same_surname
FROM (SELECT P1.surname
	FROM Players P1
	WHERE EXISTS (SELECT 1
	              FROM Players P2
				  WHERE P1.surname LIKE P2.surname AND
				        P1.player_id != P2.player_id)
		  OR
		  EXISTS  (SELECT 1
	              FROM Trainers T
				  WHERE P1.surname LIKE T.surname)
		  OR
		  EXISTS  (SELECT 1
	              FROM Administration A
				  WHERE P1.surname LIKE A.surname)
	UNION ALL 
	SELECT T1.surname
	FROM Trainers T1
	WHERE EXISTS (SELECT 1
	              FROM Trainers T2
				  WHERE T1.surname LIKE T2.surname AND
				        T1.trainer_id != T2.trainer_id)
		  OR
		  EXISTS  (SELECT 1
	              FROM Players P
				  WHERE T1.surname LIKE P.surname)
		  OR
		  EXISTS  (SELECT 1
	              FROM Administration A
				  WHERE T1.surname LIKE A.surname)
	UNION ALL
	SELECT A1.surname
	FROM Administration A1
	WHERE EXISTS (SELECT 1
	              FROM Administration A2
				  WHERE A1.surname LIKE A2.surname AND
				        A1.head_id != A2.head_id)
		  OR
		  EXISTS  (SELECT 1
	              FROM Trainers T
				  WHERE A1.surname LIKE T.surname)
		  OR
		  EXISTS  (SELECT 1
	              FROM Players P
				  WHERE A1.surname LIKE P.surname))


SELECT COUNT(*) AS people_with_same_surname
FROM (SELECT DISTINCT P1.player_id
	 FROM Players P1
		     LEFT JOIN Trainers T ON T.surname LIKE P1.surname
		     LEFT JOIN Players P2 ON P1.surname LIKE P2.surname AND
							    P1.player_id != P2.player_id
			 LEFT JOIN Administration A ON A.surname LIKE P1.surname
	WHERE T.surname IS NOT NULL OR
	      P2.surname IS NOT NULL OR
		  A.surname IS NOT NULL
	UNION ALL
	SELECT DISTINCT T1.trainer_id
	FROM Trainers T1
		     LEFT JOIN Players P ON T1.surname LIKE P.surname
		     LEFT JOIN Trainers T2 ON T1.surname LIKE T2.surname AND
							    T1.trainer_id != T2.trainer_id
	         LEFT JOIN Administration A ON A.surname LIKE T1.surname
	WHERE T2.surname IS NOT NULL OR
	      P.surname IS NOT NULL OR
		  A.surname IS NOT NULL
	UNION ALL
	SELECT DISTINCT A1.head_id
	FROM Administration A1
		     LEFT JOIN Players P ON A1.surname LIKE P.surname
			 LEFT JOIN Administration A2 ON A1.surname LIKE A2.surname AND
							                A1.head_id != A2.head_id
		     LEFT JOIN Trainers T ON A1.surname LIKE T.surname
	WHERE T.surname IS NOT NULL OR
	      P.surname IS NOT NULL OR
		  A2.surname IS NOT NULL)

--41)  Выбрать id и фамилии, имена, отчества тренеров, которые тренировали 2 и более состава, у которых 
--не было пропущенных шайб.

SELECT T.trainer_id, T.surname, T."name", T.patronymic
FROM Trainers T
	JOIN CoachingStaff CS ON T.trainer_id = CS.trainer_id
	JOIN ApprovalOfCoachingStaff ACS ON ACS.coaching_staff_id = CS.coaching_staff_id
	JOIN Matches M ON M.coaching_staff_id = ACS.coaching_staff_id
GROUP BY T.trainer_id, T.surname, T."name", T.patronymic
HAVING COUNT(DISTINCT CS.coaching_staff_id) >= 2 AND SUM(M.passed_goals) = 0

SELECT T.trainer_id, T.surname, T."name", T.patronymic
FROM Trainers T
WHERE 2 <= (SELECT COUNT(*)
            FROM CoachingStaff CS
		    WHERE T.trainer_id = CS.trainer_id)
			AND
			NOT EXISTS (SELECT 1
			            FROM Matches M
							JOIN ApprovalOfCoachingStaff ACS ON ACS.coaching_staff_id = M.coaching_staff_id
							JOIN CoachingStaff CS ON ACS.coaching_staff_id = CS.coaching_staff_id
						WHERE T.trainer_id = CS.trainer_id AND
						      M.coaching_staff_id = ACS.coaching_staff_id AND
						      M.passed_goals != 0)

--42)  Выбрать в одном столбце названия спонсоров и фамилии и инициалы руководителей. Результат отсортировать 
--в лексикографическом порядке.


SELECT sponsor_name
FROM Sponsors
UNION ALL
SELECT CONCAT(surname, ' ', "name", ' ', patronymic)
FROM Administration
ORDER BY 1

--43) Вывести сообщение «Есть игроки с просроченным контрактом», если есть игроки, у которых 
--действие контракта закончилось и новый контракт не заключен.
EXPLAIN ANALYSE
SELECT CASE 
			WHEN EXISTS (SELECT 1 
			             FROM (SELECT MAX(C.end_date) AS last_date
                               FROM Players P
	                                JOIN Contracts C USING(player_id)
                               GROUP BY P.player_id) LDC 
						 WHERE CURRENT_DATE > LDC.last_date) THEN 'Есть игроки с просроченным контрактом'
			ELSE ''
			END AS my_message
			
SELECT 'Есть игроки с просроченным контрактом' AS my_message
FROM (SELECT MAX(C.end_date) AS end_date
	  FROM Players P
		JOIN Contracts C USING(player_id)
	  GROUP BY P.player_id)
WHERE CURRENT_DATE > end_date
LIMIT 1

SELECT 'Есть игроки с просроченным контрактом' AS my_message
FROM Players P
WHERE EXISTS (SELECT 1 
              FROM (SELECT C.player_id, MAX(C.end_date) AS end_date
			               FROM Contracts C
						   GROUP BY C.player_id) CN 
			  WHERE CN.player_id = P.player_id AND
			        CURRENT_DATE > CN.end_date)
LIMIT 1

--44) Для каждого спонсора выбрать всех руководителей и, если были контракты с игроками, то количество игроков. 

SELECT sponsor_name,
       CASE WHEN count_players IS NULL THEN 0 ELSE count_players END, 
	   CONCAT(A.surname, ' ', A."name", ' ', A.patronymic)
FROM (SELECT sponsor_name, COUNT(DISTINCT C.player_id) AS count_players
     FROM Sponsors S
		LEFT JOIN SponsorPayments SP ON SP.sponsor_id = S.sponsor_id
		LEFT JOIN Contracts C ON C.contract_id = SP.contract_id
     GROUP BY S.sponsor_id, sponsor_name)
	 CROSS JOIN Administration A


SELECT sponsor_name, count_players, CONCAT(A.surname, ' ', A."name", ' ', A.patronymic)
FROM (SELECT DISTINCT sponsor_name, COUNT(*)  OVER (PARTITION BY sponsor_name) AS count_players
	 FROM (SELECT sponsor_name, 
		   C.player_id,
		   LEAD(C.player_id) OVER (PARTITION BY S.sponsor_id ORDER BY C.player_id) AS next_player_id
		 FROM Sponsors S
			LEFT JOIN SponsorPayments SP ON SP.sponsor_id = S.sponsor_id
			LEFT JOIN Contracts C ON C.contract_id = SP.contract_id)
	 WHERE player_id != next_player_id OR next_player_id IS NULL)
	 CROSS JOIN Administration A

--45) Выбрать фамилию, имя, отчество игрока, который заключал контракты со всеми спонсорами, имеющимися в БД.

SELECT CONCAT(surname, ' ', "name", ' ', patronymic) AS player
FROM Players P
	JOIN Contracts C ON C.player_id = P.player_id
	JOIN SponsorPayments SP ON SP.contract_id = C.contract_id
GROUP BY P.player_id
HAVING  COUNT(DISTINCT SP.sponsor_id) = (SELECT COUNT(*) FROM Sponsors)

SELECT player
FROM (SELECT CONCAT(surname, ' ', "name", ' ', patronymic) AS player, COUNT(DISTINCT SP.sponsor_id) AS count_s
     FROM Players P
	     JOIN Contracts C ON C.player_id = P.player_id
	     JOIN SponsorPayments SP ON SP.contract_id = C.contract_id
     GROUP BY P.player_id)
     CROSS JOIN (SELECT COUNT(*) AS count_all_sponsors FROM Sponsors)
WHERE count_all_sponsors = count_s

--46) Выбрать название спонсора, который последние три года не заключал новых контрактов с игроками и имеет наибольший 
--ежегодный платеж среди всех спонсоров, не заключавших контракты последние три года.
EXPLAIN ANALYZE
WITH MP (sponsor_name, payment)
AS
(SELECT S.sponsor_name, MAX(payment)
FROM Sponsors S
	JOIN SponsorPayments SP ON SP.sponsor_id = S.sponsor_id
	JOIN Contracts C ON C.contract_id = SP.contract_id
GROUP BY S.sponsor_id, sponsor_name
HAVING SUM(CASE WHEN CURRENT_DATE < C.start_date + INTERVAL '3 years' THEN 1 ELSE 0 END) = 0)

SELECT sponsor_name
FROM MP
WHERE payment = (SELECT MAX(payment) FROM MP)

EXPLAIN ANALYZE
SELECT S1.sponsor_name
FROM Sponsors S1
	JOIN (SELECT S2.sponsor_id, MAX(SP1.payment) AS payment
		  FROM Sponsors S2
			JOIN SponsorPayments SP1 ON SP1.sponsor_id = S2.sponsor_id
		  GROUP BY S2.sponsor_id) MP ON MP.sponsor_id = S1.sponsor_id
WHERE NOT EXISTS (SELECT 1
				FROM SponsorPayments SP2
					JOIN Contracts C ON C.contract_id = SP2.contract_id
				WHERE SP2.sponsor_id = S1.sponsor_id AND
					  CURRENT_DATE < C.start_date + INTERVAL '3 years')
ORDER BY payment DESC

--47) Выбрать фамилии, имена, отчества игроков, играющих в наиболее успешном составе.

SELECT P."name", P.surname, P.patronymic
FROM Players P
	JOIN Contracts C ON C.player_id = P.player_id
	CROSS JOIN (SELECT start_date, end_date
	            FROM Results R
		        WHERE league_place = (SELECT MAX(league_place) FROM Results)) LP
WHERE C.end_date BETWEEN LP.start_date AND LP.end_date OR 
	  LP.end_date BETWEEN C.start_date AND C.end_date

SELECT P."name", P.surname, P.patronymic
FROM Players P
	JOIN Contracts C ON C.player_id = P.player_id
	JOIN Results R ON C.end_date BETWEEN R.start_date AND R.end_date OR 
	  R.end_date BETWEEN C.start_date AND C.end_date
WHERE league_place = (SELECT MAX(league_place) FROM Results)

--48) Выбрать название национальности, игроки которой играют в составе, включающем игроков только одной национальности. 

SELECT DISTINCT N1.nationality_name
FROM Nationalities N1
	JOIN Players P1 USING(nationality_id)
	JOIN Contracts C1 USING(player_id)
	JOIN (SELECT D.start_date, D.end_date
		  FROM Nationalities N
			JOIN Players P USING(nationality_id)
			JOIN Contracts C USING(player_id)
		    JOIN (SELECT ACS1.approval_date AS start_date, MIN(ACS2.approval_date) AS end_date
				  FROM ApprovalOfCoachingStaff ACS1
					   CROSS JOIN ApprovalOfCoachingStaff ACS2
				  WHERE ACS1.approval_date < ACS2.approval_date
				  GROUP BY ACS1.approval_date) D ON C.end_date BETWEEN D.start_date AND D.end_date OR 
			                                              D.end_date BETWEEN C.start_date AND C.end_date
           GROUP BY D.start_date, D.end_date
           HAVING COUNT(DISTINCT N.nationality_name) = 1) GD ON C1.end_date BETWEEN GD.start_date AND GD.end_date OR 
			                                                    GD.end_date BETWEEN C1.start_date AND C1.end_date

SELECT DISTINCT nationality_name
FROM (SELECT nationality_name, MAX(unique_number) OVER (PARTITION BY start_date, end_date) AS max_unique_number
		FROM (SELECT D.start_date, D.end_date, N.*, DENSE_RANK() OVER (PARTITION BY D.start_date, D.end_date ORDER BY N.nationality_id) AS unique_number
			  FROM Nationalities N
				JOIN Players P USING(nationality_id)
				JOIN Contracts C USING(player_id)
				JOIN (SELECT ACS1.approval_date AS start_date, MIN(ACS2.approval_date) AS end_date
					  FROM ApprovalOfCoachingStaff ACS1
						   CROSS JOIN ApprovalOfCoachingStaff ACS2
					  WHERE ACS1.approval_date < ACS2.approval_date
					  GROUP BY ACS1.approval_date) D ON C.end_date BETWEEN D.start_date AND D.end_date OR 
															  D.end_date BETWEEN C.start_date AND C.end_date))
WHERE max_unique_number = 1


--49) Выбрать фамилии, имена, отчества, дату рождения и телефон тренеров, которые тренировали межнациональные команды (учтите даты контрактов). 

SELECT DISTINCT T.surname, T."name", T.patronymic, T.date_of_birth, T.phone_number
FROM Trainers T
	JOIN TrainerContracts TC USING(trainer_id)
    JOIN (SELECT D.start_date, D.end_date
	      FROM Nationalities N
		      JOIN Players P USING(nationality_id)
		      JOIN Contracts C USING(player_id)
		      JOIN (SELECT ACS1.approval_date AS start_date, MIN(ACS2.approval_date) AS end_date
			        FROM ApprovalOfCoachingStaff ACS1
				        CROSS JOIN ApprovalOfCoachingStaff ACS2
			        WHERE ACS1.approval_date < ACS2.approval_date
			        GROUP BY ACS1.approval_date) D ON C.end_date BETWEEN D.start_date AND D.end_date OR 
													  D.end_date BETWEEN C.start_date AND C.end_date
	       GROUP BY D.start_date, D.end_date
	       HAVING COUNT(DISTINCT N.nationality_name) > 1) GD ON TC.end_date BETWEEN GD.start_date AND GD.end_date OR 
			                                                    GD.end_date BETWEEN TC.start_date AND TC.end_date


SELECT DISTINCT T.surname, T."name", T.patronymic, T.date_of_birth, T.phone_number
FROM (SELECT start_date, end_date, MAX(unique_number) OVER (PARTITION BY start_date, end_date) AS max_unique_number
		FROM (SELECT D.start_date, D.end_date, N.*, DENSE_RANK() OVER (PARTITION BY D.start_date, D.end_date ORDER BY N.nationality_id) AS unique_number
			  FROM Nationalities N
				JOIN Players P USING(nationality_id)
				JOIN Contracts C USING(player_id)
				JOIN (SELECT ACS1.approval_date AS start_date, MIN(ACS2.approval_date) AS end_date
					  FROM ApprovalOfCoachingStaff ACS1
						   CROSS JOIN ApprovalOfCoachingStaff ACS2
					  WHERE ACS1.approval_date < ACS2.approval_date
					  GROUP BY ACS1.approval_date) D ON C.end_date BETWEEN D.start_date AND D.end_date OR 
													     D.end_date BETWEEN C.start_date AND C.end_date)) GD
	JOIN TrainerContracts TC ON TC.end_date BETWEEN GD.start_date AND GD.end_date OR 
			                    GD.end_date BETWEEN TC.start_date AND TC.end_date
	JOIN Trainers T ON T.trainer_id = TC.trainer_id
WHERE max_unique_number > 1

--50) Выбрать самого дорогого игрока, тренировавшегося у Иванова Ивана Ивановича

WITH IvanPlayers
AS
(SELECT P.*, MAX(SP.payment) OVER (PARTITION BY P.player_id) AS max_payment
FROM Players P
	JOIN Contracts C ON C.player_id = P.player_id
	JOIN SponsorPayments SP ON SP.contract_id = C.contract_id
	JOIN TrainerContracts TC ON C.end_date BETWEEN TC.start_date AND TC.end_date OR 
	                            TC.end_date BETWEEN C.start_date AND C.end_date
	JOIN Trainers T ON T.trainer_id = TC.trainer_id
WHERE T."name" LIKE 'Иван' AND T.surname LIKE 'Иванов' AND T.patronymic LIKE 'Иванович')

SELECT DISTINCT *
FROM IvanPlayers
WHERE max_payment = (SELECT MAX(max_payment) FROM IvanPlayers)


SELECT P.*
FROM Players P
	JOIN Contracts C ON C.player_id = P.player_id
	JOIN SponsorPayments SP ON SP.contract_id = C.contract_id
WHERE EXISTS (SELECT 1
			  FROM TrainerContracts TC
				  JOIN Trainers T ON T.trainer_id = TC.trainer_id
			  WHERE T."name" LIKE 'Иван' AND T.surname LIKE 'Иванов' AND T.patronymic LIKE 'Иванович' AND
			  (C.end_date BETWEEN TC.start_date AND TC.end_date OR
			 TC.end_date BETWEEN C.start_date AND C.end_date))
ORDER BY SP.payment DESC


--51) Выбрать фамилии, имена, отчества игроков, которые в своей карьере имели перерывы более года (учитывать даты контрактов).  
SELECT DISTINCT P.surname, P."name", P.patronymic
FROM PLayers P
	JOIN (SELECT C.player_id,
	             C.end_date,
		         LEAD(C.start_date) OVER (PARTITION BY C.player_id ORDER BY C.end_date) AS next_start
	      FROM Contracts C) GP ON GP.player_id = P.player_id
WHERE next_start IS NOT NULL AND end_date + INTERVAL '1 year' < next_start

SELECT P.surname, P."name", P.patronymic
FROM Players P
WHERE P.player_id IN (SELECT player_id
					  FROM	(SELECT C1.player_id, C1.end_date AS start_date, MIN(C2.start_date) AS end_date
							FROM Contracts C1
							   CROSS JOIN Contracts C2
							WHERE C1.player_id = C2.player_id AND 
								  C1.end_date < C2.start_date
							GROUP BY C1.player_id, C1.end_date) PT
					  GROUP BY PT.player_id
					  HAVING SUM(CASE WHEN PT.start_date + INTERVAL '1 year' < PT.end_date THEN 1 ELSE 0 END) != 0)