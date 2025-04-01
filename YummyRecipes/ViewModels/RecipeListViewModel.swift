import Foundation
import Combine

@MainActor
class RecipesListViewModel: ObservableObject {
    @Published var recipes: [RecipeModel] = []
    @Published var sortingManager =  RecipesSortingManager()
    @Published var errorMessage: String?

    private let dataService: RecipesDataService

    init(networkManager: NetworkManager) {
        self.dataService = RecipesDataService(networkManager: networkManager)
    }

    func fetchRecipes(from url: URL) async {
        do {
            try await dataService.downloadRecipes(from: url)
            self.recipes = dataService.allRecipes
            if self.recipes.isEmpty {
                errorMessage = "Sorry! No recipes found."
                return
            }
            sortByNames()
        } catch let error {
            debugPrint("Error fetching recipes.", error)
            errorMessage = "Error while fetching recipes!"
            self.recipes = []
        }
    }

    func sortByNames() {
        sortingManager.sortByNames(recipes: &self.recipes)
    }

    func sortByCuisines() {
        sortingManager.sortByCuisine(recipes: &self.recipes)
    }
}
