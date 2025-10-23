//
//  RecipeManager.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/19.
//


import SwiftUI
import Foundation
import Combine

class RecipeManager: ObservableObject {
    @Published var recipes: [Recipe] = [
        Recipe(
            title:"Quick and Easy Pizza Dough",
            imageURL:"https://cdn.dummyjson.com/recipe-images/1.webp",
//            imageURL:"",
            rating: 5.0,
            description: "An amazing recipe for a quick pizza dough",
            ingredients: ["Pizza dough", "Tomato sauce", "Fresh mozzarella cheese", "Fresh basil leaves", "Olive oil","Salt and pepper to taste"],
            steps: [
                "Preheat the oven to 475°F (245°C).",
                "Roll out the pizza dough and spread tomato sauce evenly.",
                "Top with slices of fresh mozzarella and fresh basil leaves.",
                "Drizzle with olive oil and season with salt and pepper.",
                "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
                "Slice and serve hot."
              ],
            
        ), Recipe(
            title: "Caesar Salad",
//            imageURL:"https://cdn.dummyjson.com/recipe-images/6.webp",
            imageURL:"",
            rating: 4.5,
            description: "Fresh lettuce with classic Caesar dressing.",
            ingredients: [
                "Quinoa, cooked",
                "Avocado, diced",
                "Cherry tomatoes, halved",
                "Cucumber, diced",
                "Red bell pepper, diced",
                "Feta cheese, crumbled",
                "Lemon vinaigrette dressing",
                "Salt and pepper to taste"
              ],
            
            steps: [
                "In a large bowl, combine cooked quinoa, diced avocado, halved cherry tomatoes, diced cucumber, diced red bell pepper, and crumbled feta cheese.",
                "Drizzle with lemon vinaigrette dressing and toss to combine.",
                "Season with salt and pepper to taste.",
                "Chill in the refrigerator before serving."
              ],
            
        ),
    ]
    
    func addRecipe(title:String,imageURL:String,rating:Double, description:String, ingredients:[String], steps:[String],){
        let new = Recipe(title: title,imageURL: imageURL,rating: rating, description: description, ingredients: ingredients,steps: steps)
        recipes.append(new)
    }
    func deleteRecipe(_ recipe:Recipe){
        recipes.removeAll {$0.id == recipe.id}
        
    }
    
    func swipeToDelete(at offsets: IndexSet){
        recipes.remove(atOffsets: offsets)
    }
    func updateRecipe(_ recipe:Recipe, newTitle:String, newDescription:String, newIngredients:[String],newRating:Double, newSteps:[String],newImageURL:String){
        if let index = recipes.firstIndex(where: {$0.id == recipe.id}){
            recipes[index].title = newTitle
            recipes[index].description = newDescription
            recipes[index].ingredients = newIngredients
            recipes[index].rating = newRating
            recipes[index].steps = newSteps
            recipes[index].imageURL = newImageURL
            
        }
    }
    
    func filtered(by keyword: String)-> [Recipe] {
        let query = keyword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return recipes }
        
        return recipes.filter{ recipe in
            recipe.title.lowercased().contains(query) ||
            recipe.ingredients.contains(where: { $0.lowercased().contains(query) }) ||
            recipe.description.lowercased().contains(query)
        }
    }
}
