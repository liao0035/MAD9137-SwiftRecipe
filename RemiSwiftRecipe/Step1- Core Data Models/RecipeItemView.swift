//
//  RecipeItemView.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/21.
//

import SwiftUI
struct RecipeItemView: View {
    let recipe: Recipe
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: recipe.imageURL)){ img in
                img
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                
            } placeholder: {
                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray.opacity(0.2))
                    .cornerRadius(16)
            }
            
            VStack(alignment:.leading){
                
                Text(recipe.title)
                    .font(.title)
                    
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f / 5.0", recipe.rating))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)

            

            
            
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 2)
     )
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        
    }
}


#Preview {
    let manager = RecipeManager()
    ScrollView {
        VStack {
            ForEach(manager.recipes) { recipe in
                RecipeItemView(recipe: recipe)
            }
        }
    }
}

