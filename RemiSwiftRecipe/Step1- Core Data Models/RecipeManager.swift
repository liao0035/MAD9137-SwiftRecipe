//
//  RecipeManager.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/19.
//

import Combine
import Foundation
import SwiftUI

class RecipeManager: ObservableObject {
    @Published var recipes: [Recipe] = [
        Recipe(
            title: "Quick and Easy Pizza Dough",
            //            imageURL:"https://cdn.dummyjson.com/recipe-images/1.webp",
            imageURL: "",
            difficulty: 3,
            description: "An amazing recipe for a quick pizza dough",
            ingredients: [
                "Pizza dough", "Tomato sauce", "Fresh mozzarella cheese",
                "Fresh basil leaves", "Olive oil", "Salt and pepper to taste",
            ],
            steps: [
                "Preheat the oven to 475°F (245°C).",
                "Roll out the pizza dough and spread tomato sauce evenly.",
                "Top with slices of fresh mozzarella and fresh basil leaves.",
                "Drizzle with olive oil and season with salt and pepper.",
                "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
                "Slice and serve hot.",
            ],

        ),
        Recipe(
            title: "Caesar Salad",
            imageURL: "https://cdn.dummyjson.com/recipe-images/6.webp",
            //            imageURL:"",
            difficulty: 2,
            description: "Fresh lettuce with classic Caesar dressing.",
            ingredients: [
                "Quinoa, cooked",
                "Avocado, diced",
                "Cherry tomatoes, halved",
                "Cucumber, diced",
                "Red bell pepper, diced",
                "Feta cheese, crumbled",
                "Lemon vinaigrette dressing",
                "Salt and pepper to taste",
            ],

            steps: [
                "In a large bowl, combine cooked quinoa, diced avocado, halved cherry tomatoes, diced cucumber, diced red bell pepper, and crumbled feta cheese.",
                "Drizzle with lemon vinaigrette dressing and toss to combine.",
                "Season with salt and pepper to taste.",
                "Chill in the refrigerator before serving.",
            ],

        ),
        Recipe(
            title: "Japanese Matcha Green Tea Ice Cream",
            imageURL: "https://cdn.dummyjson.com/recipe-images/34.webp",
            //            imageURL:"",
            difficulty: 3.5,
            description: "Matcha ice cream",
            ingredients: [
                "Heavy cream",
                "Whole milk",
                "Granulated sugar",
                "Matcha green tea powder",
                "Egg yolks",
            ],

            steps: [
                "In a saucepan, heat heavy cream, whole milk, and granulated sugar until it begins to steam.",
                "Whisk in matcha green tea powder until fully combined.",
                "In a separate bowl, whisk egg yolks. Slowly pour the hot milk mixture into the yolks, whisking continuously.",
                "Return the mixture to the saucepan and heat until it thickens. Do not boil.",
                "Strain the mixture and let it cool. Churn in an ice cream maker according to the manufacturer's instructions.",
                "Freeze until firm. Indulge in the creamy goodness of Japanese Matcha Green Tea Ice Cream!",
            ],

        ),
        Recipe(
            title: "Chicken Alfredo Pasta",
            imageURL: "https://cdn.dummyjson.com/recipe-images/4.webp",
            //            imageURL:"",
            difficulty: 4.5,
            description: "Chicken Pasta",
            ingredients: [
                "Fettuccine pasta",
                "Chicken breast, sliced",
                "Heavy cream",
                "Parmesan cheese, grated",
                "Garlic, minced",
                "Butter",
                "Salt and pepper to taste",
                "Fresh parsley for garnish",
            ],

            steps: [
                "Cook fettuccine pasta according to package instructions.",
                "In a pan, sauté sliced chicken in butter until fully cooked.",
                "Add minced garlic and cook until fragrant.",
                "Pour in heavy cream and grated Parmesan cheese. Stir until the cheese is melted.",
                "Season with salt and pepper to taste.",
                "Combine the Alfredo sauce with cooked pasta.",
                "Garnish with fresh parsley before serving.",
            ],

        ),
        Recipe(
            title: "Shrimp Scampi Pasta",
            imageURL: "https://cdn.dummyjson.com/recipe-images/10.webp",
            //            imageURL:"",
            difficulty: 5,
            description: "Italian",
            ingredients: [
                "Linguine pasta",
                "Shrimp, peeled and deveined",
                "Garlic, minced",
                "White wine",
                "Lemon juice",
                "Red pepper flakes",
                "Fresh parsley, chopped",
                "Salt and pepper to taste",
            ],

            steps: [
                "Cook linguine pasta according to package instructions.",
                "In a skillet, sauté minced garlic in olive oil until fragrant.",
                "Add shrimp and cook until pink and opaque.",
                "Pour in white wine and lemon juice. Simmer until the sauce slightly thickens.",
                "Season with red pepper flakes, salt, and pepper.",
                "Toss cooked linguine in the shrimp scampi sauce.",
                "Garnish with chopped fresh parsley before serving.",
            ],

        ),
    ]

    func addRecipe(
        title: String,
        imageURL: String,
        difficulty: Double,
        description: String,
        ingredients: [String],
        steps: [String],
    ) {
        let new = Recipe(
            title: title,
            imageURL: imageURL,
            difficulty: difficulty,
            description: description,
            ingredients: ingredients,
            steps: steps
        )
        recipes.append(new)
    }
    func deleteRecipe(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }

    }

    func swipeToDelete(at offsets: IndexSet) {
        recipes.remove(atOffsets: offsets)
    }
    func updateRecipe(
        _ recipe: Recipe,
        newTitle: String,
        newImageURL: String,
        newDifficulty: Double,
        newDescription: String,
        newIngredients: [String],
        newSteps: [String]
    ) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].title = newTitle
            recipes[index].imageURL = newImageURL
            recipes[index].difficulty = newDifficulty
            recipes[index].description = newDescription
            recipes[index].ingredients = newIngredients
            recipes[index].steps = newSteps

        }
    }

    func filtered(by keyword: String) -> [Recipe] {
        let query = keyword.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        guard !query.isEmpty else { return recipes }

        return recipes.filter { recipe in
            recipe.title.lowercased().contains(query)
                || recipe.ingredients.contains(where: {
                    $0.lowercased().contains(query)
                }) || recipe.description.lowercased().contains(query)
        }
    }
}
