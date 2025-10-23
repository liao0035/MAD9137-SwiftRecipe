//
//  AddRecipeView.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/22.
//

import SwiftUI

// MARK: - Reuseable form
struct RecipeFormContent: View {

    @Binding var title: String
    @Binding var imageURL: String
    @Binding var rating: Double
    @Binding var description: String
    @Binding var ingredients: [String]
    @Binding var steps: [String]

    let recipeManager: RecipeManager
    let onAddRecipe: () -> Void
    let submitButtonText: String

    var body: some View {
        Form {
            //            MARK: - Title && imageURL
            Section("Cuision Information") {
                TextField("Cuisine Name", text: $title)

                TextField("Image URL", text: $imageURL)
                    .textContentType(.URL)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            //                MARK: - Rating
            Section("Easy to make") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rating: \(rating, specifier: "%.1f")/5.0 ")
                        .font(.headline)

                    Slider(value: $rating, in: 1.0...5.0, step: 0.1)

                    HStack {  // Horizontal stack for min/max labels
                        Text("1.0 - Easy")  // Minimum rating explanation
                            .font(.caption)  // Small font size
                            .foregroundColor(.secondary)  // Gray color for subtlety
                        Spacer()  // Flexible space between labels
                        Text("5.0 - Difficult")  // Maximum rating explanation
                            .font(.caption)  // Small font size
                            .foregroundColor(.secondary)  // Gray color for subtlety
                    }  //END HStack
                }  // End VStack
            }  //end rating

            //                MARK: - Description
            Section("Description") {
                TextField(
                    "Short Description",
                    text: $description,
                    axis: .vertical
                )
                .lineLimit(3, reservesSpace: true)
            }

            //                MARK: - Ingredients
            Section("Ingredients") {
                ForEach(ingredients.indices, id: \.self) { i in
                    HStack {
                        TextField("Ingredient \(i+1)", text: $ingredients[i])
                        if ingredients.count > 1 {
                            Button(role: .destructive) {
                                ingredients.remove(at: i)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                            }
                        }
                    }
                }
                Button {
                    ingredients.append("")
                } label: {
                    Label("Add Ingredient", systemImage: "plus.circle.fill")
                }
            }

            //                MARK: - Steps
            Section("Steps") {
                ForEach(steps.indices, id: \.self) { i in
                    HStack {
                        TextField("Step \(i+1)", text: $steps[i])
                        if steps.count > 1 {
                            Button(role: .destructive) {
                                steps.remove(at: i)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                            }
                        }
                    }

                }
                Button {
                    steps.append("")
                } label: {
                    Label("Add Step", systemImage: "plus.circle.fill")
                }
            }// END STEP
            
            Section{
                Button(action: addRecipe){
                    Text(submitButtonText)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .disabled(!isFormValid)
                .listRowBackground(isFormValid ? Color.blue :Color.gray)
            }

        }
    }
    
    var isFormValid: Bool {
        !title.isEmpty && !imageURL.isEmpty && !rating.isNaN && !description.isEmpty && !ingredients.isEmpty && !steps.isEmpty
    }

    func addRecipe() {
        recipeManager.addRecipe(
            title: title,
            imageURL: imageURL,
            rating: rating,
            description: description,
            ingredients: ingredients,
            steps: steps,
        )
        onAddRecipe()

    }
}

// MARK: - Receive data from form
struct AddRecipeView: View {
    let recipeManager: RecipeManager

    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var imageURL = ""
    @State private var rating = 5.0
    @State private var description = ""
    @State private var ingredients = [""]
    @State private var steps = [""]

    var body: some View {

        NavigationView {
            RecipeFormContent(
                title: $title,
                imageURL: $imageURL,
                rating: $rating,
                description: $description,
                ingredients: $ingredients,
                steps: $steps,
                recipeManager: recipeManager,
                onAddRecipe: { dismiss() },
                submitButtonText: "Add"
            )
            .navigationTitle("Add Cuisine")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem (placement: .cancellationAction){
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
            }
        }

    }
}

#Preview {

    AddRecipeView(recipeManager: RecipeManager())

}
