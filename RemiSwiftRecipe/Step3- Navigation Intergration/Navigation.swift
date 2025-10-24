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

    @State private var searchQuery = ""

    @State private var showAddNewRecipe = false

    //    Create state variables for alerts
    @State private var showAddAlert: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var addRecipeName: String = ""
    @State private var deleteRecipeName: String = ""
    @State private var recipeCountBeforeAdd = 0

    private var visibleRecipes: [Recipe] {
        if searchQuery.isEmpty {
            return recipeManager.recipes
        } else {
            return recipeManager.filtered(by: searchQuery)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // ✅ 搜尋列放在最上方
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField(
                        "Search recipes",
                        text: $searchQuery
                    )
                    .textFieldStyle(.plain)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal,16)
                .padding(.vertical,8)

                ScrollView {
                    ForEach(visibleRecipes) { recipe in
                        NavigationLink(
                            destination:
                                RecipeDetailView(
                                    recipe: recipe,
                                    recipeManager: recipeManager
                                )
                        ) {
                            RecipeItemView(recipe: recipe)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        deleteRecipeName = recipe.title
                                        recipeManager.deleteRecipe(recipe)
                                        showDeleteAlert = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        .buttonStyle(.plain)

                    }
                }
            }

            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        recipeCountBeforeAdd = recipeManager.recipes.count
                        showAddNewRecipe = true

                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(
                isPresented: $showAddNewRecipe,
                onDismiss: {
                    if recipeManager.recipes.count > recipeCountBeforeAdd {
                        if let lastRecipe = recipeManager.recipes.last {
                            addRecipeName = lastRecipe.title
                            showAddAlert = true
                        }
                    }
                }
            ) {
                AddRecipeView(recipeManager: recipeManager)
            }
            .alert("Recipe Added", isPresented: $showAddAlert) {
                Button("OK") {}
            } message: {
                Text("\(addRecipeName) has been added")
            }
            .alert("Recipe Deleted", isPresented: $showDeleteAlert) {
                Button("OK") {}
            } message: {
                Text("\(deleteRecipeName) has been deleted")
            }
        }
    }
}

//MARK: - Preiview

#Preview() {
    Navigation()
        .environmentObject(RecipeManager())

}
