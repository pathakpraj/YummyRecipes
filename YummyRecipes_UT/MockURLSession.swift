import Foundation
@testable import YummyRecipes

// Mock URLSession for testing
class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: HTTPURLResponse?
    var mockError: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        mockData = NSData(contentsOf: url) as Data?
        return (mockData ?? Data(), mockResponse ?? HTTPURLResponse())
    }
}

class MockURLSessionForURL: URLSessionProtocol {
    var lastURL: URL?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        lastURL = url
        return (Data(), URLResponse())
    }
}

// Mock URLSession for testing images
class MockURLSessionForImage: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: (any Error)?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}
