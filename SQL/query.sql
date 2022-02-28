USE tempdb
ALTER DATABASE  Caso01_DB2_Esteban SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
DROP DATABASE IF EXISTS Caso01_DB2_Esteban 
GO
CREATE DATABASE Caso01_DB2_Esteban 
GO
USE Caso01_DB2_Esteban 

--Create tables

CREATE TABLE PROVINCE(
  province_id INT IDENTITY(1,1) PRIMARY KEY,
  province_name NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE CANTON(
  canton_id INT IDENTITY(1,1) PRIMARY KEY,
  canton_name NVARCHAR(250) NOT NULL,
  province_id INT NOT NULL FOREIGN KEY REFERENCES PROVINCE(province_id)
)

CREATE TABLE USER_TYPE(
  user_type_id INT IDENTITY(1,1) PRIMARY KEY,
  user_type_name NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE KPI_TYPE(
  kpi_id INT IDENTITY(1,1) PRIMARY KEY,
  kpi_name NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE PARTY(
  party_id INT IDENTITY(1,1) PRIMARY KEY,
  party_name NVARCHAR(250) NOT NULL UNIQUE,
  flag NVARCHAR(500) NOT NULL UNIQUE,
  creation_date SMALLDATETIME NOT NULL,
  foundation DATE,
)

CREATE TABLE PERSON(
  person_id INT IDENTITY(1,1) PRIMARY KEY,
  person_name NVARCHAR(250) NOT NULL,
  lastname NVARCHAR(250) NOT NULL,
  birthdate DATE, 
  id INT NOT NULL UNIQUE,
  photo NVARCHAR(500),
  creation_date SMALLDATETIME NOT NULL,
  canton_id INT NOT NULL FOREIGN KEY REFERENCES CANTON(canton_id)
)

CREATE TABLE EMAIL(
  email_id INT IDENTITY(1,1) PRIMARY KEY,
  email NVARCHAR(250) NOT NULL UNIQUE,
  person_id INT NOT NULL FOREIGN KEY REFERENCES PERSON(person_id)
)

CREATE TABLE PHONE(
  phone INT PRIMARY KEY,
  person_id INT NOT NULL FOREIGN KEY REFERENCES PERSON(person_id)
)

CREATE TABLE USER_X_TYPE(
  id INT IDENTITY(1,1) PRIMARY KEY,
  person_id INT NOT NULL FOREIGN KEY REFERENCES PERSON(person_id),
  user_type_id INT NOT NULL FOREIGN KEY REFERENCES USER_TYPE(user_type_id)
)

CREATE TABLE USER_X_GROUP(
  id INT IDENTITY(1,1) PRIMARY KEY,
  person_id INT NOT NULL FOREIGN KEY REFERENCES PERSON(person_id),
  party_id INT NOT NULL FOREIGN KEY REFERENCES PARTY(party_id)
)

CREATE TABLE PLAN_PARTY(
  plan_id INT IDENTITY(1,1) PRIMARY KEY,
  title NVARCHAR(150) NOT NULL,
  description_plan NVARCHAR(250),
  party_id INT NOT NULL FOREIGN KEY REFERENCES PARTY(party_id),
  publish_date DATE NOT NULL,
)

CREATE TABLE ACTION_PLAN(
  action_id INT IDENTITY(1,1) PRIMARY KEY,
  action_name NVARCHAR(150) NOT NULL,
  action_description NVARCHAR(2000), 
  plan_id INT NOT NULL FOREIGN KEY REFERENCES PLAN_PARTY(plan_id)
)

CREATE TABLE DELIVERABLES(
  deliverable_id INT IDENTITY(1,1) PRIMARY KEY,
  action_id INT NOT NULL FOREIGN KEY REFERENCES ACTION_PLAN(action_id),
  plan_id INT NOT NULL FOREIGN KEY REFERENCES PLAN_PARTY(plan_id), 
  canton_id INT NOT NULL FOREIGN KEY REFERENCES CANTON(canton_id),
  kpi_value INT NOT NULL,
  kpi_type INT NOT NULL FOREIGN KEY REFERENCES KPI_TYPE(kpi_id),
  post_time DATE NOT NULL
)
GO 
-- SP query 01

CREATE PROCEDURE query01 
  @canton_id INT
AS
SELECT deliverable_id, action_id, PLAN_PARTY.party_id
FROM DELIVERABLES
INNER JOIN PLAN_PARTY
ON PLAN_PARTY.party_id = DELIVERABLES.plan_id 
WHERE canton_id = @canton_id
ORDER BY PLAN_PARTY.party_id
GO
--Inserts

INSERT INTO PROVINCE (province_name) VALUES ('Cartago'),('Heredia'),('San Jose'),('Limon'),('Alajuela'),('Puntarenas'),('Guanacaste')
INSERT INTO CANTON (canton_name, province_id) VALUES ('Marjayoûn', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Jingkou', 3);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Fāqūs', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Shiliting', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('La Unión', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Rumilly', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Auki', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Vimmerby', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Chernyanka', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Yedogon', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Nejo', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Almirante', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Mulanje', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Liulin', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Asopía', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Armenia', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Xidoupu', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Novoye Devyatkino', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Ha', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Biguaçu', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Scholkine', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Sel’tso', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Kishi', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Lisala', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('São Pedro da Aldeia', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Lamía', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Cerenti', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('El Galpón', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Shizikeng', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Surin', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Navais', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Delgado', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Gus’-Zheleznyy', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Marondera', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Saguday', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Melun', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Baiqi', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Marmande', 3);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Pumai', 3);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Bayang', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Cojutepeque', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Xiejiatan', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Guane', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Lingqiao', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Jabinyānah', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Nakhchivan', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Viçosa do Ceará', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Emmaboda', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Rizómata', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('San Diego', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Barnaul', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Īlām', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Safonovo', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Pokrovka', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Osoyoos', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Buçimas', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Vanves', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Padamulya', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Qinghua', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Quimbaya', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Daxing', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Kortesjärvi', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Rizokárpaso', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Dundee', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Hema', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Atuntaqui', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Milltown', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Nishinomiya-hama', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Strömsund', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Rtishchevo', 3);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Selorejo', 3);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Monastir', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Nanjing', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Yarmolyntsi', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Chulakivka', 3);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Kopparberg', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Vitarte', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Zürich', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Drawsko', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Jiuxian', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Shanghu', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Baiqi', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Venustiano Carranza', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Yelwa', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Bāgh-e Maīdān', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Wangzha', 3);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Dawangzhuang', 3);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Passo Fundo', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Tianzhu', 7);
INSERT INTO CANTON (canton_name, province_id) VALUES ('San Jose', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Shymkent', 5);
INSERT INTO CANTON (canton_name, province_id) VALUES ('San Andres', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Jeffersonville', 2);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Aldeia de Juzo', 4);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Angers', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Embarcación', 1);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Energeticheskiy', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Paris La Défense', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Novi Vinodolski', 6);
INSERT INTO CANTON (canton_name, province_id) VALUES ('Sumberejo', 5);

INSERT INTO USER_TYPE (user_type_name) VALUES ('Admin de Campaña'), ('Ciudadano')

INSERT INTO KPI_TYPE (kpi_name) VALUES ('eu');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('nulla');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('odio');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('rhoncus');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('cras');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('eget');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('eutsata');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('purus');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('nunc');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('luctus');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('ipsum');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('suspendisse');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('molestie');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('nulltsartara');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('pede');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('tellus');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('vestibulum');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('habitasse');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('mi');
INSERT INTO KPI_TYPE (kpi_name) VALUES ('orci');

INSERT INTO PARTY (party_name, flag, creation_date, foundation) VALUES ('Russel, Rippin and Schmidt', 'http://dummyimage.com/178x100.png/cc0000/ffffff', '10/13/1995', '7/7/2019');
INSERT INTO PARTY (party_name, flag, creation_date, foundation) VALUES ('Mitchell, Heller and Kirlin', 'http://dummyimage.com/195x100.png/cc0000/ffffff', '6/30/2014', '12/7/2002');
INSERT INTO PARTY (party_name, flag, creation_date, foundation) VALUES ('Stoltenberg-Crooks', 'http://dummyimage.com/249x100.png/cc0000/ffffff', '6/2/2013', '6/20/1998');
INSERT INTO PARTY (party_name, flag, creation_date, foundation) VALUES ('Huel-Leannon', 'http://dummyimage.com/153x100.png/ff4444/ffffff', '9/15/2010', '2/22/2017');
INSERT INTO PARTY (party_name, flag, creation_date, foundation) VALUES ('Kulas-Sanford', 'http://dummyimage.com/204x100.png/cc0000/ffffff', '6/21/2001', '5/16/2006');

INSERT INTO PERSON (person_name, lastname, birthdate, id, photo, creation_date, canton_id) VALUES ('Ondrea', 'Bunning', '7/7/1986', 563888066, 'http://dummyimage.com/132x100.png/ff4444/ffffff', '11/24/2020', 27);
INSERT INTO PERSON (person_name, lastname, birthdate, id, photo, creation_date, canton_id) VALUES ('Fidel', 'Deme', '11/10/1982', 108502591, 'http://dummyimage.com/241x100.png/cc0000/ffffff', '5/21/2020', 96);
INSERT INTO PERSON (person_name, lastname, birthdate, id, photo, creation_date, canton_id) VALUES ('Catharina', 'Simmgen', '4/19/1969', 715394889, 'http://dummyimage.com/137x100.png/ff4444/ffffff', '9/10/2020', 40);
INSERT INTO PERSON (person_name, lastname, birthdate, id, photo, creation_date, canton_id) VALUES ('Ev', 'Morson', '9/15/1981', 307116162, 'http://dummyimage.com/224x100.png/dddddd/000000', '5/1/2020', 97);
INSERT INTO PERSON (person_name, lastname, birthdate, id, photo, creation_date, canton_id) VALUES ('Onida', 'Steen', '12/19/1983', 553826965, 'http://dummyimage.com/162x100.png/5fa2dd/ffffff', '4/3/2020', 59);

INSERT INTO EMAIL (email, person_id) VALUES ('lhupe0@godaddy.com', 2);
INSERT INTO EMAIL (email, person_id) VALUES ('aputton1@discuz.net', 1);
INSERT INTO EMAIL (email, person_id) VALUES ('jinchan2@imgur.com', 1);
INSERT INTO EMAIL (email, person_id) VALUES ('gmcgarrie3@wikia.com', 3);
INSERT INTO EMAIL (email, person_id) VALUES ('stellwright4@imgur.com', 2);
INSERT INTO EMAIL (email, person_id) VALUES ('jrikard5@parallels.com', 1);
INSERT INTO EMAIL (email, person_id) VALUES ('rwilkes6@huffingtonpost.com', 3);
INSERT INTO EMAIL (email, person_id) VALUES ('fcervantes7@sun.com', 5);
INSERT INTO EMAIL (email, person_id) VALUES ('gklambt8@elpais.com', 3);
INSERT INTO EMAIL (email, person_id) VALUES ('mmontes9@java.com', 2);
INSERT INTO EMAIL (email, person_id) VALUES ('cladburya@jugem.jp', 5);
INSERT INTO EMAIL (email, person_id) VALUES ('tosbistonb@joomla.org', 2);
INSERT INTO EMAIL (email, person_id) VALUES ('ahearsonc@uiuc.edu', 5);
INSERT INTO EMAIL (email, person_id) VALUES ('dkitchinghamd@cam.ac.uk', 5);
INSERT INTO EMAIL (email, person_id) VALUES ('alattiee@i2i.jp', 3);
INSERT INTO EMAIL (email, person_id) VALUES ('kgwiltf@statcounter.com', 5);
INSERT INTO EMAIL (email, person_id) VALUES ('talliboneg@adobe.com', 3);
INSERT INTO EMAIL (email, person_id) VALUES ('dmawmanh@symantec.com', 5);
INSERT INTO EMAIL (email, person_id) VALUES ('dshimmani@goo.ne.jp', 4);
INSERT INTO EMAIL (email, person_id) VALUES ('wcrewtherj@alibaba.com', 3);
INSERT INTO EMAIL (email, person_id) VALUES ('kfanshawk@sciencedirect.com', 5);
INSERT INTO EMAIL (email, person_id) VALUES ('hgilberthorpel@elpais.com', 1);
INSERT INTO EMAIL (email, person_id) VALUES ('mgreenliesm@youtu.be', 5);
INSERT INTO EMAIL (email, person_id) VALUES ('elawien@gravatar.com', 1);
INSERT INTO EMAIL (email, person_id) VALUES ('taujeano@wired.com', 3);
INSERT INTO EMAIL (email, person_id) VALUES ('nansteep@nydailynews.com', 4);
INSERT INTO EMAIL (email, person_id) VALUES ('rhollingsheadq@soup.io', 4);
INSERT INTO EMAIL (email, person_id) VALUES ('sdesquesnesr@npr.org', 4);
INSERT INTO EMAIL (email, person_id) VALUES ('vmcmurrughs@prnewswire.com', 5);
INSERT INTO EMAIL (email, person_id) VALUES ('agusht@blogspot.com', 1);

INSERT INTO PHONE (phone, person_id) VALUES ('253472', 4);
INSERT INTO PHONE (phone, person_id) VALUES ('670266', 2);
INSERT INTO PHONE (phone, person_id) VALUES ('696315', 3);
INSERT INTO PHONE (phone, person_id) VALUES ('838533', 1);
INSERT INTO PHONE (phone, person_id) VALUES ('147733', 4);
INSERT INTO PHONE (phone, person_id) VALUES ('371378', 2);
INSERT INTO PHONE (phone, person_id) VALUES ('804994', 2);
INSERT INTO PHONE (phone, person_id) VALUES ('113448', 3);
INSERT INTO PHONE (phone, person_id) VALUES ('322147', 2);
INSERT INTO PHONE (phone, person_id) VALUES ('541752', 5);

INSERT INTO USER_X_TYPE (person_id, user_type_id) VALUES (1,1),(2,1),(3,1),(4,1),(5,1)
INSERT INTO USER_X_GROUP(person_id, party_id) VALUES (1,1),(2,2),(3,3),(4,4),(5,5)

INSERT INTO PLAN_PARTY (title, description_plan, party_id, publish_date) VALUES ('Rabbit à la Berlin (Królik po berlinsku)', 'cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec', 1, '8/1/2021');
INSERT INTO PLAN_PARTY (title, description_plan, party_id, publish_date) VALUES ('Tentacles (Tentacoli)', 'orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in', 2, '1/7/2022');
INSERT INTO PLAN_PARTY (title, description_plan, party_id, publish_date) VALUES ('See the Sea', 'rutrum ac lobortis vel dapibus at', 3, '5/13/2021');
INSERT INTO PLAN_PARTY (title, description_plan, party_id, publish_date) VALUES ('Girls on the Road (a.k.a. Hot Summer Week)', 'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc', 4, '12/11/2021');
INSERT INTO PLAN_PARTY (title, description_plan, party_id, publish_date) VALUES ('The Fuller Brush Man', 'ipsum praesent blandit lacinia erat', 5, '8/15/2021');

INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Willard', 'euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Brooklyn Dodgers: The Ghosts of Flatbush', 'pede lobortis ligula sit amet eleifend pede libero quis', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Small Faces', 'et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Let''s Make Money', 'in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Shadow, The', 'morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Wonder Man', 'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Dread', 'nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Eye for an Eye', 'lacus morbi sem mauris laoreet', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Murder Ahoy', 'et ultrices posuere cubilia curae donec pharetra magna', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Long Gray Line, The', 'maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('You Don''t Know Jack', 'justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Star for Two, A', 'ut blandit non interdum in ante vestibulum', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Broken English', 'justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Altiplano', 'suscipit ligula in lacus curabitur at ipsum', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('The Forgotten Faces', 'accumsan odio curabitur convallis duis consequat dui', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Sydney (Hard Eight)', 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Waste Land', 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('The Last Train through Harecastle Tunnel', 'neque sapien placerat ante nulla justo aliquam quis turpis eget', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('These Are the Damned (a.k.a. The Damned)', 'accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Champion, The', 'rhoncus aliquam lacus morbi quis tortor id nulla', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('As Tears Go By (Wong gok ka moon)', 'etiam pretium iaculis justo in hac habitasse', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Culloden (The Battle of Culloden)', 'consequat metus sapien ut nunc vestibulum ante ipsum primis', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Marquis', 'posuere nonummy integer non velit donec diam neque vestibulum eget vulputate', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Tempest, The', 'fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Dragon Crusaders', 'lorem integer tincidunt ante vel', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Animated Motion: Part 5', 'odio condimentum id luctus nec molestie sed justo pellentesque viverra', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Ice Age 2: The Meltdown', 'nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Closer', 'eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Twilight People, The', 'varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Cry ''Havoc''', 'pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Bedlam', 'sapien arcu sed augue aliquam erat volutpat in congue', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('White Mane (Crin blanc: Le cheval sauvage)', 'vestibulum ante ipsum primis in faucibus orci', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Crime and Punishment', 'turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('American History X', 'vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Sunrise: A Song of Two Humans', 'risus dapibus augue vel accumsan', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Nightmare on Elm Street 4: The Dream Master, A', 'suspendisse potenti cras in purus eu', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Life in Flight ', 'sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('After the Fox (Caccia alla volpe)', 'pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('BookWars', 'neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Houdini', 'donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Growth', 'eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Jay and Silent Bob Go Down Under', 'eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Lupin III: Sweet Lost Night (Rupan Sansei: Sweet Lost Night)', 'feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Light Sleeper', 'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Bukowski: Born into This', 'luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Great Debaters, The', 'in tempor turpis nec euismod scelerisque quam turpis adipiscing', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Merry-Go-Round', 'ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Wipers Times, The', 'augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Cabin Boy', 'integer aliquet massa id lobortis convallis tortor risus dapibus augue vel', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Mr. Freedom', 'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Murder, Inc.', 'luctus cum sociis natoque penatibus et magnis', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Mr. Jealousy', 'sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('White Chicks', 'ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Death Ship', 'vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Who Is Killing the Great Chefs of Europe?', 'etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Blonde Ice', 'rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Another Me', 'justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Revenge of the Nerds II: Nerds in Paradise', 'morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Soapdish', 'libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Shoulder Arms', 'justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Cast a Dark Shadow (Angel)', 'dui vel nisl duis ac nibh fusce lacus purus aliquet at', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Bastards of the Party', 'quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('A House of Secrets: Exploring ''Dragonwyck''', 'consequat dui nec nisi volutpat eleifend donec ut dolor', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Children of Leningradsky, The', 'pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Dragon Ball GT: A Hero''s Legacy (Doragon bôru GT: Gokû gaiden! Yûki no akashi wa sû-shin-chû)', 'tellus in sagittis dui vel nisl duis ac nibh fusce', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Loser Takes All, The (O hamenos ta pairnei ola)', 'id consequat in consequat ut nulla sed accumsan felis ut at dolor quis', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Yards, The', 'non velit nec nisi vulputate nonummy maecenas', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Win Win', 'felis ut at dolor quis odio consequat', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Transylmania', 'montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Pride and the Passion, The', 'massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Hand of Death, The (Shao Lin men)', 'suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Future Weather', 'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Mikra Anglia', 'aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Shuttle', 'vel augue vestibulum rutrum rutrum neque aenean', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('The Hallelujah Handshake', 'in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Decision Before Dawn', 'tempus vivamus in felis eu sapien cursus vestibulum', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Fuck You, Goethe (Fack Ju Göhte)', 'nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Hour of the Gun', 'cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('The Man Who Lived Again', 'tortor sollicitudin mi sit amet lobortis', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Eyes Without a Face (Yeux sans visage, Les)', 'eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Stolen Life, A', 'mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Ronde, La', 'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Por un puñado de besos', 'aliquet pulvinar sed nisl nunc rhoncus', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Limit (Limite)', 'iaculis justo in hac habitasse platea dictumst', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Welcome to Woop-Woop', 'viverra diam vitae quam suspendisse potenti nullam porttitor lacus at', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Angel of Mine (a.k.a. The Mark of an Angel) (L''empreinte de l''ange)', 'quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Body Heat', 'a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Cremator, The (Spalovac mrtvol)', 'at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Roman Spring of Mrs. Stone, The', 'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Small Town Murder Songs', 'felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Problem Child 2', 'curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Lion King II: Simba''s Pride, The', 'sed accumsan felis ut at dolor', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Kissing Jessica Stein', 'non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('From Here to Eternity', 'justo pellentesque viverra pede ac diam cras pellentesque volutpat', 3);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Ossessione', 'at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('The Suspended Step of the Stork', 'posuere metus vitae ipsum aliquam non', 4);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Finding a Family', 'eget rutrum at lorem integer', 5);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Maze Runner, The', 'ac consequat metus sapien ut nunc', 1);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Salaam Namaste', 'amet diam in magna bibendum imperdiet nullam orci pede venenatis non', 2);
INSERT INTO ACTION_PLAN (action_name, action_description, plan_id) VALUES ('Summer by the River, A (Kuningasjätkä)', 'quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus', 2);

INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (89, 3, 7, 617, 12, '11/23/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (43, 5, 99, 1630, 10, '3/21/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (79, 5, 22, 6203, 16, '12/22/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (8, 5, 97, 2501, 20, '9/15/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (37, 5, 42, 8176, 2, '10/4/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (36, 3, 33, 7497, 7, '7/5/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 2, 38, 2659, 15, '8/6/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (8, 5, 7, 391, 14, '4/1/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (22, 3, 92, 7248, 16, '3/15/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (17, 4, 74, 299, 9, '4/29/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (30, 3, 35, 7801, 18, '12/22/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (96, 5, 94, 2225, 4, '8/23/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (85, 4, 77, 2430, 14, '9/27/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (95, 2, 43, 7664, 3, '7/30/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (34, 1, 82, 7066, 2, '5/5/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (98, 3, 44, 7026, 7, '8/1/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (40, 2, 40, 5321, 1, '1/12/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (18, 3, 74, 8994, 10, '6/3/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (81, 3, 57, 1415, 7, '1/18/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (86, 5, 19, 5343, 18, '7/3/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (62, 4, 49, 8085, 13, '8/23/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (97, 5, 16, 1187, 20, '11/20/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (19, 2, 76, 5786, 1, '11/1/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (82, 4, 53, 51, 7, '12/28/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (54, 1, 88, 7916, 8, '12/13/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (85, 2, 78, 7945, 18, '7/28/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (17, 3, 3, 7689, 5, '5/17/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (44, 2, 65, 5191, 4, '12/2/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (65, 1, 88, 8461, 7, '5/31/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (67, 4, 2, 3373, 9, '12/21/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (80, 4, 49, 9790, 20, '3/25/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (26, 5, 70, 6710, 13, '12/22/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (81, 1, 66, 2322, 11, '2/4/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (48, 4, 15, 5311, 7, '5/4/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (10, 5, 47, 5077, 18, '12/4/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (90, 1, 16, 6593, 16, '12/24/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (21, 5, 38, 406, 1, '12/13/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (57, 5, 25, 4728, 8, '4/23/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (41, 5, 66, 6188, 13, '6/5/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (77, 1, 97, 8897, 15, '3/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (25, 1, 26, 5197, 2, '10/13/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (66, 4, 59, 3899, 11, '10/8/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (35, 1, 9, 599, 16, '3/25/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (86, 4, 96, 9893, 9, '11/24/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (31, 3, 70, 9328, 2, '4/21/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (51, 5, 92, 6097, 4, '5/27/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (19, 3, 20, 1825, 2, '8/1/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (99, 2, 19, 7949, 9, '12/3/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (43, 3, 38, 6622, 20, '7/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (77, 4, 66, 1768, 11, '10/16/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (55, 5, 80, 1151, 11, '12/18/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (44, 3, 61, 3058, 11, '7/12/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (68, 2, 57, 6142, 5, '12/20/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (53, 2, 45, 1222, 20, '2/26/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (27, 3, 19, 6923, 18, '4/14/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (33, 2, 75, 743, 20, '6/13/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (82, 3, 43, 7683, 14, '5/25/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (32, 3, 73, 9178, 9, '10/8/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (63, 3, 33, 6818, 11, '12/15/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (8, 1, 41, 4491, 18, '4/15/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (44, 1, 25, 8969, 9, '11/28/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (1, 2, 68, 1523, 7, '5/14/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (7, 2, 14, 9273, 13, '3/8/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (38, 1, 80, 6557, 12, '2/20/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (84, 2, 36, 5569, 15, '4/20/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (62, 4, 71, 9167, 4, '9/24/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (76, 4, 61, 8794, 2, '8/24/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (90, 5, 44, 4683, 19, '9/13/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (98, 4, 34, 8968, 18, '8/12/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (90, 3, 17, 283, 12, '6/10/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (76, 3, 74, 1242, 2, '2/3/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (60, 3, 96, 9464, 9, '6/4/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (25, 2, 22, 2163, 12, '10/21/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (43, 1, 61, 6457, 14, '3/3/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (8, 1, 26, 138, 4, '1/30/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (46, 3, 5, 613, 14, '8/6/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (82, 1, 25, 5060, 9, '7/29/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (25, 5, 17, 8875, 20, '9/17/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (22, 4, 33, 4651, 20, '3/20/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 3, 75, 6336, 9, '8/9/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (98, 3, 100, 672, 20, '5/22/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (10, 3, 92, 7870, 16, '11/30/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (34, 1, 89, 6435, 11, '9/28/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (44, 4, 72, 7795, 6, '1/24/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (52, 4, 44, 2606, 13, '4/26/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (9, 5, 21, 7473, 16, '1/10/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (45, 4, 76, 7942, 7, '3/19/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (95, 2, 56, 7944, 15, '12/5/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (12, 5, 77, 8038, 12, '3/8/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (10, 2, 67, 9918, 16, '5/8/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (51, 2, 17, 1529, 9, '9/6/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (85, 1, 30, 9424, 1, '11/12/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (22, 1, 5, 7897, 8, '9/5/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (94, 5, 34, 8748, 9, '9/20/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (13, 2, 87, 3543, 7, '8/28/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (46, 3, 5, 1955, 5, '8/6/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (80, 2, 5, 5049, 13, '11/19/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (97, 5, 17, 4848, 9, '10/13/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (30, 5, 33, 8104, 14, '1/31/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (28, 5, 1, 7560, 17, '8/13/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (8, 5, 31, 5370, 1, '2/6/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (38, 3, 77, 532, 12, '4/20/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (21, 5, 60, 639, 14, '1/29/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (97, 1, 8, 5094, 8, '9/7/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (94, 4, 42, 2591, 15, '3/4/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (35, 4, 21, 7608, 12, '7/11/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (32, 3, 16, 7664, 11, '11/20/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (31, 5, 8, 505, 11, '5/11/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (90, 2, 30, 7779, 13, '12/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (22, 3, 50, 3702, 12, '9/17/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (19, 3, 5, 8255, 3, '10/27/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (79, 3, 3, 5761, 12, '6/6/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (57, 2, 21, 8269, 7, '5/13/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (76, 2, 86, 5264, 5, '8/6/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (66, 2, 54, 6838, 1, '8/26/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (13, 2, 59, 1237, 2, '6/17/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (43, 5, 97, 9670, 9, '1/4/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (30, 5, 23, 6154, 1, '5/6/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (80, 3, 61, 3078, 16, '7/18/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (7, 3, 37, 958, 17, '1/21/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (92, 3, 27, 4197, 5, '5/26/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (39, 3, 45, 2687, 9, '5/19/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (19, 5, 21, 3466, 20, '12/2/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (59, 2, 13, 9107, 13, '3/18/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (5, 4, 42, 2951, 17, '9/29/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (100, 5, 32, 315, 15, '9/30/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (97, 4, 79, 7610, 14, '10/19/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (37, 2, 54, 7200, 20, '4/13/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (44, 2, 31, 4480, 8, '7/13/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (31, 5, 75, 7210, 1, '6/17/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (76, 2, 58, 8411, 12, '7/27/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (43, 3, 7, 927, 10, '7/6/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (68, 4, 91, 5449, 7, '7/10/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (2, 5, 53, 5113, 10, '1/29/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (83, 3, 68, 7750, 20, '6/17/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (47, 2, 33, 9418, 7, '2/8/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (19, 5, 82, 5941, 19, '2/14/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (66, 2, 31, 4953, 6, '8/16/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (53, 3, 27, 930, 15, '6/16/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (70, 4, 84, 2797, 5, '12/4/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (57, 2, 91, 8698, 15, '8/22/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (81, 1, 40, 8888, 20, '8/20/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (68, 1, 39, 9666, 19, '9/1/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (29, 1, 94, 1085, 12, '4/23/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (73, 3, 93, 4582, 1, '1/22/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (49, 5, 95, 132, 16, '9/1/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (23, 4, 42, 629, 5, '5/15/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (92, 1, 40, 2746, 17, '11/30/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 5, 31, 6471, 12, '12/7/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (40, 4, 61, 5440, 16, '4/10/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (9, 1, 49, 8273, 9, '10/15/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (49, 2, 9, 8403, 12, '11/4/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (25, 4, 18, 829, 13, '10/20/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (41, 2, 75, 9446, 11, '10/13/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (91, 4, 63, 1680, 2, '10/31/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (10, 4, 10, 2071, 15, '4/8/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (67, 1, 34, 5648, 6, '10/18/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (4, 2, 89, 4540, 18, '3/24/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (16, 2, 79, 3317, 8, '7/29/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (47, 5, 58, 8724, 8, '8/31/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (59, 1, 61, 6062, 3, '3/31/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (27, 1, 93, 2446, 6, '4/29/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (26, 1, 3, 1839, 18, '1/3/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (54, 1, 67, 3480, 7, '6/21/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (11, 1, 97, 2268, 8, '12/28/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (40, 3, 54, 4791, 9, '1/17/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (52, 5, 28, 1699, 7, '1/29/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (84, 2, 23, 2514, 13, '3/22/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (12, 2, 93, 5777, 14, '6/27/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (49, 4, 4, 1582, 12, '11/8/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (40, 1, 17, 6181, 14, '5/3/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (24, 5, 75, 1934, 7, '10/22/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (2, 1, 30, 3195, 13, '2/14/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (96, 5, 87, 4931, 15, '7/6/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (62, 5, 35, 2824, 17, '1/18/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (42, 2, 7, 1717, 4, '12/29/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (2, 5, 77, 8047, 8, '11/27/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (98, 4, 57, 2559, 16, '10/30/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (3, 3, 62, 1419, 11, '1/10/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (52, 5, 64, 6010, 6, '11/16/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (76, 5, 68, 3305, 3, '10/8/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (30, 1, 38, 3952, 3, '10/22/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (86, 3, 63, 3499, 1, '10/19/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (73, 2, 56, 8603, 9, '3/22/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (58, 4, 78, 1063, 11, '6/30/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (98, 1, 29, 9797, 16, '5/14/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (14, 4, 60, 2689, 16, '11/2/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (92, 4, 52, 8684, 12, '10/15/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (93, 3, 87, 3268, 11, '1/25/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (25, 5, 86, 3107, 8, '12/16/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (85, 5, 20, 650, 8, '7/1/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (100, 5, 21, 5217, 7, '6/28/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 5, 53, 7399, 18, '5/6/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (64, 4, 43, 7948, 9, '4/12/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (3, 2, 82, 7515, 14, '4/23/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (55, 4, 78, 8478, 15, '1/18/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (37, 5, 42, 5500, 8, '6/22/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (62, 4, 85, 1377, 9, '1/1/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (36, 5, 82, 9182, 16, '2/3/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 2, 53, 5284, 12, '2/9/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (62, 4, 18, 3469, 9, '8/24/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (16, 3, 66, 289, 4, '5/31/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (6, 5, 53, 8656, 19, '12/26/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (41, 2, 57, 7563, 4, '7/2/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (71, 4, 26, 917, 4, '7/17/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (3, 2, 39, 1356, 12, '7/28/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (12, 2, 20, 3935, 9, '3/31/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (51, 4, 53, 8337, 16, '10/26/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (12, 5, 42, 6431, 7, '5/28/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (20, 3, 25, 8381, 4, '12/3/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (79, 1, 67, 622, 12, '5/14/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (54, 3, 70, 5945, 11, '12/4/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (1, 2, 30, 6934, 19, '1/4/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (56, 4, 77, 6774, 5, '9/10/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (10, 4, 83, 7534, 20, '7/6/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (71, 4, 20, 3983, 20, '8/12/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (92, 1, 20, 988, 19, '11/28/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (81, 3, 9, 6196, 19, '1/11/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (4, 2, 67, 844, 16, '10/18/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (90, 3, 17, 1975, 7, '12/9/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (75, 5, 29, 7987, 8, '3/27/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (93, 3, 53, 8773, 9, '8/24/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (37, 3, 70, 83, 19, '9/14/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (13, 2, 25, 7182, 15, '9/13/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (14, 2, 93, 7565, 8, '2/14/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (95, 4, 53, 1695, 15, '12/18/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (23, 1, 8, 7341, 2, '2/2/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (56, 4, 94, 2297, 8, '12/29/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (85, 5, 66, 7425, 4, '11/17/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (38, 1, 44, 5989, 3, '10/14/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (50, 4, 40, 6975, 6, '7/8/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (27, 4, 76, 818, 18, '5/30/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (2, 1, 81, 7549, 16, '7/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (67, 3, 69, 8889, 7, '5/20/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (12, 4, 69, 5897, 16, '5/18/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (89, 1, 99, 3913, 3, '1/20/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (69, 2, 92, 915, 7, '4/28/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (94, 4, 70, 6416, 15, '7/20/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (85, 4, 10, 544, 17, '12/24/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (2, 2, 13, 9405, 17, '5/17/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (33, 4, 24, 5076, 1, '8/17/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (60, 4, 88, 664, 15, '12/26/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (75, 1, 58, 5543, 7, '4/22/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (42, 3, 49, 8951, 15, '3/6/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (65, 4, 9, 7593, 7, '12/4/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (82, 5, 86, 4454, 12, '10/28/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (81, 2, 11, 8745, 20, '7/21/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (46, 5, 65, 4999, 1, '3/21/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (63, 3, 97, 5998, 12, '8/12/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (63, 3, 9, 7458, 9, '8/31/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (76, 3, 26, 2417, 17, '3/11/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (37, 1, 41, 5366, 5, '5/26/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (15, 3, 80, 9252, 13, '12/2/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (57, 3, 11, 9187, 17, '9/21/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (49, 4, 63, 8973, 8, '2/18/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (54, 1, 74, 7463, 17, '11/7/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (91, 2, 29, 6391, 13, '2/24/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (67, 2, 96, 4421, 8, '12/13/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (96, 3, 31, 315, 17, '11/5/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (17, 1, 9, 1357, 5, '1/4/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (48, 5, 80, 8021, 8, '6/7/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (85, 3, 97, 1877, 2, '5/20/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (47, 1, 23, 9680, 8, '6/16/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (86, 1, 77, 9679, 5, '6/29/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (90, 3, 91, 9585, 17, '8/11/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (89, 1, 1, 4579, 20, '2/11/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (81, 2, 67, 3156, 8, '4/5/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (49, 3, 42, 1322, 17, '1/7/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (73, 3, 75, 4675, 3, '2/11/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (67, 2, 60, 6330, 11, '8/31/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (44, 3, 47, 1013, 1, '12/22/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (48, 3, 82, 2370, 10, '2/9/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (28, 4, 80, 816, 20, '8/13/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (77, 5, 99, 2221, 5, '11/29/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (44, 1, 32, 1711, 5, '3/25/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (26, 2, 92, 9777, 3, '8/26/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (82, 3, 77, 5235, 16, '9/17/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (67, 4, 50, 7663, 20, '9/3/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (83, 3, 41, 4906, 16, '9/13/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (47, 3, 61, 8917, 14, '9/1/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (19, 5, 76, 6384, 20, '5/8/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (2, 5, 22, 9947, 19, '2/28/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (90, 3, 75, 7306, 12, '6/21/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (34, 4, 95, 9181, 19, '7/9/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (69, 1, 88, 6183, 8, '3/5/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 1, 29, 9352, 3, '6/15/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (68, 5, 18, 3590, 5, '11/17/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (100, 4, 23, 6661, 11, '11/27/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (4, 4, 22, 5960, 5, '1/15/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (20, 5, 78, 959, 11, '11/10/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (70, 4, 88, 9105, 16, '10/15/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (10, 1, 17, 9487, 4, '10/18/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (73, 5, 71, 1382, 3, '12/27/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (31, 1, 95, 505, 1, '11/8/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (72, 4, 97, 380, 18, '1/30/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (19, 4, 25, 8957, 18, '12/24/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (64, 1, 94, 2042, 18, '4/23/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (60, 1, 44, 4517, 20, '11/28/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (87, 4, 92, 1950, 14, '9/10/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (33, 2, 35, 1084, 7, '10/14/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (22, 2, 92, 7604, 15, '12/2/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (97, 3, 30, 5373, 15, '7/3/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (53, 1, 34, 3264, 18, '6/13/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (62, 3, 66, 649, 9, '10/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (55, 5, 1, 541, 13, '9/17/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (32, 1, 64, 6406, 17, '4/27/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (78, 2, 80, 2209, 1, '9/12/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (9, 5, 89, 4452, 10, '5/28/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (94, 4, 68, 2724, 12, '6/30/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (1, 2, 57, 1499, 3, '6/8/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (97, 3, 50, 842, 18, '5/21/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (24, 2, 70, 3255, 20, '7/13/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (36, 5, 69, 5362, 13, '5/21/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (45, 5, 89, 2358, 17, '12/23/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (60, 4, 71, 3917, 20, '10/24/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (34, 1, 41, 9528, 9, '4/9/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (37, 5, 65, 9982, 1, '3/8/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (40, 5, 64, 6258, 11, '7/8/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (41, 2, 29, 9063, 19, '6/28/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (22, 5, 10, 6031, 16, '12/24/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (31, 1, 18, 1616, 18, '4/26/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (19, 3, 77, 4640, 3, '5/26/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (42, 3, 1, 8474, 6, '4/19/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (83, 4, 36, 4327, 15, '7/14/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (86, 1, 22, 6827, 20, '12/27/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (1, 2, 90, 8187, 11, '7/9/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (77, 2, 5, 959, 8, '7/25/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (48, 1, 76, 325, 7, '6/12/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (11, 1, 77, 2281, 2, '12/3/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (39, 5, 41, 9120, 5, '3/8/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (7, 4, 87, 202, 5, '2/9/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (100, 2, 67, 9125, 11, '7/21/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (12, 5, 64, 7004, 3, '8/24/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (54, 5, 38, 4014, 17, '6/18/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (77, 1, 93, 6155, 18, '12/27/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (45, 4, 13, 891, 7, '2/17/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (96, 1, 84, 2870, 9, '9/1/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (58, 3, 43, 2472, 10, '4/13/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (55, 3, 46, 7053, 12, '10/16/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (43, 1, 65, 7369, 14, '9/8/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (23, 5, 11, 6410, 20, '9/24/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (51, 5, 5, 4810, 15, '11/5/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (40, 4, 57, 985, 18, '7/22/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (12, 2, 69, 9182, 1, '4/17/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (8, 3, 50, 642, 6, '9/24/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (27, 4, 29, 2380, 3, '8/17/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (82, 3, 68, 2536, 4, '1/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (72, 1, 95, 8499, 2, '3/18/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (30, 2, 13, 2188, 17, '1/15/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (14, 5, 87, 8536, 9, '3/14/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (88, 5, 40, 6416, 11, '6/9/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (69, 1, 18, 8330, 4, '4/9/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (62, 3, 100, 9621, 11, '3/22/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (86, 5, 77, 3720, 5, '10/23/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (99, 1, 55, 9700, 7, '6/16/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (21, 5, 61, 9907, 18, '3/8/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 3, 56, 915, 20, '10/14/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (73, 3, 82, 3720, 7, '8/13/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (21, 5, 29, 275, 14, '8/16/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (67, 2, 15, 1865, 15, '12/9/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (36, 2, 96, 4723, 15, '11/11/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (15, 3, 7, 6077, 12, '5/15/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (32, 2, 18, 987, 8, '10/25/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (71, 3, 48, 9745, 7, '5/23/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (63, 4, 18, 6886, 5, '9/12/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (24, 2, 99, 6712, 10, '5/9/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (76, 4, 100, 3557, 6, '2/17/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (39, 3, 92, 5677, 5, '3/4/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (29, 2, 66, 1522, 16, '12/11/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (92, 3, 78, 7464, 9, '5/4/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (97, 1, 82, 1436, 14, '9/8/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (46, 5, 88, 6078, 6, '6/5/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (80, 5, 13, 1867, 20, '6/1/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (61, 3, 9, 7627, 12, '9/17/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (23, 2, 37, 9515, 16, '6/15/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (59, 5, 76, 1664, 6, '4/27/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (84, 1, 62, 5546, 20, '5/6/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (11, 2, 15, 420, 5, '7/3/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (70, 5, 30, 7995, 15, '7/24/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (29, 1, 70, 5328, 13, '9/13/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (88, 4, 34, 9888, 12, '5/11/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (89, 2, 81, 3337, 6, '7/30/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (66, 4, 22, 4078, 17, '6/11/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (76, 1, 59, 9439, 19, '11/27/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (23, 4, 55, 3861, 4, '3/28/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (86, 2, 91, 4734, 13, '8/25/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (56, 1, 34, 9581, 10, '1/10/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (11, 1, 53, 1976, 8, '5/31/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (11, 4, 3, 1346, 1, '7/7/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (89, 1, 13, 541, 2, '1/8/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (89, 1, 30, 3414, 4, '3/14/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (60, 4, 84, 2832, 12, '2/26/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (88, 3, 81, 6069, 2, '11/14/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (80, 2, 83, 2671, 2, '1/16/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (46, 3, 66, 6422, 5, '6/12/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (98, 4, 98, 6503, 4, '4/27/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (31, 1, 83, 7948, 13, '10/28/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (34, 2, 75, 1160, 9, '6/29/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (81, 4, 62, 1128, 2, '9/5/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (55, 3, 95, 3491, 16, '5/15/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (20, 4, 72, 8834, 15, '11/2/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (96, 3, 87, 4560, 15, '9/5/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (52, 3, 16, 519, 15, '2/10/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (79, 3, 85, 4748, 17, '4/25/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (16, 1, 33, 1271, 19, '8/29/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (8, 1, 21, 1139, 14, '12/31/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (16, 1, 77, 7524, 1, '12/10/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (35, 1, 30, 1579, 15, '12/10/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (53, 4, 88, 918, 5, '6/9/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (7, 2, 76, 7341, 9, '2/11/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (27, 2, 60, 5403, 14, '2/21/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (93, 4, 43, 7953, 7, '5/31/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 5, 32, 4961, 17, '7/24/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (34, 2, 51, 8079, 6, '3/19/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (29, 2, 87, 1737, 2, '6/2/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (21, 1, 16, 700, 6, '11/7/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (62, 4, 65, 485, 15, '6/22/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (45, 2, 2, 2530, 15, '2/22/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (16, 1, 75, 7198, 20, '6/30/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (92, 2, 12, 6277, 17, '5/20/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (75, 3, 16, 9883, 3, '5/19/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (90, 2, 73, 4150, 10, '6/13/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (42, 4, 43, 3903, 19, '4/13/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (97, 4, 11, 6629, 15, '2/23/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (28, 4, 18, 1641, 10, '1/24/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (22, 1, 4, 512, 9, '12/24/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (39, 1, 51, 1275, 20, '4/8/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (26, 4, 35, 870, 12, '10/10/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (98, 1, 38, 6176, 5, '2/1/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (32, 1, 48, 2875, 4, '8/26/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (70, 3, 40, 1884, 3, '8/23/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (33, 5, 39, 3131, 12, '11/16/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (24, 1, 81, 9007, 8, '12/13/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (63, 2, 6, 1265, 5, '4/17/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (69, 4, 71, 2148, 9, '6/2/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (48, 5, 40, 3840, 9, '7/14/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (41, 3, 28, 6654, 7, '10/19/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (64, 5, 46, 4974, 2, '3/22/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (31, 3, 18, 2700, 1, '4/5/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (65, 4, 86, 277, 6, '8/16/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (73, 4, 59, 3297, 14, '2/3/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (4, 4, 27, 6578, 15, '8/28/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (7, 1, 33, 12, 10, '8/14/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (69, 4, 62, 9758, 5, '9/23/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (36, 3, 5, 6848, 1, '4/3/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 2, 62, 41, 14, '3/21/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (81, 3, 59, 1887, 18, '1/11/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (26, 1, 97, 2791, 7, '5/8/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (38, 3, 7, 8273, 16, '5/16/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (15, 3, 19, 3031, 1, '3/14/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (15, 1, 72, 3908, 16, '3/19/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (38, 5, 66, 8303, 16, '3/23/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (96, 5, 27, 1950, 8, '2/5/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (72, 4, 53, 1369, 4, '2/26/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (43, 3, 98, 7673, 9, '1/21/2025');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (66, 1, 58, 1012, 13, '11/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (60, 4, 22, 8973, 3, '8/13/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (97, 5, 51, 6239, 10, '11/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (1, 3, 51, 4302, 17, '11/15/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (43, 5, 99, 5213, 3, '7/13/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (96, 3, 37, 3148, 11, '5/13/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (78, 1, 40, 9763, 4, '5/6/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (65, 5, 59, 158, 10, '12/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (74, 1, 86, 1410, 4, '3/18/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (99, 5, 47, 7314, 20, '12/8/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (94, 3, 80, 7436, 18, '11/21/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (75, 3, 50, 9234, 5, '10/9/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (27, 4, 80, 1858, 15, '6/10/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (17, 2, 95, 9570, 3, '5/11/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (10, 5, 13, 3959, 4, '7/23/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (8, 2, 71, 8026, 10, '4/3/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (55, 2, 7, 8371, 15, '8/21/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (56, 4, 23, 6097, 7, '10/10/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (15, 4, 45, 8059, 8, '5/29/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (70, 4, 75, 1001, 4, '1/16/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (89, 4, 38, 9353, 10, '1/15/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (98, 2, 25, 5050, 4, '9/27/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (6, 4, 40, 5963, 16, '9/17/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (31, 5, 18, 5202, 20, '6/5/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (44, 1, 99, 8841, 1, '8/17/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (33, 3, 63, 6628, 13, '5/8/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (30, 1, 88, 1637, 11, '7/22/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (29, 3, 43, 6578, 15, '6/30/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (60, 2, 36, 8528, 17, '1/19/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (11, 5, 68, 5060, 20, '3/24/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (99, 4, 4, 2184, 12, '6/2/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (54, 1, 16, 2039, 16, '6/18/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (53, 3, 54, 1260, 6, '9/17/2023');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (77, 5, 24, 9042, 8, '8/22/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (16, 3, 68, 6640, 20, '1/2/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (61, 4, 26, 7625, 3, '11/25/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (9, 5, 16, 2991, 5, '8/8/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (37, 3, 9, 6810, 5, '11/28/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (71, 3, 48, 1138, 6, '6/15/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (54, 1, 46, 2282, 9, '5/7/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (91, 1, 62, 2987, 14, '8/31/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (4, 3, 48, 3056, 17, '7/26/2021');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (44, 3, 47, 8270, 20, '3/31/2022');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (11, 5, 53, 7880, 5, '6/20/2024');
INSERT INTO DELIVERABLES (action_id, plan_id, canton_id, kpi_value, kpi_type, post_time) VALUES (99, 1, 98, 2433, 16, '2/19/2023');
