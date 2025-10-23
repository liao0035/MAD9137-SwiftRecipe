//
//  Recipe.swift
//  RemiSwiftRecipe
//
//  Created by Remi Liao on 2025/10/19.
//

import SwiftUI
import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    var title: String
    var imageURL: String
    var rating: Double
    var description: String
    var ingredients:[String]
    var steps:[String]
}
