import SwiftUI

@main
struct YummyRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            // This is my Yummy Recipes simple App.
            RecipesListView(
                recipesURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!,
//                recipesURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!,
//                recipesURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!,
                networkManager: RecipesNetworkManager())
        }
    }
}
