//
//  main.swift
//
//  Created by Thomas Ciha on 7/29/17.
//  Copyright © 2017 Thomas Ciha. All rights reserved.
//

// This mini project is essentially to create a system for a user to store recipes, keep track of ingredients and discover
// what recipes they can make with the ingredients they currently have.


import Foundation

//========= creating 1st recipe ==========
    //creating the ingredient data structs
let JM_Tequila = ingredient_data(Name: "Tequila", Unit: "part(s)", Amount: 2)
let JM_Triple_Sec = ingredient_data(Name: "Triple Sec", Unit: "part(s)", Amount: 0.5)
let JM_Grand_Marnier = ingredient_data(Name: "Grand Marnier", Unit: "part(s)", Amount: 0.5)
let JM_Agave = ingredient_data(Name: "Agave Syrup", Unit: "part(s)", Amount: 0.5)
var recipe_ingredients = [JM_Tequila,JM_Triple_Sec, JM_Grand_Marnier, JM_Agave]
let Jerrys_Margarita = Recipe(Name: "Jerry's Margarita", Servings: 1, Ingredients: recipe_ingredients)


//========= creating 2nd recipe ==========
let Cheetos = ingredient_data(Name: "Flamin' Hot Cheetos", Unit: "Cup(s)", Amount: 1)
let BreadCrumbs = ingredient_data(Name: "Italaian Style Breadcrumbs", Unit: "Cup(s)", Amount: 0.75)
let Cheese = ingredient_data(Name: "String Cheese", Unit: "Stick(s)", Amount: 6)
let Oil = ingredient_data(Name: "Vegetable Oil", Unit: "Cup(s)", Amount: 2)
let Flour = ingredient_data(Name: "Flour", Unit: "Cup(s)", Amount: 2)
let Eggs = ingredient_data(Name: "Eggs", Unit: "Egg(s)", Amount: 2)
recipe_ingredients = [Cheetos, BreadCrumbs, Cheese, Oil, Flour, Eggs]
let SpicyMozzSticks = Recipe(Name: "Spicy Mozzerela Sticks", Servings: 1, Ingredients: recipe_ingredients)


//========= creating inventory items ==========
var inventory_items = [ingredient_data]()
inventory_items.append(ingredient_data(Name: "Vegetable Oil", Unit: "Tbsp(s)", Amount: 32))
inventory_items.append(ingredient_data(Name: "Flour", Unit: "Cup(s)", Amount: 4))
inventory_items.append(ingredient_data(Name: "Eggs", Unit: "Egg(s)", Amount: 5))
inventory_items.append(ingredient_data(Name: "Flamin' Hot Cheetos", Unit: "Cup(s)", Amount: 10))
inventory_items.append(ingredient_data(Name: "String Cheese", Unit: "Stick(s)", Amount: 12))
inventory_items.append(ingredient_data(Name: "Italaian Style Breadcrumbs", Unit :"Cup(s)", Amount: 10))
inventory_items.append(ingredient_data(Name: "Tequila", Unit: "part(s)", Amount: 12))
inventory_items.append(ingredient_data(Name: "Triple Sec", Unit: "part(s)", Amount: 0.5))
inventory_items.append(ingredient_data(Name: "Grand Marnier", Unit: "part(s)", Amount: 0.5))
inventory_items.append(ingredient_data(Name: "Agave Syrup", Unit: "part(s)", Amount: 0.5))


//========= creating a user ==========
var User1 = User()
User1.Add_Inventory(Inventory: inventory_items)
User1.Add_Recipes(Recipes: [Jerrys_Margarita, SpicyMozzSticks])

User1.print_inventory()
User1.FeasibleRecipes() // both recipes can be made

User1.MakeRecipe(Jerrys_Margarita)
User1.FeasibleRecipes() // can no longer make Jerry's margarita
User1.print_inventory() //proof of inadequate ingredients













