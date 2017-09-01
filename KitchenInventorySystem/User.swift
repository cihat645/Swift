//
//  User.swift
//
//  Created by Thomas Ciha on 7/30/17.
//  Copyright © 2017 Thomas Ciha. All rights reserved.
//

//System: Design a system that allows users to "upload" recipes, access the recipes from a "database" and then figure out what recipes they can make given the ingredients they currently have.


import Foundation

//========= Ingredient data structure =========

struct ingredient_data {
    var Name, Unit : String, Amount : Double
    
}

//need to make the structure 'ingredient_data' conform to the Equatable protocol

extension ingredient_data : Equatable {
    static func == (lhs: ingredient_data, rhs: ingredient_data) -> Bool {
        return
            lhs.Name == rhs.Name
    }
    //note: not accounting for the Unit or the Amount because when using this protocol I just want to see if the inventory contains the ingredient, not that it has the exact same unit and amount.
}

//========= End Ingredient data structure =========



//=========  CONVERSION FUNCTIONS BELOW=========


    func tspAndTbsp(_ value : Double, _ convert_to: String) -> Double { //'to' is indicative of what unit you want to convert to
        //for example, if to = 'tbsp' then we are converting from tsp to tbsp
        return (convert_to == "Tbsp(s)" ? (value / 3) : (value * 3))
    }

    // ===============CUP CONVERSIONS===============(US CUPS)
    func cupAndtbsp(_ value: Double, _ convert_to: String)-> Double {
        return(convert_to == "Tbsp(s)" ? (value * 16) : (value / 16))
    }

    func cupAndoz(_ value: Double, _ convert_to: String)-> Double { //using US fl oz
        return(convert_to == "Oz(s)" ? (value * 8.12) : (value / 8.12))
    }

    func cupAndpint(_ value: Double, _ convert_to: String)-> Double {
        return(convert_to == "Pint(s)" ? (value * 0.507) : (value * 1.97))
    }

    func cupAndquart(_ value: Double, _ convert_to: String)-> Double {
        return(convert_to == "Quart(s)" ? (value * 0.253) : (value * 3.94))
    }

    func cupAndgallon(_ value: Double, _ convert_to: String)-> Double {
        return(convert_to == "Gallon(s)" ? (value * 0.0634) : (value * 15.773))
    }

    // ===============END CUP CONVERSIONS===============

    // ===============OZ CONVERSIONS===============
    //NOTE: we don't have cups and oz conversion function because it was included above in the "cups" section.

    func ozAndgallon(_ value: Double, _ convert_to: String)-> Double { //using US fl oz
        return(convert_to == "Gallon(s)" ? (value * 0.00781) : (value * 128))
    }

    func ozAndquart(_ value: Double, _ convert_to: String)-> Double { //using US fl oz
        return(convert_to == "Quart(s)" ? (value * 0.03125) : (value * 32))
    }

    func ozAndpint(_ value: Double, _ convert_to: String)-> Double { //using US fl oz
        return(convert_to == "Pint(s)" ? (value * 0.0625) : (value * 16))
    }

    func ozAndtbsp(_ value: Double, _ convert_to: String)-> Double {
        return(convert_to == "Tbsp(s)" ? (value * 2) : (value / 2))
    }

    func ozAndtsp(_ value: Double, _ convert_to: String)-> Double {
        return(convert_to == "Tsp(s)" ? (value * 6) : (value / 6))
    }
    // ===============END OZ CONVERSIONS===============


    //========= MANY CONVERSION FUNCTIONS ABOVE=========

//========= Inventory class =========


class Inventory {
    var data = [ingredient_data]() //creating empty array of "ingredient_data" structures
    
    func print_inventory() -> Void {
        print("CURRENT INVENTORY: ")
        
        for ingredient in data {
            if(ingredient.Unit == "Egg(s)") {
                print("\(ingredient.Amount) Egg(s)")
            }
            else{
                print("\(ingredient.Amount) \(ingredient.Unit) of \(ingredient.Name)")
            }
        }
        print() //printing new line
    }
}
//========= End Inventory class =========

//========= User class =========

class User {
    
    //=====User's Properties==========
    
    var CookBook = [Recipe]()
    var UserInventory = Inventory().data
    
    //=====End Properties==========
    
    //=====User's Instance Methods==========


    //This function updates the kitchen inventory after a recipe has been made. Note: assumes # of servings is changed before entering function
    func MakeRecipe(_ TheRecipe : Recipe) -> Bool {
        var UpdatedInventoryAmounts = [Int : Double]()
        
        for ingredient in TheRecipe.Ingredients {
            if(UserInventory.contains(ingredient)){
                let index = UserInventory.index(of: ingredient)!
                if(TestInventoryAmount(UserInventory[index], ingredient)){
                    UpdatedInventoryAmounts[index] = UserInventory[index].Amount - ingredient.Amount
                }
                else {
                    print("Cannot make recipe")
                    return false
                }
            } else {
                print("Cannot make recipe")
                return false
            }
        }
    
        for (index, amount) in UpdatedInventoryAmounts {
            UserInventory[index].Amount = amount
        }
        
        UserInventory = UserInventory.filter{$0.Amount != 0} //remove all inventory items with amount = 0 from 'UserInventory'
        return true
        
        //NOTE: Since we don't know if we need to update the inventory amount until we're done with the 1st for loop, we store the location of the ingredient within the user's inventory and the updated amount in 'UpdatedInventoryAmounts'. This way, if it turns out we can make the recipe we have all the necessary information to update the inventory appropriately.
    }
    
    func ConvertUnits(_ InventoryItem: ingredient_data, _ IngredientItem : ingredient_data) -> Bool{
        
        switch(InventoryItem.Unit){
            
        case ("Tsp(s)") :
            switch(IngredientItem.Unit){
            case ("Tbsp(s)") :
                return(IngredientItem.Amount <= tspAndTbsp(InventoryItem.Amount, "Tbsp(s)") ? true : false)
            case ("Oz(s)") :
                return(IngredientItem.Amount <= ozAndtsp(InventoryItem.Amount, "Oz(s)") ? true : false)
            default :
                print("couldn't find a unit to match with 'Tsp(s)'")
            }
            
        case("Tbsp(s)") :
            switch(IngredientItem.Unit){
            case ("Tsp(s)") :
                return(IngredientItem.Amount <= tspAndTbsp(InventoryItem.Amount, "Tsp(s)") ? true : false)
            case ("Cup(s)") :
                return(IngredientItem.Amount <= cupAndtbsp(InventoryItem.Amount, "Cup(s)") ? true : false)
            case ("Oz(s)") :
                return(IngredientItem.Amount <= ozAndtbsp(InventoryItem.Amount, "Oz(s)") ? true : false)
            default :
                print("couldn't find a unit to match with 'Tbsp(s)'")
            }
            
        case("Cup(s)") :
            switch(IngredientItem.Unit){
            case ("Tbsp(s)") :
                return(IngredientItem.Amount <= cupAndtbsp(InventoryItem.Amount, "Tbsp(s)") ? true : false)
            case ("Oz(s)") :
                return(IngredientItem.Amount <= cupAndoz(InventoryItem.Amount, "Oz(s)") ? true : false)
            case ("Pint(s)") :
                return(IngredientItem.Amount <= cupAndpint(InventoryItem.Amount, "Pint(s)") ? true : false)
            case ("Quart(s)") :
                return(IngredientItem.Amount <= cupAndquart(InventoryItem.Amount, "Quart(s)") ? true : false)
            case ("Gallon(s)") :
                return(IngredientItem.Amount <= cupAndgallon(InventoryItem.Amount, "Gallon(s)") ? true : false)
            default :
                print("couldn't find a unit to match with 'Cup(s)'")
            }
            
        case("Oz(s)") :
            switch(IngredientItem.Unit) {
            case("Tsp(s)") :
                return(IngredientItem.Amount <= ozAndtsp(InventoryItem.Amount, "Tsp(s)") ? true : false)
            case("Tbsp(s)") :
                return(IngredientItem.Amount <= ozAndtbsp(InventoryItem.Amount, "Tbsp(s)") ? true : false)
            case("Pint(s)") :
                return(IngredientItem.Amount <= ozAndpint(InventoryItem.Amount, "Pint(s)") ? true : false)
            case("Quart(s)") :
                return(IngredientItem.Amount <= ozAndquart(InventoryItem.Amount, "Quart(s)") ? true : false)
            case ("Gallon(s)") :
                return(IngredientItem.Amount <= ozAndgallon(InventoryItem.Amount, "Gallon(s)") ? true : false)
            default :
                print("couldn't find a unit to match with 'Oz(s)'")
            }
        case("Pint(s)") :
            print()
        case("Quart(s)"):
            print()
        case("Gal(s)") :
            print()
        case("mL(s)") :
            print()
        case("L(s)") :
            print()
        //volume conversions above
        default:
            print("Error in converison: see ConvertUnits()")
        }
        
        //weights
        
        return false
    }
    
    
    //this compares converted ingredient amounts to determine if the user has enough of the ingredient
    func TestInventoryAmount(_ InventoryItem : ingredient_data, _ IngredientItem: ingredient_data) -> Bool {
        var flag = true
        switch(InventoryItem.Unit, IngredientItem.Unit){
            
        case (InventoryItem.Unit, IngredientItem.Unit) where InventoryItem.Unit == IngredientItem.Unit :
            if(InventoryItem.Amount < IngredientItem.Amount){//then we can't use this item as an ingredient in the recipe
                flag = false
            }
        case (InventoryItem.Unit, IngredientItem.Unit) where InventoryItem.Unit != IngredientItem.Unit :
            flag = ConvertUnits(InventoryItem, IngredientItem)
            
        default:
            print("Unit NOT found")
        }
        
        return flag
        
        //NOTE: possible units include: Cup(s), Stick(s), Egg(s), Tbsp (tablespoons), tsp (teaspoons), Fl Oz (liquid), Oz (weight), mL(s), L(s) Liters, Gal(s) (Gallons)
        
    }
    
    func FeasibleRecipes() -> Void { //Calculates all recipes that can be made by the user with current ingredients.
        var RecipeIndex = 0
        var ArrayOfWhichRecipesCanBeMade = [Int]()
        //this for loop creates the Array ^
        for _ in CookBook {
            ArrayOfWhichRecipesCanBeMade.append(1)
        }

        
        for recipe in CookBook {
            var CanMakeRecipe = true //Assume the recipe can be made until proven it cant be
            
            for ingredient in recipe.Ingredients {
                var HaveIngredient = false //assume we don't have the ingredient needed
                for item in UserInventory{ //brute force search, with large databases you will need to switch to a more efficient method
                    if(item.Name == ingredient.Name){
                        HaveIngredient = true
                        CanMakeRecipe = TestInventoryAmount(item,ingredient) //test to see if we have enough of the ingredient to make the recipe
                        if(CanMakeRecipe == false){break} //cant make it, move on to the next recipe
                    }
                }
                //break takes us here
                if(HaveIngredient == false || CanMakeRecipe == false){
                    ArrayOfWhichRecipesCanBeMade[RecipeIndex] = 0 //indicate recipe cannot be made with a 0
                    break
                }
            }
            
            RecipeIndex += 1
        }
        
        if(ArrayOfWhichRecipesCanBeMade.max()! > 0) {
            print("The following recipe(s) can be made")
            var index = 0
            while(index < ArrayOfWhichRecipesCanBeMade.count){
                if(ArrayOfWhichRecipesCanBeMade[index] == 1){
                    CookBook[index].print_recipe()
                }
                index += 1
            }
        } else {
            print("Unfortunately, no recipes can be made at this time.")
        }
    }
    
    
    func print_inventory() -> Void {
        print("THE USER'S INVENTORY: ")
        
        for ingredient in UserInventory {
            if(ingredient.Unit == "Egg(s)") {
                print("\(ingredient.Amount) Egg(s)")
            }
            else {
                print("\(ingredient.Amount) \(ingredient.Unit) of \(ingredient.Name)")
            }
        }
        print()
    }
    
    func print_CookBook() -> Void {
        print("User XYZ's CookBook")
        for recipe in CookBook {
            recipe.print_recipe()
        }
    }
    
    
    func Add_Recipes(Recipes: [Recipe]) -> Void {
        for recipe in Recipes {
            CookBook.append(recipe)
        }
    }
    
    func Add_Inventory(Inventory: [ingredient_data]) -> Void {
        for item in Inventory {
            UserInventory.append(item)
        }
    }
    
     //=====End User's Instance Methods==========
}

//========= End User class =========


//========= Recipe class =========

class Recipe {
    
    var Ingredients = [ingredient_data]() //creates an empty array of type: 'ingredient_data'
    
    //then you can use these categories to create various cookbooks
    
    var RecipeName : String = ""
    var Servings = 1.0
    
    func print_recipe() -> Void{
        print("Ingredients for \(Servings) serving(s) of \(RecipeName): ")
        
        for ingredient in Ingredients {
            print("\(ingredient.Amount) \(ingredient.Unit) of \(ingredient.Name)")
        }
        print()
    }
    
    func change_serving_size(_ new_size: Double) ->Void {
        if(new_size > 0) {
            Servings = new_size
            
            for (ingredient_index, _) in Ingredients.enumerated() {
                Ingredients[ingredient_index].Amount *= new_size
            }
        } else{
            print("Enter a valid serving size")
        }
    }
    
    init(Name: String, Servings: Double, Ingredients: [ingredient_data]){
        self.RecipeName = Name
        self.Servings = Servings
        self.Ingredients = Ingredients
    }

}

//========= End Recipe class =========



//Things to improve:
//1) The ingredient names in the inventory must be exactly the same as the ones in the recipe for this program to work. This is not very realistic because it is very possible for a recipe to contain an ingredient that is essentially the same thing as an inventory item, but not the same string. For instance, 'margarine' vs. 'butter', or 'extra virgin olive oil' vs 'olive oil'.

//2)If the user cannot make the recipe with the initial serving size, but can make the recipe with a smaller size, you could create a function that alerts the user of this information. For instance: if a recipe initally has 6 servings and it calls for 2 cups of cheese, but the user has only has one cup of cheese, then the function could say, 'Sorry you can't make 6 servings of this, but you can make 3 servings'

//3)It'd be nice to add an enum with things like "breakfast", "lunch", "dinner", "dessert", "snack", etc. to the Recipe class. There could also add subcategories like "italian" "french" "hispanic" to further differentiate recipes.

