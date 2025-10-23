//
//  EditRecipeView.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/22.
//

import SwiftUI

struct EditRecipeView: View {
    let recipe: Recipe
    let recipeManager: RecipeManager
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var imageURL = ""
    @State private var rating = 5.0
    @State private var description = ""
    @State private var ingredients = [""]
    @State private var steps =  [""]
    
    
    
    var body: some View {
        NavigationView{
            Form{
                //                MARK: - Title && imageURL
                Section ("Cuision Information"){
                    TextField("Cuisine Name", text: $title)
                    
                    TextField("Image URL", text: $imageURL) // Bound to imageURL state (pre-populated)
                        .textContentType(.URL) // Hint for URL input
                        .autocapitalization(.none) // Disable auto-capitalization for URLs
                        .disableAutocorrection(true) // Disable auto-correction for URLs
                }
                //                MARK: - Rating
                Section("Easy to make"){
                    VStack(alignment: .leading, spacing: 8){
                        Text("Rating: \(rating, specifier: "%.1f")/5.0 ")
                            .font(.headline)
                        
                        Slider(value:$rating, in: 1.0...5.0, step:0.1)
                        
                        HStack { // Horizontal stack for min/max labels
                            Text("1.0 - Easy") // Minimum rating explanation
                                .font(.caption) // Small font size
                                .foregroundColor(.secondary) // Gray color for subtlety
                            Spacer() // Flexible space between labels
                            Text("5.0 - Difficult") // Maximum rating explanation
                                .font(.caption) // Small font size
                                .foregroundColor(.secondary) // Gray color for subtlety
                        }//END HStack
                    }// End VStack
                }//end rating
                
                //                MARK: - Description
                Section("Description"){
                    TextField("Short Description", text: $description,axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }
                
                //                MARK: - Ingredients
                Section("Ingredients"){
                    ForEach(ingredients.indices,id:\.self){i in
                        HStack{
                            TextField("Ingredient \(i+1)", text: $ingredients[i])
                            if ingredients.count > 1 {
                                Button(role: .destructive){
                                    ingredients.remove(at: i)
                                }label:{ Image(systemName: "minus.circle.fill")}
                            }
                        }
                    }
                    Button{
                        ingredients.append("")
                    } label: {
                        Label("Add Ingredient", systemImage: "plus.circle.fill")
                    }
                }
                
                //                MARK: - Steps
                Section("Steps"){
                    ForEach(steps.indices,id:\.self){i in
                        HStack{
                            TextField("Step \(i+1)", text: $steps[i])
                            if steps.count > 1 {
                                Button(role: .destructive){
                                    steps.remove(at: i)
                                }label:{ Image(systemName: "minus.circle.fill")}
                            }
                        }
                        
                    }
                    Button{
                        steps.append("")
                    } label: {
                        Label("Add Step", systemImage: "plus.circle.fill")
                    }
                }
                
                
                
                
            }//END FORM1
            .navigationTitle("Edit Recipe") // Set navigation bar title
            .navigationBarTitleDisplayMode(.inline) // Use compact title style
            .toolbar { // Add toolbar items to navigation bar
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // 這裡可呼叫 recipeManager 更新
                        // recipeManager.updateRecipe(...)
                        dismiss()
                    }
                    .disabled(title.isEmpty || ingredients.allSatisfy { $0.trimmingCharacters(in: .whitespaces).isEmpty })
                }
            }
        }
                .onAppear {
                            title = recipe.title
                            imageURL = recipe.imageURL
                            rating = recipe.rating
                            description = recipe.description
                            ingredients = recipe.ingredients.isEmpty ? [""] : recipe.ingredients
                            steps = recipe.steps.isEmpty ? [""] : recipe.steps
                }
    }
}

#Preview {
    let manager = RecipeManager()
    let sample = manager.recipes[0]

    EditRecipeView(recipe: sample, recipeManager: manager)
    
    
}
