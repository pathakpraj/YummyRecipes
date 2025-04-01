import SwiftUI

struct RecipesTitleView: View {
    var body: some View {
        Text("Recipes")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.horizontal)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RecipesTitleView()
}
