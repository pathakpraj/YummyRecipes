import XCTest
@testable import YummyRecipes

final class RecipesSmallImageViewModel_Tests: XCTestCase {
    var mockNetworkManager: NetworkManager?
    var mockURLSessionForImage: MockURLSessionForImage?
    var recipeFileManager: RecipesCacheFolderFileManager?
    var recipe: RecipeModel?
    
    override func setUp() {
        mockURLSessionForImage = MockURLSessionForImage()
        mockNetworkManager = MockNetworkManager(mockURLSession: mockURLSessionForImage!)
        recipeFileManager = RecipesCacheFolderFileManager(imagesFolderName: "testImagesFolder")
        recipe = MockTestData.recipe
        recipe?.photoURLSmall = URL(string: "https://example.com/image.jpg")!
    }
    
    override func tearDown() {
        mockURLSessionForImage = nil
        mockNetworkManager = nil
        recipeFileManager?.deleteImagesFolder(folderName: "testImagesFolder")
        recipeFileManager = nil
        recipe = nil
        super.tearDown()
    }
    func test_RecipeSmallImageViewModel_Image_NilByDefault() {
        let sut = RecipeSmallImageViewModel(recipe: recipe!, networkManager: mockNetworkManager!, fileManager: recipeFileManager!)
        XCTAssertNil(sut.image)
    }
    
    
    func test_RecipeSmallImageViewModel_IsLoading_FalseByDefault() {
        let sut = RecipeSmallImageViewModel(recipe: recipe!, networkManager: mockNetworkManager!, fileManager: recipeFileManager!)
        XCTAssertFalse(sut.isLoading)
    }

    func test_downloadImage_Successful() async {
        let originalImage = UIImage(systemName: "star")!
        let originalData = originalImage.pngData()!
        let expectedImage = UIImage(data: originalData)!

        mockURLSessionForImage?.data = originalData
        mockURLSessionForImage?.response = HTTPURLResponse(url: URL(string: "mockURL.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

        let sut = RecipeSmallImageViewModel(recipe: recipe!, networkManager: mockNetworkManager!, fileManager: recipeFileManager!)
        await sut.fetchImageAsync()
        XCTAssertNotNil(sut.image)
        XCTAssertEqual(sut.image?.pngData(), expectedImage.pngData())
    }
}
