import Foundation
import SwiftUI

protocol RecipesFileManager {
    func saveImage(image: UIImage, imageName: String)
    func getImage(imageName: String) -> UIImage?
}


class RecipesCacheFolderFileManager: RecipesFileManager {
    let imagesFolderName: String


    init(imagesFolderName: String = "YummyRecipesImages") {
        self.imagesFolderName = imagesFolderName
    }

    func saveImage(image: UIImage, imageName: String) {
        saveImageInCacheFolder(image: image, imageName: imageName, folderName: imagesFolderName)
    }

    func getImage(imageName: String) -> UIImage? {
        getImage(imageName: imageName, folderName: imagesFolderName)
    }

    func saveImageInCacheFolder(image: UIImage, imageName: String, folderName: String) {
        guard
            let data = image.jpegData(compressionQuality: .leastNormalMagnitude),
            let url = getURLForImage(imageName: imageName, folderName: folderName) else {
            return
        }
        
        do {
            createFolderIfNeeded(folderName: folderName)
            try data.write(to: url)
        } catch let error {
            print("Error saving image. \(error.localizedDescription)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let imageURL = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: imageURL.path())
        else {
            return nil
        }

        return UIImage(contentsOfFile: imageURL.path())
    }
    
    
    private func createFolderIfNeeded(folderName: String) {
        guard let folderURL = getURLForFolder(foldername: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: folderURL.path()) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating folder. FolderName: \(folderName): \(error.localizedDescription)")
            }
        }
    }
    
    private func getURLForFolder(foldername: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(foldername)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(foldername: folderName) else {
            return nil
        }
        print(folderURL)
        return folderURL.appendingPathComponent(imageName + ".jpg")
    }

    func deleteImagesFolder(folderName: String) {
        guard let folderURL = getURLForFolder(foldername: folderName) else {
            return
        }
        let folderPath = folderURL.path()
        print(folderPath)

        if FileManager.default.fileExists(atPath: folderPath) {
            do {
                try FileManager.default.removeItem(atPath: folderPath)
            } catch let error {
                debugPrint("Error deleting images folder at \(folderURL.path()): \(error)")
            }
        }
    }

}
