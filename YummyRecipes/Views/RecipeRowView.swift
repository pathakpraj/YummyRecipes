import SwiftUI

struct RecipeRowView: View {
    let recipe: RecipeModel
    let networkManager: NetworkManager

    var body: some View {
        HStack (spacing: 0) {
            HStack(spacing: 20) {
                RecipeSmallImageView(recipe: recipe, networkManager: networkManager)

                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                        
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundStyle(Color.theme.secondaryText)
                        .fontWeight(.bold)
                    
                    if let youtubeURL = recipe.youtubeURL {
                        Link("Watch on YouTube", destination: youtubeURL)
                            .font(.caption)
                            .underline()
                            .foregroundStyle(.blue)
                    }

                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .frame(height: 75)
        .frame(maxWidth: .infinity)
    }
}

#Preview("Recipe Row", traits: .sizeThatFitsLayout) {
    Group {
        RecipeRowView(recipe: DeveloperPreview.instance.recipe, networkManager: RecipesNetworkManager())
            .padding()
            .background(Color.theme.background)
            .colorScheme(.light)
        
        RecipeRowView(recipe: DeveloperPreview.instance.recipe, networkManager: RecipesNetworkManager())
            .padding()
            .background(Color.theme.background)
            .colorScheme(.dark)
    }
}
