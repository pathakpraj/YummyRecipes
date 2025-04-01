import Foundation

class RecipesSortingManager {
    var nameSortOption: NamesSortOptions = .nameReversed
    var cuisineSortOption: CusineSortOptions = .cuisine
    var isSortByNamesSelected: Bool = true
    var isSortByCusinesSelected: Bool = false

    enum NamesSortOptions {
        case name, nameReversed
    }

    enum CusineSortOptions {
        case cuisine, cusineReversed
    }

    private func sortRecipesWithNames(recipes: inout [RecipeModel]) {
        switch nameSortOption {
        case .name:
            recipes.sort { $0.name < $1.name }
        case .nameReversed:
            recipes.sort { $0.name > $1.name }
        }
    }

    private func sortRecipesWithCusines(recipes: inout [RecipeModel]) {
        switch cuisineSortOption {
        case .cuisine:
           recipes.sort { $0.cuisine < $1.cuisine }
        case .cusineReversed:
            recipes.sort { $0.cuisine > $1.cuisine }
        }
    }

    private func toggleNamesSortOption() {
        nameSortOption = nameSortOption == .name ? .nameReversed : .name
    }

    private func toggleCusineSortOption() {
        cuisineSortOption = cuisineSortOption == .cuisine ? .cusineReversed : .cuisine
    }

    func sortByNames(recipes: inout [RecipeModel]) {
        isSortByCusinesSelected = false
        if isSortByNamesSelected == false {
            isSortByNamesSelected = true
        } else {
            toggleNamesSortOption()
        }
        sortRecipesWithNames(recipes: &recipes)
    }

    func sortByCuisine(recipes: inout [RecipeModel]) {
        isSortByNamesSelected = false
        if isSortByCusinesSelected == false {
            isSortByCusinesSelected = true
        } else {
            toggleCusineSortOption()
        }
        sortRecipesWithCusines(recipes: &recipes)
    }

}
