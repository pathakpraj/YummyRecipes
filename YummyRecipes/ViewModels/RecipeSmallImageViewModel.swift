import Foundation
import SwiftUI
import Combine


class RecipeSmallImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false

    private let recipe: RecipeModel
    let imageService: RecipeImageService
    
    init(recipe: RecipeModel, networkManager: NetworkManager, fileManager: RecipesFileManager) {
        self.recipe = recipe
        self.imageService = RecipeImageService(
            networkManager: networkManager,
            fileManager: fileManager )
    }

    func fetchImageAsync() async {
       await MainActor.run {
            isLoading = true
        }
        let image = await imageService.fetchImage(
            recipe: recipe,
            imageType: .small)
        await MainActor.run {
            self.image =  image
            isLoading = false
        }
    }
}
