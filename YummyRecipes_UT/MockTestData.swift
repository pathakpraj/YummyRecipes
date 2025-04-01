import Foundation
@testable import YummyRecipes

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


class MockTestData {
    static let recipe = RecipeModel(cuisine: "Malaysian",
                                    name: "Apam Balik",
                                    photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                                    photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg" ),
                                    id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                                    youtubeURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg" ))


    static let recipeList: [RecipeModel] = [
        RecipeModel(cuisine: "Malaysian",
                    name: "Apam Balik1",
                    photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                    photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg" ),
                    id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    youtubeURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg" )),
        RecipeModel(cuisine: "American",
                    name: "Apam Balik2",
                    photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                    photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg" ),
                    id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    youtubeURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg" )),
        RecipeModel(cuisine: "Indian",
                    name: "Apam Balik3",
                    photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                    photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg" ),
                    id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    youtubeURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg" )),
        RecipeModel(cuisine: "Japanese",
                    name: "Apam Balik4",
                    photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                    photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg" ),
                    id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    youtubeURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg" ))
        ]
}
