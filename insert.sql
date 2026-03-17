TRUNCATE TABLE Nationalities RESTART IDENTITY CASCADE;
TRUNCATE TABLE Positions RESTART IDENTITY CASCADE;
TRUNCATE TABLE Sponsors RESTART IDENTITY CASCADE;
TRUNCATE TABLE Contracts RESTART IDENTITY CASCADE;
TRUNCATE TABLE Players RESTART IDENTITY CASCADE;
TRUNCATE TABLE SponsorPayments CASCADE;
TRUNCATE TABLE Opponents RESTART IDENTITY CASCADE;
TRUNCATE TABLE Competitions RESTART IDENTITY CASCADE;
TRUNCATE TABLE Results RESTART IDENTITY CASCADE;
TRUNCATE TABLE Trainers RESTART IDENTITY CASCADE;
TRUNCATE TABLE Administration RESTART IDENTITY CASCADE;
TRUNCATE TABLE ApprovalOfCoachingStaff RESTART IDENTITY CASCADE;
TRUNCATE TABLE CoachingStaff CASCADE;
TRUNCATE TABLE Matches RESTART IDENTITY CASCADE;
TRUNCATE TABLE TrainerContracts RESTART IDENTITY CASCADE;

INSERT INTO Positions (position_name)
VALUES ('goalkeeper'),
('central forward'),
('right forward'),
('left forward'),
('right defender'),
('left defender');

INSERT INTO Nationalities (nationality_name)
VALUES ('russian'),
('swedish'),
('german'),
('french'),
('dutch'),
('czech'),
('polish'),
('japanese'),
('italian'),
('scottish');

INSERT INTO Players ("name", surname, patronymic, date_of_birth, passport_series, passport_number, division_number, 
date_of_issue, issued_by_whom, team_number, height, weight, phone_number, salary, nationality_id, position_id)
VALUES ('Alexander', 'Ovechkin', 'Mikhailovich', '1985-09-17', 1985, 175901, 95, '2005-09-25', 
'ГУ МВД России по Московской обл.', 50, 191, 108, '89066003020', 5000000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'russian'), (SELECT position_id FROM Positions WHERE position_name LIKE 'goalkeeper')),
('Wayne', 'Gretzky', 'Paul', '1961-01-26', 1961, 1234, 567890, '1980-05-10', 'Ontario Police Department', 
12, 183, 84, '12345678901', 4500000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'polish'), (SELECT position_id FROM Positions WHERE position_name LIKE 'right forward')),
('Sidney', 'Crosby', 'Patrick', '1987-08-07', 1987, 4321, 987654, '2006-08-15', 'Canada Homeland Security', 
34, 180, 91, '10987654321', 6000000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'french'), (SELECT position_id FROM Positions WHERE position_name LIKE 'goalkeeper')),
('Jaromir', 'Jagr', '', '1972-02-15', 1972, 5678, 123456, '1992-03-20', 'Czech Republic Police', 22, 191, 100, 
'78901234567', 3000000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'czech'), (SELECT position_id FROM Positions WHERE position_name LIKE 'central forward')),
('Teemu', 'Selanne', 'Antero', '1970-07-03', 1970, 8765, 432109, '1990-04-14', 'Finnish Police Service', 44, 183, 87, 
'98765432109', 2800000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'dutch'), (SELECT position_id FROM Positions WHERE position_name LIKE 'right defender')),
('Evgeni', 'Malkin', 'Vasiliyevich', '1986-07-31', 1986, 2468, 135790, '2005-06-01', 'ГУ МВД России', 55, 191, 100, 
'89161234567', 5500000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'japanese'), (SELECT position_id FROM Positions WHERE position_name LIKE 'left forward')),
('Joe', 'Sakic', '', '1969-07-07', 1969, 9753, 246801, '1989-08-15', 'RCMP Canada', 11, 183, 86, '12349876543', 
3200000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'russian'), (SELECT position_id FROM Positions WHERE position_name LIKE 'left forward')),
('Martin', 'Brodeur', '', '1972-05-06', 1972, 8642, 975310, '1991-09-01', 'Canadian Federal Police', 15, 188, 91, 
'98765012345', 3400000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'scottish'), (SELECT position_id FROM Positions WHERE position_name LIKE 'right defender')),
('Pavel', 'Bure', 'Valerevich', '1971-03-31', 1971, 1357, 864209, '1990-12-12', 'МВД России', 33, 180, 83, 
'89671234567', 2900000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'swedish'), (SELECT position_id FROM Positions WHERE position_name LIKE 'goalkeeper')),
('Henrik', 'Lundqvist', '', '1982-03-02', 1982, 2469, 357913, '2001-05-20', 'Swedish Police Authority', 64, 185, 91, 
'46789012345', 4000000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'italian'), (SELECT position_id FROM Positions WHERE position_name LIKE 'right defender')),
('Oleg', 'Koks', 'Mikhailovich', '2000-09-17', 2018, 179504, 93, '2018-09-25', 'ГУ МВД России по Московской обл.', 58, 180, 118, 
'89066003090', 5000000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'russian'), (SELECT position_id FROM Positions WHERE position_name LIKE 'goalkeeper')),
('Kevin', 'Adler', 'Pops', '1999-03-02', 1999, 2899, 357413, '2019-05-20', 'Swedish Police Authority', 10, 183, 100, 
'46789012425', 1000000, (SELECT nationality_id FROM Nationalities WHERE nationality_name LIKE 'italian'), (SELECT position_id FROM Positions WHERE position_name LIKE 'right defender'));



INSERT INTO Contracts (start_date, end_date, player_id)
VALUES ('1995-03-01', '2000-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '78901234567')),
('2015-09-01', '2020-09-01', (SELECT player_id FROM Players WHERE phone_number LIKE '98765432109')),
('2010-01-15', '2015-01-15', (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901')),
('2018-08-07', '2023-08-07', (SELECT player_id FROM Players WHERE phone_number LIKE '10987654321')),
('1999-07-01', '2025-11-20', (SELECT player_id FROM Players WHERE phone_number LIKE '89066003020')),
('2013-06-01', '2018-06-01', (SELECT player_id FROM Players WHERE phone_number LIKE '89161234567')),
('2005-10-10', '2010-10-10', (SELECT player_id FROM Players WHERE phone_number LIKE '12349876543')),
('2008-09-01', '2013-09-01', (SELECT player_id FROM Players WHERE phone_number LIKE '46789012345')),
('2010-12-15', '2015-12-15', (SELECT player_id FROM Players WHERE phone_number LIKE '89671234567')),
('2012-03-01', '2017-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '98765012345')),
('1995-12-01', '2000-12-01', (SELECT player_id FROM Players WHERE phone_number LIKE '78901234567')),
('2015-01-09', '2018-11-15', (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901')),
('2024-03-01', '2025-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '46789012425')),
('2025-04-01', '2026-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '46789012425')),
('2027-04-01', '2028-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '46789012425')),
('2029-04-01', '2030-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '46789012425')),
('2024-03-01', '2025-10-10', (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901')),
('1995-03-01', '1998-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '89066003020')),
('1995-03-01', '2000-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '89066003090')),
('1995-03-01', '2000-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '12349876543')),
('1995-03-01', '2000-03-01', (SELECT player_id FROM Players WHERE phone_number LIKE '98765012345'));


INSERT INTO Sponsors (sponsor_name)
VALUES ('Gazprom'),
('Honda'),
('Skoda'),
('Adidas'),
('Apple'),
('SAP'),
('Fastenal'),
('EA Sports'),
('Amazon'),
('Tinkoff');

INSERT INTO SponsorPayments
VALUES (5000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '89066003020') AND start_date = '1999-07-01' AND end_date = '2004-07-01'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Tinkoff')),
(3000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '89161234567') AND start_date = '2013-06-01' AND end_date = '2018-06-01'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Amazon')),
(2000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12349876543') AND start_date = '2005-10-10' AND end_date = '2010-10-10'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'SAP')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '46789012345') AND start_date = '2008-09-01' AND end_date = '2013-09-01'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Skoda')),
(3500000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '10987654321') AND start_date = '2018-08-07' AND end_date = '2023-08-07'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'EA Sports')),
(2500000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2010-01-15' AND end_date = '2015-01-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Gazprom')),
(1500000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '89671234567') AND start_date = '2010-12-15' AND end_date = '2015-12-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Apple')),
(5000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '98765012345') AND start_date = '2012-03-01' AND end_date = '2017-03-01'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Honda')),
(4500000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '78901234567') AND start_date = '1995-03-01' AND end_date = '2000-03-01'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Adidas')),
(3000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '98765432109') AND start_date = '2015-09-01' AND end_date = '2020-09-01'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Fastenal')),
(75000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '78901234567') AND start_date = '1995-12-01' AND end_date = '2000-12-01'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Apple')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2015-01-09' AND end_date = '2018-11-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Apple')),
(200000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2024-03-01' AND end_date = '2025-10-10'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Skoda')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '46789012425') AND start_date = '2025-04-01' AND end_date = '2026-03-01'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Apple')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '98765012345') AND start_date = '1995-03-01' AND end_date = '2000-03-01'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Honda')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2010-01-15' AND end_date = '2015-01-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Tinkoff')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2010-01-15' AND end_date = '2015-01-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Honda')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2010-01-15' AND end_date = '2015-01-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Adidas')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2010-01-15' AND end_date = '2015-01-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'SAP')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2010-01-15' AND end_date = '2015-01-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Fastenal')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2010-01-15' AND end_date = '2015-01-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'EA Sports')),
(1000000, (SELECT contract_id FROM Contracts WHERE player_id = (SELECT player_id FROM Players WHERE phone_number LIKE '12345678901') AND start_date = '2010-01-15' AND end_date = '2015-01-15'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Amazon'));

INSERT INTO Competitions (competition_name)
VALUES ('Entry Draft'),
('Stanley Cup'),
('President Cup'),
('Regular Season'),
('All-Star Game');

INSERT INTO Results (league_place, prize_fund, competition_date, year_payment, start_date, end_date, competition_id, 
sponsor_id)
VALUES (5, 1000000, '2005-10-10', 500000, '2005-09-15', '2005-11-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Entry Draft'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Amazon')),
(5, 1500000, '2003-12-15', 600000, '2003-10-25', '2004-06-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'President Cup'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Tinkoff')),
(2, 2000000, '2010-10-27', 800000, '2010-09-15', '2011-07-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Regular Season'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Apple')),
(5, 1000000, '2008-12-29', 500000, '2008-09-15', '2009-07-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'All-Star Game'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'EA Sports')),
(2, 5000000, '2015-10-11', 500000, '2015-09-16', '2016-04-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Stanley Cup'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Adidas')),
(1, 1000000, '1995-10-10', 200000, '1995-09-15', '1996-07-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Regular Season'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Skoda')),
(3, 10000000, '2020-03-07', 900000, '2019-09-10', '2020-07-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Regular Season'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Gazprom')),
(5, 7000000, '2015-11-10', 500000, '2015-09-09', '2016-11-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Regular Season'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Honda')),
(2, 5500000, '2013-01-02', 100000, '2012-09-15', '2013-04-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Stanley Cup'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'Fastenal')),
(7, 2500000, '2001-10-21', 200000, '2001-09-09', '2002-07-01', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'President Cup'), (SELECT sponsor_id FROM Sponsors WHERE sponsor_name LIKE 'SAP'));

INSERT INTO Opponents (opponent_name)
VALUES ('Toronto Maple Leafs'),
('Tampa Bay Lightning'),
('Florida Panthers'),
('Montreal Canadiens'),
('Detroit Red Wings'),
('Buffalo Sabres'),
('Boston Bruins'),
('Vegas Golden Knights'),
('Los Angeles Kings'),
('Edmonton Oilers');

INSERT INTO Administration ("name", surname, patronymic, date_of_birth, passport_series, passport_number, 
division_number, date_of_issue, issued_by_whom, phone_number)
VALUES ('Olivia', 'Preston', 'Marie', '1965-09-17', 1965, 175901, 95, '2005-09-25', 'ГУ МВД России по Московской области', '89066003020'),
('Liam', 'Marshall', 'Benjamin', '1961-01-26', 1961, 1234, 567890, '1980-05-10', 'Ontario Police Department', '12345678901'),
('Noah', 'Gretzky', 'Alexander', '1987-08-07', 1987, 4321, 987654, '2006-08-15', 'Canada Homeland Security', '10987654321'),
('Emma', 'Holland', 'Grace', '1972-02-15', 1972, 5678, 123456, '1992-03-20', 'Czech Republic Police', '78901234567'),
('Mason', 'Bradley', 'N/A', '1970-07-03', 1970, 8765, 432109, '1990-04-14', 'Finnish Police Service', '98765432109'),
('Ava', 'Lawson', 'Christine', '1986-07-31', 1986, 2468, 135790, '2005-06-01', 'ГУ МВД России', '89161234567'),
('James', 'Cooper', 'N/A', '1969-07-07', 1969, 9753, 246801, '1989-08-15', 'RCMP Canada', '12349876543'),
('Sophia', 'Reed', 'Ann', '1972-05-06', 1972, 8642, 975310, '1991-09-01', 'Canadian Federal Police', '98765012345'),
('Lucas', 'Foster', 'Michael', '1971-03-31', 1971, 1357, 864209, '1990-12-12', 'МВД России', '89671234567'),
('Isabella', 'Grant', 'N/A', '1982-03-02', 1982, 2469, 357913, '2001-05-20', 'Swedish Police Authority', '46789012345');

INSERT INTO Trainers ("name", surname, patronymic, date_of_birth, passport_series, passport_number, division_number, date_of_issue, issued_by_whom, phone_number, license)
VALUES ('Scotty', 'Bowman', 'Stuart', '1985-09-17', 1985, 175901, 95, '2005-09-25', 'ГУ МВД России по Московской области', '89066003020', 3027),
('Wayne', 'Gretzky', 'Douglas', '1961-01-26', 1961, 1234, 567890, '1980-05-10', 'Ontario Police Department', '12345678901', 92),
('Joel', 'Quenneville', 'Douglas', '1987-08-07', 1987, 4321, 987654, '2006-08-15', 'Canada Homeland Security', '10987654321', 179),
('Herb', 'Brooks', 'Percy', '1972-02-15', 1972, 5678, 123456, '1992-03-20', 'Czech Republic Police', '78901234567', 59034),
('Mike', 'Babcock', 'Breton', '1970-07-03', 1970, 8765, 432109, '1990-04-14', 'Finnish Police Service', '98765432109', 861510),
('Pat', 'Quinn', 'Curtis', '1986-07-31', 1986, 2468, 135790, '2005-06-01', 'ГУ МВД России', '89161234567', 70),
('Alain', 'Vigneault', 'Bernard', '1969-07-07', 1969, 9753, 246801, '1989-08-15', 'RCMP Canada', '12349876543', 1380),
('Barry', 'Melrose', 'Lee', '1972-05-06', 1972, 8642, 975310, '1991-09-01', 'Canadian Federal Police', '98765012345', 341),
('Darryl', 'Sutter', 'Joseph', '1971-03-31', 1971, 1357, 864209, '1990-12-12', 'МВД России', '89671234567', 604),
('Claude', 'Julien', 'Raymond', '1982-03-02', 1982, 2469, 357913, '2001-05-20', 'Swedish Police Authority', '46789012345', 901),
('Martin', 'Warm', '', '1985-09-17', 1995, 2459, 93, '2005-09-25', 'Swedish Police Authority', '', 30270),
('Smoke', 'Ice', 'Stuart', '1985-09-17', 1989, 2439, 95, '2009-09-25', 'Swedish Police Authority', '89066993020', 3227),
('Richard', 'Push', '', '1985-09-17', 1990, 2419, 95, '2010-09-25', 'Swedish Police Authority', '89066693021', 2227),
('Иван', 'Иванов', 'Иванович', '1985-09-17', 1985, 175901, 95, '2005-09-25', 'ГУ МВД России по Московской области', '89066003525', 3082)
('Pit', 'Bowman', 'Stuart', '1985-09-17', 1985, 175901, 95, '2005-09-25', 'ГУ МВД России по Московской области', '8906600', 302),
('Pit', 'Bowman', 'Stuart', '1985-09-17', 1985, 175901, 95, '2005-09-25', 'ГУ МВД России по Московской области', '890660090', 38);

INSERT INTO TrainerContracts (start_date, end_date, trainer_id, payment)
VALUES ('1998-01-01', '2002-01-01', (SELECT trainer_id FROM Trainers WHERE license = 92), 100000),
('1998-01-01', '2020-01-01', (SELECT trainer_id FROM Trainers WHERE license = 3082), 100000);

INSERT INTO ApprovalOfCoachingStaff (approval_date, head_id)
VALUES ('1995-07-13', (SELECT head_id FROM Administration WHERE phone_number LIKE '89066003020')),
('2000-09-10', (SELECT head_id FROM Administration WHERE phone_number LIKE '12345678901')),
('2003-04-21', (SELECT head_id FROM Administration WHERE phone_number LIKE '12345678901')),
('2005-02-25', (SELECT head_id FROM Administration WHERE phone_number LIKE '10987654321')),
('2007-09-17', (SELECT head_id FROM Administration WHERE phone_number LIKE '78901234567')),
('2010-10-13', (SELECT head_id FROM Administration WHERE phone_number LIKE '98765432109')),
('2013-11-09', (SELECT head_id FROM Administration WHERE phone_number LIKE '89161234567')),
('2016-07-19', (SELECT head_id FROM Administration WHERE phone_number LIKE '89161234567')),
('2020-12-29', (SELECT head_id FROM Administration WHERE phone_number LIKE '12349876543')),
('2024-01-01', (SELECT head_id FROM Administration WHERE phone_number LIKE '98765012345'));

INSERT INTO CoachingStaff
VALUES ((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '1995-07-13'), (SELECT trainer_id FROM Trainers WHERE license = 3027)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2000-09-10'), (SELECT trainer_id FROM Trainers WHERE license = 92)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2003-04-21'), (SELECT trainer_id FROM Trainers WHERE license = 179)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2005-02-25'), (SELECT trainer_id FROM Trainers WHERE license = 59034)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2007-09-17'), (SELECT trainer_id FROM Trainers WHERE license = 861510)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2010-10-13'), (SELECT trainer_id FROM Trainers WHERE license = 70)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2013-11-09'), (SELECT trainer_id FROM Trainers WHERE license = 1380)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2016-07-19'), (SELECT trainer_id FROM Trainers WHERE license = 341)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2020-12-29'), (SELECT trainer_id FROM Trainers WHERE license = 604)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2024-01-01'), (SELECT trainer_id FROM Trainers WHERE license = 604)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2024-01-01'), (SELECT trainer_id FROM Trainers WHERE license = 179))
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '1995-07-13'), (SELECT trainer_id FROM Trainers WHERE license = 302)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2005-02-25'), (SELECT trainer_id FROM Trainers WHERE license = 38)),
((SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '1995-07-13'), (SELECT trainer_id FROM Trainers WHERE license = 38));

INSERT INTO Matches (scored_goals, passed_goals, sold_tickets, tactic, scheme, match_date, competition_id, 
opponent_id, coaching_staff_id)
VALUES (6, 2, 10000, 'акцент на нападение', 'reference', '1996-05-12', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Entry Draft'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Tampa Bay Lightning'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '1995-07-13')),
(3, 1, 15000, 'стремительное нападение и оборона флангов', 'reference', '2001-01-10', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Stanley Cup'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Florida Panthers'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2000-09-10')),
(0, 0, 20000, 'акцент на оборону', 'reference', '2002-05-01', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'President Cup'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Toronto Maple Leafs'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2000-09-10')),
(0, 2, 5000, 'вымотать соперника', 'reference', '2004-03-21', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Regular Season'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Buffalo Sabres'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2003-04-21')),
(2, 2, 20000, 'стремительное нападение', 'reference', '2006-12-17', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'All-Star Game'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Detroit Red Wings'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2005-02-25')),
(7, 5, 8000, 'прессинг', 'reference', '2007-02-19', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Regular Season'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Montreal Canadiens'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2007-09-17')),
(4, 2, 10000, 'играть по новой схеме', 'reference', '2011-03-11', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Stanley Cup'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Boston Bruins'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2010-10-13')),
(1, 2, 2000, 'прессинг', 'reference', '2014-04-23', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Entry Draft'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Vegas Golden Knights'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2013-11-09')),
(4, 3, 15000, 'шумная игра', 'reference', '2017-10-25', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Regular Season'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Los Angeles Kings'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2016-07-19')),
(5, 5, 10000, 'ловушка на дурака', 'reference', '2022-11-12', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Regular Season'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Florida Panthers'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2020-12-29')),
(6, 0, 10000, '', 'reference', '2003-05-12', (SELECT competition_id FROM Competitions WHERE competition_name LIKE 'Entry Draft'), (SELECT opponent_id FROM Opponents WHERE opponent_name LIKE 'Tampa Bay Lightning'), (SELECT coaching_staff_id FROM ApprovalOfCoachingStaff WHERE approval_date = '2024-01-01'));