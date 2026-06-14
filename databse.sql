-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Full DDL Template with Table Creation & Data Insertion
-- =========================================================================
-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;


DROP TABLE IF EXISTS Matches;


DROP TABLE IF EXISTS Users;


CREATE DATABASE Worldcup;


-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
  user_id int PRIMARY KEY,
  full_name varchar(50),
  email varchar(50) UNIQUE,
  role varchar(50) CHECK (role IN ('Football Fan', 'Ticket Manager')),
  phone_number varchar(15)
);


-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
  match_id int PRIMARY KEY,
  fixture varchar(50),
  tournament_category varchar(30),
  base_ticket_price int CHECK (base_ticket_price >= 0),
  match_status varchar(20) CHECK (
    match_status IN ('available', 'selling fast', 'sold out')
  )
);


-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
  booking_id int PRIMARY KEY,
  user_id int,
  match_id int,
  seat_number varchar(30),
  payment_status varchar(30) CHECK (payment_status IN ('confirmed', 'pending')),
  total_cost int CHECK (total_cost >= 0),
  FOREIGN KEY (user_id) REFERENCES Users (user_id),
  FOREIGN KEY (match_id) REFERENCES Matches (match_id)
);


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO
  Users (user_id, full_name, email, role, phone_number)
VALUES
  (
    1,
    'Tanvir Rahman',
    'tanvir@mail.com',
    'Football Fan',
    '+8801711111111'
  ),
  (
    2,
    'Asif Haque',
    'asif@mail.com',
    'Football Fan',
    '+8801722222222'
  ),
  (
    3,
    'Sajjad Rahman',
    'sajjad@mail.com',
    'Ticket Manager',
    '+8801733333333'
  ),
  (
    4,
    'Jannat Ara',
    'jannat@mail.com',
    'Football Fan',
    NULL
  );


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO
  Matches (
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
  )
VALUES
  (
    101,
    'Real Madrid vs Barcelona',
    'Champions League',
    150.00,
    'available'
  ),
  (
    102,
    'Man City vs Liverpool',
    'Premier League',
    120.00,
    'selling fast'
  ),
  (
    103,
    'Bayern Munich vs PSG',
    'Champions League',
    130.00,
    'available'
  ),
  (
    104,
    'AC Milan vs Inter Milan',
    'Serie A',
    90.00,
    'sold out'
  ),
  (
    105,
    'Juventus vs Roma',
    'Serie A',
    80.00,
    'available'
  );


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
INSERT INTO
  Bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
  )
VALUES
  (501, 1, 101, 'A-12', 'confirmed', 150.00),
  (502, 1, 102, 'B-04', 'confirmed', 120.00),
  (503, 2, 101, 'A-13', 'confirmed', 150.00),
  (504, 2, 101, NULL, NULL, 150.00),
  (505, 3, 102, 'C-20', 'pending', 120.00);


--query 1 solution 
SELECT
  *
FROM
  matches
WHERE
  tournament_category = 'Champions League'
  AND match_status = 'available';


--query 2 solution 
SELECT
  user_id,
  full_name,
  email
FROM
  Users
WHERE
  full_name ILIKE 'Tanvir%'
  OR full_name ILIKE '%Haque%';


--query 3
SELECT
  booking_id,
  user_id,
  match_id,
  coalesce(payment_status, 'Action Required') AS systematic_status
FROM
  bookings
WHERE
  payment_status IS NULL;


--query 4
SELECT
  b.booking_id,
  u.full_name,
  m.fixture,
  b.total_cost
FROM
  Bookings b
  INNER JOIN Users u ON b.user_id = u.user_id
  INNER JOIN Matches m ON b.match_id = m.match_id;


--query 5
SELECT
  u.user_id,
  u.full_name,
  b.booking_id
FROM
  Users u
  LEFT JOIN Bookings b ON u.user_id = b.user_id;


--query 6
SELECT
  booking_id,
  match_id,
  total_cost
FROM
  Bookings
WHERE
  total_cost > (
    SELECT
      AVG(total_cost)
    FROM
      Bookings
  );


--query 7
SELECT
  match_id,
  fixture,
  base_ticket_price
FROM
  Matches
ORDER BY
  base_ticket_price DESC
LIMIT
  2
OFFSET
  1;