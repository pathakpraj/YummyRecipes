import XCTest
@testable import YummyRecipes

final class RecipeImageServiceTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    var fileManager: RecipesCacheFolderFileManager!

    override func setUp() {
        mockNetworkManager = MockNetworkManager(mockURLSession: MockURLSession())
        fileManager = RecipesCacheFolderFileManager(imagesFolderName: "testImagesFolder")
    }

    override func tearDown() {
        fileManager.deleteImagesFolder(folderName: "testImagesFolder")
    }

    func test_RecipesImageService_fetchImage_success() async throws {
        let sut = RecipeImageService(networkManager: mockNetworkManager, fileManager: fileManager)
        
        let testRecipe = MockTestData.recipe
        
        let image = await sut.fetchImage(recipe: testRecipe, imageType: .small)
        XCTAssertNotNil(image)
    }
}
