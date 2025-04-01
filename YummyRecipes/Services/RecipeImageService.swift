import Foundation
import SwiftUI
import Combine

class RecipeImageService {
    private let networkManager: NetworkManager
    private let fileManager: RecipesFileManager

    enum ImageType {
        case small, large
    }

    private var image: UIImage?

    init(networkManager: NetworkManager, fileManager: RecipesFileManager ) {
        self.networkManager = networkManager
        self.fileManager = fileManager
    }

    func fetchImage(recipe: RecipeModel, imageType: ImageType) async -> UIImage? {
            switch imageType {
            case .small:
                await getRecipeSmallImage(recipe: recipe)
            case .large:
                await getRecipeLargeImage(recipe: recipe)
            }

            return self.image
        }

    private func getRecipeSmallImage(recipe: RecipeModel) async {
        let smallImageName = recipe.id + "_small.jpg"
        // try to get from image cache using file manager
        if let savedImage = fileManager.getImage(
            imageName: smallImageName) {
            image = savedImage
            print("Retrieved small image from file manager.")
        } else {                            // otherwise, download image
            if let url = recipe.photoURLSmall {
                do {
                    image = try await networkManager.downloadImage(url: url)

                    if let image = image {
                        saveReturnedImage(
                            image: image,
                            imageName: smallImageName)

                        print("downloaded small image")
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func getRecipeLargeImage(recipe: RecipeModel) async {
        let largeImageName = recipe.id + "_large.jpg"

        if let savedImage = fileManager.getImage(
            imageName: largeImageName) {
            image = savedImage
            print("Retrieved large image from file manager.")

        } else {
            if let url = recipe.photoURLLarge {
                do {
                    image = try await networkManager.downloadImage(url: url)
                    if let image = image {
                        saveReturnedImage(
                            image: image,
                            imageName: largeImageName)

                        print("downloaded large image")
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func saveReturnedImage(image: UIImage, imageName: String) {
        self.fileManager.saveImage(
            image: image,
            imageName: imageName
        )
    }
}
