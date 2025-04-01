import Combine
import Foundation
import SwiftUI
@testable import YummyRecipes

class  MockNetworkManager: NetworkManager {
    let mockURLSession: URLSessionProtocol

    init(mockURLSession: URLSessionProtocol) {
        self.mockURLSession = mockURLSession
    }
    
    func downloadImage(url: URL) async throws -> UIImage {
       do {
           let (data, _) = try await self.mockURLSession.data(from: url)
           let image = UIImage(data: data)!
           return image
       } catch let error {
          throw error
       }
   }

    func downloadRecipes(url: URL) async throws -> [YummyRecipes.RecipeModel] {
        let (data, _) = try await mockURLSession.data(from: url)
        let recipesDict = try JSONDecoder().decode([String: [RecipeModel]].self, from: data)
        return recipesDict.values.first ?? []
    }



}
