-- show all the ingredients
select * from ingredients;

-- show all the ingredient and ingredient quantities needed for the Standard Burger (id 7)
select burger_id, ing_id, ing_quantity from requires
where burger_id = 7;

-- show all the ingredient names and quantities needed for the Standard Burger (id 7)
select ingredient.name, ingredient.ing_id, standard_ing.ing_quantity, ingredient.description, standard_ing.burger_id
from ingredient
join 
(select burger_id, ing_id, ing_quantity from requires
where burger_id = 7) as standard_ing
on ingredient.ing_id = standard_ing.ing_id

-- show all the ingredients and its quantities consumed so far with purchases related
-- to the Standard Burger  (id 7)
select s_ing.burger_id, s_ing.name, s_ing.ing_quantity, s_ing.description, s_purchases.purchase_id, s_purchases.customer_name 
from 
  (select ingredient.name, standard_ing.ing_quantity, ingredient.description, standard_ing.burger_id
    from ingredient
  join 
    (select burger_id, ing_id, ing_quantity from requires
      where burger_id = 7
    ) as standard_ing
    on ingredient.ing_id = standard_ing.ing_id
  ) as s_ing 
join  
  (select burger_id, purchase_id, customer_name from purchase
  where burger_id = 7
  ) as s_purchases
on s_ing.burger_id = s_purchases.burger_id;

-- show the sum of all ingredients consumed so far with purchases related
-- to the Standard Burger  (id 7)
select burger_id, name, sum(ing_quantity) from
  (select s_ing.burger_id, s_ing.name, s_ing.ing_quantity, s_ing.description, s_purchases.purchase_id, s_purchases.customer_name 
  from 
    (select ingredient.name, standard_ing.ing_quantity, ingredient.description, standard_ing.burger_id
      from ingredient
    join 
      (select burger_id, ing_id, ing_quantity from requires
        where burger_id = 7
      ) as standard_ing
      on ingredient.ing_id = standard_ing.ing_id
    ) as s_ing 
  join  
    (select burger_id, purchase_id, customer_name from purchase
    where burger_id = 7
    ) as s_purchases
  on s_ing.burger_id = s_purchases.burger_id) as final
  group by name;
 