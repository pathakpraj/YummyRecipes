import Foundation

/*
 {
             "cuisine": "Malaysian",
             "name": "Apam Balik",
             "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
             "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
             "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
             "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
             "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
         }
 
 */

struct RecipeModel: Identifiable, Codable {
    // Properties
    var cuisine: String
    var name: String
    var photoURLLarge: URL?
    var photoURLSmall: URL?
    var sourceURL: URL?
    var id: String // Unique identifier (uuid in the JSON)
    var youtubeURL: URL?
    
    // Coding keys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case id = "uuid"
        case youtubeURL = "youtube_url"
    }
}
