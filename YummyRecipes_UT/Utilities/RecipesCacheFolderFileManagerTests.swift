import XCTest
@testable import YummyRecipes

final class RecipesCacheFolderFileManagerTests: XCTestCase {
    let testImagesFolder = "testImagesFolder"
    var recipeFileManager: RecipesCacheFolderFileManager?

    override func setUp() {
        recipeFileManager = RecipesCacheFolderFileManager(imagesFolderName: testImagesFolder)
    }

    override func tearDown() {
        recipeFileManager!.deleteImagesFolder(folderName: testImagesFolder)
        recipeFileManager = nil

    }

    func test_RecipesCacheFolderFileManager_SavesImageToAndGetImagFromCacheFolder() {
        let starImage = UIImage(systemName: "star")
        recipeFileManager!.saveImage(image: starImage!, imageName: "star")
        let retrievedImage = recipeFileManager!.getImage(imageName: "star")
        XCTAssertNotNil(retrievedImage)
    }
}
