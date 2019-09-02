#Crea una BDD si no existe
CREATE database if not exists platzi_operation;

#Siempre crear un ID
CREATE TABLE if not exists books(
    book_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    author_id INTEGER UNSIGNED,
    title VARCHAR(100) NOT NULL,
    year INTEGER UNSIGNED NOT NULL DEFAULT 1900,
    language VARCHAR(2) NOT NULL DEFAULT'es' COMMENT 'iso 639-1 language',
    cover_url VARCHAR(500),
    price DOUBLE NOT NULL DEFAULT 10.0,
    selleable TINYINT(1) DEFAULT 1,
    copies INTEGER NOT NULL DEFAULT 1,
    descrition TEXT
);

CREATE TABLE IF NOT EXISTS authors(

author_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
nationality VARCHAR(3)

);

CREATE TABLE IF NOT EXISTS clients(

    client_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name`VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    birthdate DATETIME,
    gender ENUM('M', 'F', 'ND'),
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
     ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS operations(

    operation_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    book_id INTEGER UNSIGNED NOT NULL,
    client_id INTEGER UNSIGNED NOT NULL,
    `type` ENUM('Sold','Rented','Returned') NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    finished TINYINT(1) NOT NULL
    
);

INSERT INTO authors(author_id, name, nationality)
VALUES(NULL, 'Juan Rulfo', 'MEX');

INSERT INTO authors(name, nationality)
VALUES('Grabriel Garcia Marquez', 'COL');

INSERT INTO authors()
VALUES(NULL, 'Juan Gabriel Vasquez', 'COL');

INSERT INTO authors (name, nationality)
VALUES ('Julio Cortazar','ARG'),
       ('Isabel Allende','CHI'), 
       ('Octavio Paz','MEX'),
       ('Juan Carlos Onetti','URU');

SELECT name, email, YEAR(NOW()) - YEAR(birthdate) AS Edad, gender
FROM clients
WHERE gender = 'F'
    AND name LIKE '%Lop%';

SELECT count(*) FROM books

SELECT b.book_id, a.name, b.title
FROM books as b
join authors as a 
    on a.author_id = b.author_id
where a.author_id between 1 and 5;


SELECT c.name, b.title, a.name, t.type
from operations as t
join books as b 
    on t.book_id = b.book_id
join clients as c
    on t.client_id = c.client_id
join authors as a
    on b.author_id = a.author_id
where c.gender = 'M'
    and t.type IN ('sell', 'lend')
order by a.author_id;


SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id)
FROM authors as a
LEFT JOIN books as b
    ON b.author_id = a.author_id
WHERE a.author_id between 1 and 5
GROUP BY a.author_id
ORDER BY a.author_id;


SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id) as 'cantidad de libros'
FROM authors as a
LEFT JOIN books as b
    ON b.author_id = a.author_id
WHERE a.author_id
GROUP BY a.author_id
ORDER BY a.author_id;

SELECT DISTINCT nationality FROM authors;

SELECT count(DISTINCT nationality) FROM authors;

SELECT nationality, COUNT(author_id) as c_authors
FROM authors
GROUP BY nationality
ORDER BY c_authors DESC;


SELECT nationality, COUNT(author_id) as c_authors
FROM authors
WHERE nationality IS NOT NULL
GROUP BY nationality
ORDER BY c_authors DESC;

SELECT AVG(price)
FROM books;

SELECT MAX(price), MIN(price)
FROM books;

SELECT count(book_id),
    sum(if(`year` < 1950, 1, 0)) as `<1950`,
    sum(if(`year` < 1950, 0, 1)) as `>1950`
from books;

SELECT nationality, count(book_id),
    sum(if(`year` < 1950, 1, 0)) as `<1950`,
    sum(if(`year` < 1950, 0, 1)) as `>1950`
from books as b
join authors as a
    on a.author_id = b.author_id
where a.nationality is not NULL
GROUP BY nationality;