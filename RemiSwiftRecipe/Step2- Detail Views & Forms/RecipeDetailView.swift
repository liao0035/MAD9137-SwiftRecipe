//
//  RecipeDetailView.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/21.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipe: Recipe
//    let recipeManager: RecipeManager
    @ObservedObject var recipeManager: RecipeManager
    
    @State private var showingEditRecipe = false
    
    var body: some View {
        let current = recipeManager.recipes.first(where: { $0.id == recipe.id }) ?? recipe
        ScrollView{
            
            VStack{
                VStack(alignment: .leading){
                    AsyncImage(url: URL(string:current.imageURL)){ img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(16)
                            .clipped()
                        
                    }placeholder: {
                        ZStack {
                            Rectangle()
                                .aspectRatio(4 / 3, contentMode: .fit)
                                .foregroundColor(.gray.opacity(0.2))
                                .cornerRadius(16)

                            Text("No image")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    
                    HStack {
                        Image(systemName: "gauge.open.with.lines.needle.33percent")
                            .foregroundColor(.yellow)
                        
                        let display = (current.difficulty * 2).rounded() / 2
                        Text("Difficulty: \(display, specifier: "%.1f") / 5.0")
                            .font(.headline)
                        
                    }
                    .padding(.vertical,4)
                    
                }
                .padding()
            }
            
            VStack{
                RecipeInfo(ingredients: current.ingredients, steps:current.steps, description: current.description)
            }
//            .border(.gray,width: 2)
        }
        .navigationBarTitle(current.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { // Add toolbar items to navigation bar
            // STEP 49: Add edit button to navigation bar
            ToolbarItem(placement: .navigationBarTrailing) { // Place button on right side of navigation bar
                Button("Edit") { // Create edit button
                    showingEditRecipe = true // Set state to show edit sheet
                }
            }
            
           
        }.sheet(isPresented: $showingEditRecipe){
            EditRecipeView(recipe:current, recipeManager: recipeManager)
        }
        
    }
        
    
}

#Preview {
    let manager = RecipeManager()
    return NavigationStack {
        RecipeDetailView(
            recipe: manager.recipes.first!,
            recipeManager: manager
        )
    }
}

