export interface Ingredient {
  id: string;
  name: string;
  quantity: number;
  description: string;
}

export interface WeakIngredient {
  id: string;
  name: string;
  quantity: number;
  description: string;
}

export interface DBIngredient {
  ing_id: number;
  name: string;
  quantity: number;
  description: string;
}
