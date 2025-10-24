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
                    .cornerRadius(16)
                    .overlay(
                        ZStack(alignment: .bottom) {
                            // Add LinearGradient on top of img
                            LinearGradient(
                                colors: [.clear, .black.opacity(0.75)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            // recipe title and difficulty rate on top of img
                            VStack(alignment: .leading, spacing: 6) {
                                Text(recipe.title)
                                    .font(.title).fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .lineLimit(2)

                                HStack(spacing: 8) {
                                    Image(
                                        systemName:
                                            "gauge.open.with.lines.needle.33percent"
                                    )
                                    .foregroundColor(.yellow)
                                    let display =
                                        (recipe.difficulty * 2).rounded() / 2
                                    Text("\(display, specifier: "%.1f") / 5.0")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.9))

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white.opacity(0.9))
                                        .font(.caption)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        }

                    ).cornerRadius(16)
                    .shadow(color: .black.opacity(0.7), radius: 4, x: 4, y: 8)

            } placeholder: {
                VStack {
                    ZStack {
                        Rectangle()
                            .aspectRatio(3 / 4, contentMode: .fit)
                            .foregroundColor(.gray.opacity(0.2))
                            .cornerRadius(16)

                        Text("No image")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .overlay(
                        ZStack(alignment: .bottom) {
                            // Add LinearGradient on top of img
                            LinearGradient(
                                colors: [.clear, .gray.opacity(0.75)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            // recipe title and difficulty rate on top of img
                            VStack(alignment: .leading, spacing: 6) {
                                Text(recipe.title)
                                    .font(.title2).fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .lineLimit(2)

                                HStack(spacing: 8) {
                                    Image(
                                        systemName:
                                            "gauge.open.with.lines.needle.33percent"
                                    )
                                    .foregroundColor(.yellow)
                                    let display =
                                        (recipe.difficulty * 2).rounded() / 2
                                    Text("\(display, specifier: "%.1f") / 5.0")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.9))

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white.opacity(0.9))
                                        .font(.caption)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        }

                    ).cornerRadius(16)
                    .shadow(color: .black.opacity(0.7), radius: 4, x: 4, y: 8)

              
                }
            }
        }
        .padding()
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
