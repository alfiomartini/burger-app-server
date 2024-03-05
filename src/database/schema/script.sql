-- DROP DATABASE IF EXISTS burger_app ;
CREATE DATABASE IF NOT EXISTS burger_app ;
USE burger_app;

-- Tables
CREATE TABLE IF NOT exists ingredient(
  ing_id INT AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  quantity INT NOT NULL,
  description VARCHAR(150),
  PRIMARY KEY (ing_id)
);



CREATE TABLE IF NOT EXISTS burger(
  burger_id INT AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  description VARCHAR(250) NOT NULL,
  PRIMARY KEY (burger_id)
);

CREATE TABLE IF NOT EXISTS requires(
  ing_id INT,
  burger_id INT,
  ing_quantity INT NOT NULL,
  PRIMARY KEY(ing_id, burger_id),
  FOREIGN KEY(ing_id) REFERENCES ingredient(ing_id) ON DELETE CASCADE,
  FOREIGN KEY(burger_id) REFERENCES burger(burger_id) ON DELETE CASCADE
);

-- this next table only makes sense while we don't include 'Users' in the model

CREATE TABLE IF NOT EXISTS purchase(
  purchase_id INT AUTO_INCREMENT,
  burger_id INT,
  customer_name VARCHAR(20) NOT NULL,
  datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (purchase_id),
  FOREIGN KEY(burger_id) REFERENCES burger(burger_id) ON DELETE CASCADE
);

-- insertion of data
 
INSERT IGNORE INTO ingredient 
   (name, quantity, description)
   VALUES
      ('pickles', 300, 'grams'), -- 1
      ('onion', 500, 'grams'),  -- 2
      ('bun', 30, 'units'),  -- 3
      ('tomato', 500, 'grams'), -- 4
      ('ketchup', 500, 'grams'),  -- 5
      ('lettuce', 500, 'grams'),  -- 6
      ('egg', 20, 'units'),  -- 7
      ('beef', '500', 'grams'),  -- 8
      ('cheese', 250, 'grams'),  -- 9
      ('chicken', 500, 'grams'),  -- 10
      ('fish', 500, 'grams'), -- 11
      ('fish sauce', 200, 'ml'), -- 12
      ('mustard', 300, 'grams'), -- 13
      ('mayo', 300, 'grams'); -- 14


INSERT IGNORE INTO burger 
   (name, description)
VALUES
   ('standard burger', 'a mouth watering honest beef burger'), -- 1
   ('chicken burger', 'a chicken sandwich consisting of boneless, skinless chicken breast, served between slices of bread'), -- 2
   ('fish burger', 'a homemade fish burger with a crunchy crumb, healthy and packed with flavour'); -- 3


INSERT IGNORE INTO requires 
   (ing_id, burger_id, ing_quantity) -- standard burger
VALUES
   (8,1,150), -- beef
   (9,1,20),  -- cheese
   (13,1,20), -- mustard
   (1,1,30),  -- pickles
   (6,1,20),  -- lettuce
   (3,1,2);   -- bun


 
INSERT IGNORE INTO requires 
   (ing_id, burger_id, ing_quantity) -- chicken burger
VALUES
   (3,2,2), -- bun
   (10,2,150),  -- chicken
   (6,2,20), -- lettuce
   (14,2,20),  -- mayo
   (9,2,20),  -- cheese
   (4,2,40);   -- tomato


 
INSERT IGNORE INTO requires 
   (ing_id, burger_id, ing_quantity) -- fish burger
VALUES
   (3,3,2), -- bun
   (11,3,150),  -- fish
   (6,3,20), -- lettuce
   (14,3,30),  -- mayo
   (4,3,20),  -- tomato
   (12,3,50);   -- fish sauce


 
INSERT IGNORE INTO purchase
   (burger_id, customer_name)
VALUES
   (1, 'Mary Williams'),
   (2, 'John Taylor'),
   (3, 'Simon Miller'),
   (1, 'Suzy Jones');