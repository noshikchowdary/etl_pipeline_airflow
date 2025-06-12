CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    date_of_birth DATE
);

INSERT INTO users (first_name, last_name, email, date_of_birth) VALUES
('Mahesh', 'Babu', 'mahesh.babu@example.com', '1975-08-09'),
('Prabhas', 'Raju', 'prabhas.raju@example.com', '1979-10-23'),
('Allu', 'Arjun', 'allu.arjun@example.com', '1983-04-08'),
('Jr.', 'NTR', 'jrntr@example.com', '1983-05-20'),
('Ram', 'Charan', 'ram.charan@example.com', '1985-03-27'),
('Pawan', 'Kalyan', 'pawan.kalyan@example.com', '1971-09-02'),
('Chiranjeevi', 'Konidela', 'chiranjeevi.k@example.com', '1955-08-22'),
('Venkatesh', 'Daggubati', 'venkatesh.d@example.com', '1960-12-13'),
('Ravi', 'Teja', 'ravi.teja@example.com', '1968-01-26'),
('Naga', 'Chaitanya', 'naga.chaitanya@example.com', '1986-11-23'),
('Varun', 'Tej', 'varun.tej@example.com', '1990-01-19'),
('Rana', 'Daggubati', 'rana.daggubati@example.com', '1984-12-14'),
('Vijay', 'Deverakonda', 'vijay.deverakonda@example.com', '1989-05-09'),
('Siddharth', 'Narayan', 'siddharth.n@example.com', '1979-04-17'),
('R.', 'Madhavan', 'r.madhavan@example.com', '1970-06-01'),
('Nani', 'Kishore', 'nani.kishore@example.com', '1984-02-24'),
('Satyadev', 'Kancharana', 'satyadev.k@example.com', '1989-03-27'),
('Kalyan', 'Ram', 'kalyan.ram@example.com', '1978-06-14'),
('Sharwanand', 'Madhav', 'sharwanand.m@example.com', '1985-03-06'),
('Sai', 'Dharam Tej', 'sai.dharamtej@example.com', '1986-10-15');

CREATE TABLE films (
    film_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    price DECIMAL(5,2),
    rating VARCHAR(10),
    user_rating DECIMAL(2,1) CHECK (user_rating >= 1 AND user_rating <= 5)
);

INSERT INTO films (title, release_date, price, rating, user_rating) VALUES
('Pokiri', '2006-04-28', 12.99, 'U/A', 4.8),
('Baahubali: The Beginning', '2015-07-10', 9.99, 'U/A', 4.9),
('Arya', '2004-12-24', 14.99, 'U', 4.7),
('Temper', '2015-01-09', 11.99, 'U/A', 4.8),
('Gabbar Singh', '2012-05-11', 10.99, 'U/A', 4.6),
('Magadheera', '2009-07-31', 9.99, 'U/A', 4.7),
('Geetha Govindam', '2018-08-15', 8.99, 'U', 4.5),
('Julayi', '2012-07-27', 7.99, 'U/A', 4.4),
('Sye', '2004-09-17', 9.99, 'U', 4.3),
('Eega', '2012-07-06', 12.99, 'U/A', 4.2),
('Leader', '2010-06-18', 13.99, 'U/A', 4.3),
('Kick', '2009-04-17', 11.99, 'U/A', 4.6),
('C/o Kancharapalem', '2018-03-02', 9.99, 'U', 4.8),
('Ghazi', '2017-02-17', 12.99, 'U/A', 4.5),
('Arjun Reddy', '2017-06-21', 10.99, 'A', 4.9),
('Agent Sai Srinivasa Athreya', '2019-02-01', 14.99, 'U', 4.6),
('Bommarillu', '2006-05-12', 9.99, 'U', 4.7),
('Ekkadiki Pothavu Chinnavada', '2016-12-23', 9.99, 'U', 4.8),
('Rangasthalam', '2018-03-30', 10.99, 'U/A', 4.4),
('Kick 2', '2015-06-12', 11.99, 'U/A', 4.5);

CREATE TABLE film_category (
    category_id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES films(film_id),
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO film_category (film_id, category_name) VALUES
(1, 'Action'),
(1, 'Thriller'),
(2, 'Epic'),
(3, 'Romance'),
(3, 'Action'),
(4, 'Action'),
(4, 'Drama'),
(5, 'Action'),
(5, 'Comedy'),
(6, 'Fantasy'),
(6, 'Action'),
(7, 'Romance'),
(7, 'Comedy'),
(8, 'Action'),
(8, 'Comedy'),
(9, 'Sports'),
(9, 'Drama'),
(10, 'Fantasy'),
(10, 'Action'),
(11, 'Political'),
(11, 'Drama'),
(12, 'Action'),
(12, 'Comedy'),
(13, 'Drama'),
(13, 'Romance'),
(14, 'War'),
(14, 'Drama'),
(15, 'Romance'),
(15, 'Drama'),
(16, 'Mystery'),
(16, 'Comedy'),
(17, 'Romance'),
(17, 'Comedy'),
(18, 'Thriller'),
(18, 'Romance'),
(19, 'Drama'),
(19, 'Action'),
(20, 'Action'),
(20, 'Comedy');

CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    actor_name VARCHAR(255) NOT NULL
);

INSERT INTO actors (actor_name) VALUES
('Mahesh Babu'),
('Prabhas'),
('Allu Arjun'),
('Jr. NTR'),
('Ram Charan'),
('Pawan Kalyan'),
('Chiranjeevi'),
('Venkatesh'),
('Ravi Teja'),
('Naga Chaitanya'),
('Varun Tej'),
('Rana Daggubati'),
('Vijay Deverakonda'),
('Siddharth'),
('R. Madhavan'),
('Nani'),
('Satyadev'),
('Kalyan Ram'),
('Sharwanand'),
('Sai Dharam Tej');

CREATE TABLE film_actors (
    film_id INTEGER REFERENCES films(film_id),
    actor_id INTEGER REFERENCES actors(actor_id),
    PRIMARY KEY (film_id, actor_id)
);

INSERT INTO film_actors (film_id, actor_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);
