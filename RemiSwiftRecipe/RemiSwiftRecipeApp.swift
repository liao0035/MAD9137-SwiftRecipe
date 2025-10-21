//
//  RemiSwiftRecipeApp.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/19.
//

import SwiftUI

@main
struct RemiSwiftRecipeApp: App {
    @StateObject private var recipeManager = RecipeManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipeManager)
        }
    }
}
