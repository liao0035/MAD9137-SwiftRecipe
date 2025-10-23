//
//  RecipeDetialView.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/21.
//

import SwiftUI

struct RecipeDetialView: View {
    
    let recipe: Recipe
    let reciperManager: RecipeManager
    
    @State private var showingEditRecipe = false
    
    var body: some View {
        
        ScrollView{
            
            VStack{
                VStack(alignment: .leading){
                    AsyncImage(url: URL(string:recipe.imageURL)){ img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(16)
                            .clipped()
                        
                    }placeholder: {
                        //                    Rectangle()
                    }
//
                    
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f / 5.0", recipe.rating))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding()
            }
            
            VStack{
                RecipeInfo(ingredients: recipe.ingredients, steps:recipe.steps, description: recipe.description)
            }
//            .border(.gray,width: 2)
        }
        .navigationBarTitle(recipe.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { // Add toolbar items to navigation bar
            // STEP 49: Add edit button to navigation bar
            ToolbarItem(placement: .navigationBarTrailing) { // Place button on right side of navigation bar
                Button("Edit") { // Create edit button
                    showingEditRecipe = true // Set state to show edit sheet
                }
            }
            //add edit recipe view
           
        }
        
    }
        
    
}

#Preview {
    let manager = RecipeManager()
    return NavigationStack {
        RecipeDetialView(
            recipe: manager.recipes.first!,
            reciperManager: manager
        )
    }
}

