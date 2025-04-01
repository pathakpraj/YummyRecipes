import Foundation
import Combine
import SwiftUI

protocol NetworkManager {
    func downloadImage(url: URL) async throws -> UIImage
    func downloadRecipes(url: URL) async throws -> [RecipeModel]
}

// URLSession Protocol to make it mockable
protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

class RecipesNetworkManager: NetworkManager {
    let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case emptyResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad URL response from server from URL: \(url)"
            case .emptyResponse(url: let url): return "[⚠️] Empty response from server from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occured."
            }
        }
    }

    // MARK: downloading recipes Async
    func downloadRecipes(url: URL) async throws -> [RecipeModel] {
        do {
            let (data, _) = try await self.session.data(from: url)
            let recipesDict = try JSONDecoder().decode([String: [RecipeModel]].self, from: data)
            return recipesDict.values.first ?? []
        } catch let error {
            print(error.localizedDescription)
            throw error
        }
    }

     func downloadImage(url: URL) async throws -> UIImage {
        do {
            let (data, response) = try await self.session.data(from: url)
            let image = try handleAsyncResponse(data: data, response: response, url: url)
            return image
        } catch let error {
           throw error
        }
    }

    private func handleAsyncResponse(data: Data, response: URLResponse, url: URL) throws -> UIImage  {
        guard
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode == 200 && response.statusCode < 300 else {
            print("Bad server response")
            throw NetworkingError.badURLResponse(url: url)
        }

        if response.statusCode == 204 {
            throw NetworkingError.emptyResponse(url: url)
        }

        return image
    }
}
