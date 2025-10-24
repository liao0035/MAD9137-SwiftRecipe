//
//  Navigation.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/23.
//

import SwiftUI

//MARK: - Main List View

struct Navigation: View {
    @EnvironmentObject var recipeManager: RecipeManager

    @State private var showAddNewRecipe = false

    //    Create state variables for alerts
    @State private var showAddAlert: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var addRecipeName: String = ""
    @State private var deleteRecipeName: String = ""

    var body: some View {
        NavigationView {
           ScrollView {
                ForEach(recipeManager.recipes) { recipe in
                    NavigationLink(
                        destination:
                            RecipeDetailView(
                                recipe: recipe,
                                recipeManager: recipeManager
                            )
                    ) {
                        RecipeItemView(recipe: recipe)
                            .contextMenu {
                                Button(role: .destructive){
                                    recipeManager.deleteRecipe(recipe)
                                } label:{
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                    .buttonStyle(.plain)

                }
            }
           .navigationTitle("Recipes")
           .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//MARK: - Preiview

#Preview() {
    Navigation()
        .environmentObject(RecipeManager())

}
