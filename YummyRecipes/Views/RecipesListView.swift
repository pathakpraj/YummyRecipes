import SwiftUI

@MainActor
struct RecipesListView: View {
    let recipesURL: URL
    let networkManager: NetworkManager

    @StateObject private var viewModel: RecipesListViewModel

    init(recipesURL: URL, networkManager: NetworkManager) {
        self.recipesURL = recipesURL
        self.networkManager = networkManager
        _viewModel = StateObject(wrappedValue: RecipesListViewModel(networkManager: networkManager))
    }

    var body: some View {
        ZStack() {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                RecipesTitleView()
                
                Spacer()

                HStack {
                    Spacer()
                    sortByNamesButton
                    sortByCuisinesButton
                    Spacer()
                }

                HStack {
                    Spacer()
                    errorMessageView
                    Spacer()
                }

                recipesList
            }
        }
        .task {
                await viewModel.fetchRecipes(from: recipesURL)
        }
        .refreshable {
                await viewModel.fetchRecipes(from: recipesURL)
        }
    }

    private var sortByNamesButton: some View {
        Button {
            viewModel.sortByNames()
        } label: {
            Text("Name")
                .font(.caption)
                .padding()
            Image(systemName: viewModel.sortingManager.nameSortOption == .nameReversed ? "chevron.down" : "chevron.up")
                .padding(.trailing)
                .opacity(viewModel.sortingManager.isSortByNamesSelected ? 1 : 0)
        }
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(5)
    }

    private var sortByCuisinesButton: some View {
        Button {
            viewModel.sortByCuisines()
        } label: {
            Text("Cuisine")
                .font(.caption)
                .padding()
            Image(systemName: viewModel.sortingManager.cuisineSortOption == .cusineReversed ? "chevron.down" : "chevron.up")
                .padding(.trailing)
                .opacity(viewModel.sortingManager.isSortByCusinesSelected ? 1 : 0)
        }
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(5)
    }

    private var recipesList: some View {
        List {
            ForEach(viewModel.recipes) {recipe in
                RecipeRowView(recipe: recipe, networkManager: networkManager)
                    .alignmentGuide(.listRowSeparatorLeading) { d in
                        d[.leading]
                }
            }
        }
        .listStyle(.plain)
    }

    @ViewBuilder
    private var errorMessageView: some View {
        if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.red)
        }
        EmptyView()
    }
}

#Preview {
    RecipesListView(recipesURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!, networkManager: RecipesNetworkManager())
}
