import SwiftUI

struct RecipeSmallImageView: View {
    @StateObject var viewModel: RecipeSmallImageViewModel

    init(recipe: RecipeModel, networkManager: NetworkManager) {
        _viewModel = StateObject(wrappedValue: RecipeSmallImageViewModel(
            recipe: recipe,
            networkManager: networkManager,
            fileManager: RecipesCacheFolderFileManager()))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
    
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
        }
        .onAppear() {
            Task {
                await viewModel.fetchImageAsync()
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RecipeSmallImageView(recipe: DeveloperPreview.instance.recipe, networkManager: RecipesNetworkManager())
        .padding()
}
