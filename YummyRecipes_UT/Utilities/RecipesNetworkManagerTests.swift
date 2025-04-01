import XCTest
@testable import YummyRecipes

final class RecipesNetworkManagerTests: XCTestCase {

    func test_RecipesNetworkManager_downLoadRecipesFromURL_Success() async {
        let mockURLSession = MockURLSession()
        let sut = RecipesNetworkManager(session: mockURLSession)
        let expectation =  XCTestExpectation(description: "Fetching recipes.")
        guard let url = Bundle(for: Self.self).url(forResource: "Mock_Recipes", withExtension: ".json") else {
            XCTFail("Mock JSON file not found")
            return
        }
        do {
            let recipes = try await sut.downloadRecipes(url: url)
            XCTAssertEqual(recipes.count, 6)
            expectation.fulfill()
            await fulfillment(of: [expectation], timeout: 5)
        } catch {
            XCTFail("Error downloading recipes: \(error)")
            return
        }
    }

    func test_RecipesNetworkManager_FetchesRecipes_Error() async throws {
        let mockURLSession = MockURLSession()
        let sut = RecipesNetworkManager(session: mockURLSession)
        let expectation =  XCTestExpectation(description: "Fetching malformed recipes throws error.")
        guard let url = Bundle(for: Self.self).url(forResource: "Mock_Recipes_Malformed", withExtension: ".json") else {
            XCTFail("Mock JSON malformed file not found.")
            return
        }

        do {
            let recipes = try await sut.downloadRecipes(url: url)
            XCTAssertEqual(recipes.count, 0)
        } catch let error {
            XCTAssertNotNil(error)
            expectation.fulfill()
            await fulfillment(of: [expectation], timeout: 5)
            return
        }
    }

    func test_RecipesNetworkManager_FetchesRecipes_Empty() async throws {
        let mockURLSession = MockURLSession()
        let sut = RecipesNetworkManager(session: mockURLSession)
        let expectation =  XCTestExpectation(description: "Fetching empty recipes.")
        guard let url = Bundle(for: Self.self).url(forResource: "Mock_Recipes_EmptyList", withExtension: ".json") else {
            XCTFail("Mock JSON emptylist file not found.")
            return
        }

        do {
            let recipes = try await sut.downloadRecipes(url: url)
            XCTAssertEqual(recipes.count, 0)
        } catch let error {
            XCTFail("Error while fetching empty list of recipes: \(error).")
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5)
    }

    func test_RecipesNetworkManager_FetchesImage_Success() async throws {
        let url = URL(string: "mockURL.com")!
        let originalImage = UIImage(systemName: "star")!
        let originalData = originalImage.pngData()!
        let expectedImage = UIImage(data: originalData)!

        let mockData = originalData
        let mockResponse = HTTPURLResponse(url: URL(string: "mockURL.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

        let mockURLSession = MockURLSessionForImage()
        mockURLSession.data = mockData
        mockURLSession.response = mockResponse
        mockURLSession.error = nil

        let sut = RecipesNetworkManager(session: mockURLSession)
        let expectation =  XCTestExpectation(description: "Fetching image.")

        let downloadedImage = try await sut.downloadImage(url: url)
        XCTAssertNotNil(downloadedImage)
        XCTAssertEqual(expectedImage.pngData(), downloadedImage.pngData())
        expectation.fulfill()
    }

}
