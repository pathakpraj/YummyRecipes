import XCTest
@testable import YummyRecipes

final class RecipesSortingManagerTests: XCTestCase {

    func test_RecipesSortingManager_nameSortOption_isNameByDefault() {
        let sut = RecipesSortingManager()
        XCTAssertEqual(sut.nameSortOption, .nameReversed)
    }

    func test_RecipesSortingManager_cuisineSortOption_IsCuisineByDefault() {
        let sut = RecipesSortingManager()
        XCTAssertEqual(sut.cuisineSortOption, .cuisine)
    }

    func test_RecipesSortingManager_isSortByNameSelected_IsTrueByDefault() {
        let sut = RecipesSortingManager()
        XCTAssertTrue(sut.isSortByNamesSelected)
    }

    func test_RecipesSortingManager_isSortByCuisineSelected_IsFalseByDefault() {
        let sut = RecipesSortingManager()
        XCTAssertFalse(sut.isSortByCusinesSelected)
    }

    func test_RecipesSortingManager_sortByNameSelected_sortsbyNames() {
        let sut = RecipesSortingManager()

        var recipeList = MockTestData.recipeList
        sut.sortByNames(recipes: &recipeList)

        XCTAssertTrue(sut.isSortByNamesSelected)
        XCTAssertEqual(sut.nameSortOption, .name)
        XCTAssertFalse(sut.isSortByCusinesSelected)
        let names = recipeList.map({$0.name})
        XCTAssertTrue(names.elementsEqual(["Apam Balik1", "Apam Balik2", "Apam Balik3", "Apam Balik4"]))

    }

    func test_RecipesSortingManager_sortByNameSelectedTwice_reverseSortsListByNames() {
        let sut = RecipesSortingManager()

        var recipeList = MockTestData.recipeList
        let originalNames = recipeList.map({$0.name})
        XCTAssertTrue(originalNames.elementsEqual(["Apam Balik1", "Apam Balik2", "Apam Balik3", "Apam Balik4"]))

        sut.sortByNames(recipes: &recipeList)
        sut.sortByNames(recipes: &recipeList)

        XCTAssertTrue(sut.isSortByNamesSelected)
        XCTAssertEqual(sut.nameSortOption, .nameReversed)
        XCTAssertFalse(sut.isSortByCusinesSelected)
        let names = recipeList.map({$0.name})
        XCTAssertTrue(names.elementsEqual(["Apam Balik4", "Apam Balik3", "Apam Balik2", "Apam Balik1"]))
    }

    func test_RecipesSortingManager_sortByCuisineSelected_sortsListByCuisine() {
        let sut = RecipesSortingManager()

        var recipeList = MockTestData.recipeList
        sut.sortByCuisine(recipes: &recipeList)

        XCTAssertTrue(sut.isSortByCusinesSelected)
        XCTAssertFalse(sut.isSortByNamesSelected)
        XCTAssertEqual(sut.cuisineSortOption, .cuisine)

        let cuisines = recipeList.map({$0.cuisine})
        XCTAssertTrue(cuisines.elementsEqual(["American", "Indian", "Japanese", "Malaysian"]))
    }

    func test_RecipesSortingManager_sortByCuisineSelectedTwice_reverseSortsListByCuisine() {
        let sut = RecipesSortingManager()

        var recipeList = MockTestData.recipeList
        sut.sortByCuisine(recipes: &recipeList)
        sut.sortByCuisine(recipes: &recipeList)

        XCTAssertTrue(sut.isSortByCusinesSelected)
        XCTAssertFalse(sut.isSortByNamesSelected)
        XCTAssertEqual(sut.cuisineSortOption, .cusineReversed)

        let cuisines = recipeList.map({$0.cuisine})
        XCTAssertTrue(cuisines.elementsEqual(["Malaysian", "Japanese", "Indian", "American"]))
    }
}
