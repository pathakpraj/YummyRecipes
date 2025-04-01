import XCTest
@testable import YummyRecipes

@MainActor
final class RecipesListViewModel_Tests: XCTestCase {
    var networkManager: NetworkManager?
    var mockURLSession: URLSessionProtocol?
    var viewModel: RecipesListViewModel?

    override func setUp() {
        mockURLSession = MockURLSession()
        networkManager = MockNetworkManager(mockURLSession: mockURLSession!)
        viewModel = RecipesListViewModel(networkManager: networkManager!)
    }

    override func tearDown() {
        mockURLSession = nil
        networkManager = nil
        viewModel = nil
        super.tearDown()
    }

    func test_RecipesListViewModel_recipes_isEmptyByDefault() async {
        guard let sut = viewModel else {
            XCTFail("View Model is nil.")
            return
        }

        XCTAssertTrue(sut.recipes.isEmpty)
    }

    func test_RecipesListViewModel_FetchesRecipes_Success() async throws {
        let sut = RecipesListViewModel(networkManager: networkManager!)
        let expectation =  XCTestExpectation(description: "Fetching recipes.")
        guard let url = Bundle(for: Self.self).url(forResource: "Mock_Recipes", withExtension: ".json") else {
            XCTFail("Mock JSON file not found")
            return
        }
        await sut.fetchRecipes(from: url)
        XCTAssertEqual(sut.recipes.count, 6)
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5)
    }

    func test_RecipesListViewModel_FetchesRecipes_Error() async throws {
        let sut = RecipesListViewModel(networkManager: networkManager!)
        let expectation =  XCTestExpectation(description: "Fetching malformed recipes throws error.")
        guard let url = Bundle(for: Self.self).url(forResource: "Mock_Recipes_Malformed", withExtension: ".json") else {
            XCTFail("Mock JSON malformed file not found.")
            return
        }

        await sut.fetchRecipes(from: url)

        XCTAssertEqual(sut.errorMessage, "Error while fetching recipes!")
        XCTAssertEqual(sut.recipes.count, 0)
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5)
    }

    func test_RecipesListViewModel_FetchesRecipes_returnsEmptyList() async throws {
        let sut = RecipesListViewModel(networkManager: networkManager!)
        let expectation =  XCTestExpectation(description: "Fetching empty recipes.")
        guard let url = Bundle(for: Self.self).url(forResource: "Mock_Recipes_EmptyList", withExtension: ".json") else {
            XCTFail("Mock JSON Empty list file not found.")
            return
        }

        await sut.fetchRecipes(from: url)

        XCTAssertEqual(sut.recipes.count, 0)
        XCTAssertEqual(sut.errorMessage, "Sorry! No recipes found.")
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5)
    }
}
