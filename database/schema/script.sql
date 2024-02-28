DROP DATABASE burger_app;
CREATE DATABASE burger_app;

- Tables
CREATE TABLE ingredient(
  ing_id INT AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  quantity INT NOT NULL,
  description VARCHAR(150),
  PRIMARY KEY (ing_id)
);



CREATE TABLE burger(
  burger_id INT AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  description VARCHAR(250) NOT NULL,
  PRIMARY KEY (burger_id)
);

CREATE TABLE requires(
  ing_id INT,
  burger_id INT,
  ing_quantity INT NOT NULL,
  PRIMARY KEY(ing_id, burger_id),
  FOREIGN KEY(ing_id) REFERENCES ingredient(ing_id) ON DELETE CASCADE,
  FOREIGN KEY(burger_id) REFERENCES burger(burger_id) ON DELETE CASCADE
);

-- this next table only makes sense if while
-- we don't include 'Users' in the model

CREATE TABLE purchase(
  purchase_id INT AUTO_INCREMENT,
  burger_id INT,
  customer_name VARCHAR(20) NOT NULL,
  datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (purchase_id),
  FOREIGN KEY(burger_id) REFERENCES burger(burger_id) ON DELETE CASCADE
);

-- insertion of data
INSERT INTO ingredient
  (name, quantity, description)
VALUES
  ('pickles', 300, 'grams'),
  ('onion', 500, 'grams'),
  ('bun', 30, 'units'),
  ('tomato', 500, 'grams'),
  ('ketchup', 500, 'grams'),
  ('lettuce', 500, 'grams'),
  ('egg', 20, 'units'),
  ('beef', '500', 'grams'),
  ('cheese', 250, 'grams'),
  ('chicken', 500, 'grams'),
  ('fish', 500, 'grams'),
  ('fish sauce', 200, 'milliliters'),
  ('mustard', 300, 'grams'),
  ('mayo', 300, 'grams');

  INSERT INTO burger 
     (name, description)
  VALUES
     ('standard burger', 'a mouth watering honest beef burger'),
     ('chicken burger', 'a chicken sandwich consisting of boneless, skinless chicken breast, served between slices of bread'),
     ('fish burger', 'a homemade fish burger with a crunchy crumb, healthy and packed with flavour');

INSERT INTO requires 
   (ing_id, burger_id, ing_quantity) -- standard burger
VALUES
   (8,7,150), -- beef
   (9,7,20),  -- cheese
   (16,7,20), -- mustard
   (1,7,30),  -- pickles
   (6,7,20),  -- lettuce
   (3,7,2);   -- bun


INSERT INTO requires 
   (ing_id, burger_id, ing_quantity) -- chicken burger
VALUES
   (3,8,2), -- bun
   (10,8,150),  -- chicken
   (6,8,20), -- lettuce
   (17,8,20),  -- mayo
   (9,8,20),  -- cheese
   (4,8,40);   -- tomato


INSERT INTO requires 
   (ing_id, burger_id, ing_quantity) -- fish burger
VALUES
   (3,9,2), -- bun
   (11,9,150),  -- fish
   (6,9,20), -- lettuce
   (17,9,30),  -- mayo
   (4,9,20),  -- tomato
   (15,9,50);   -- fish sauce

INSERT INTO purchase
    (burger_id, customer_name)
VALUES
    (7, 'Mary Williams'),
    (8, 'John Taylor'),
    (9, 'Simon Miller'),
    (7, 'Suzy Jones');