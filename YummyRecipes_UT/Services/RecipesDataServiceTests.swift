import XCTest
@testable import YummyRecipes

final class RecipesDataServiceTests: XCTestCase {

    func test_RecipesDataService_DownloadRecipes_Success() async {
        let mockURLSession = MockURLSession()
        let networkManager = MockNetworkManager(mockURLSession: mockURLSession)

        let expectation =  XCTestExpectation(description: "Fetching recipes.")
        guard let url = Bundle(for: Self.self).url(forResource: "Mock_Recipes", withExtension: ".json") else {
            XCTFail("Mock JSON file not found")
            return
        }

        let sut = RecipesDataService(networkManager: networkManager)
        do {
            try await sut.downloadRecipes(from: url)
            XCTAssertEqual(sut.allRecipes.count, 6)
            expectation.fulfill()
            await fulfillment(of: [expectation], timeout: 5)
        } catch {
            XCTFail("Error downloading recipes: \(error)")
            return
        }
    }

}
