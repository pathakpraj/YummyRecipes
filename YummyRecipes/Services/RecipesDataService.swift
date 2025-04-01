import Foundation
import Combine

class RecipesDataService {
    @Published var allRecipes: [RecipeModel] = []
    let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func downloadRecipes(from url: URL?) async throws {
        guard let url = url else { return }
        allRecipes = try await networkManager.downloadRecipes(url: url)
    }
}

