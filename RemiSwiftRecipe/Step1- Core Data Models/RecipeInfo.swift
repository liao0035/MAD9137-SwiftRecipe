//
//  RecipeInfo.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/21.
//

import SwiftUI

struct RecipeInfo: View {
    let title: String
    let ingredients: [String]
    let steps: [String]
    let description: String
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 12)
            
            Text("Ingredients:")
                    .font(.headline)
            ForEach(ingredients, id: \.self){
                item in Text(" . \(item)")
                    
            }
            .padding(.vertical, 4)
            
            Text("Steps:")
                       .font(.headline)
                       .padding(.top)
            ForEach(steps.indices, id: \.self) { index in
                HStack(alignment: .top, spacing: 4) {
                    Text("\(index + 1).")
                        .frame(width: 20, alignment: .leading)
                    Text(steps[index])
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.vertical, 4)
   
            
        }
        .padding(.horizontal,8)
        .padding(.vertical,16)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal,8)
    }
}

#Preview {
    RecipeInfo(
        title: "Quick and Easy Pizza Dough",
        ingredients: [
            "Pizza dough",
            "Tomato sauce",
            "Fresh mozzarella cheese",
            "Fresh basil leaves",
            "Olive oil",
            "Salt and pepper to taste"
        ],
        steps: [
            "Preheat the oven to 475°F (245°C).",
            "Roll out the pizza dough and spread tomato sauce evenly.",
            "Top with slices of fresh mozzarella and basil.",
            "Drizzle with olive oil and bake 12–15 minutes."
        ],
        description: "An amazing recipe for a quick pizza dough — simple, fast, and delicious!"
    )
}
