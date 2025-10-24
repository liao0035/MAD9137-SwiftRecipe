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
            AsyncImage(url: URL(string: recipe.imageURL)) { img in
                img
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        .rect(topLeadingRadius: 16, topTrailingRadius: 16)
                    )

            } placeholder: {
                ZStack {
                    Rectangle()
                        .aspectRatio(4 / 3, contentMode: .fit)
                        .foregroundColor(.gray.opacity(0.2))
                        .clipShape(
                            .rect(topLeadingRadius: 16, topTrailingRadius: 16)
                        )

                    Text("No image")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }

            VStack {
                Text(recipe.title)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Image(systemName: "gauge.open.with.lines.needle.33percent")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f / 5.0", recipe.difficulty))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right") // System chevron pointing right
                        .foregroundColor(.secondary) // Gray color to be subtle
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical,4)
                
               

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            

        }
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray, lineWidth: 3)
        )
        .padding(12)

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
