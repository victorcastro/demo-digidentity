@testable import Digidentity
import Foundation
import Testing

@MainActor
struct CatalogListViewModelTests {
    @Test func loadFetchesItemsFromAPIWhenCacheIsEmpty() async {
        let apiClient = APIClientMock(
            fixtureNames: ["catalog_initial_response"]
        )
        let viewModel = makeViewModel(apiClient: apiClient)

        await viewModel.load()

        #expect(viewModel.state.items.count == 1)
        #expect(viewModel.state.items[0].id == "6915a61bcf23c")
        #expect(viewModel.state.errorMessage == nil)
    }

    @Test func loadHandlesEmptyRemoteResponse() async {
        let apiClient = APIClientMock(
            fixtureNames: ["catalog_empty_response"]
        )
        let viewModel = makeViewModel(apiClient: apiClient)

        await viewModel.load()

        #expect(viewModel.state.items.isEmpty)
        #expect(viewModel.state.errorMessage == nil)
        #expect(!viewModel.state.canLoadMore)
    }

    @Test func refreshReplacesItemsWithRemoteResponse() async {
        let apiClient = APIClientMock(
            fixtureNames: [
                "catalog_initial_response",
                "catalog_refresh_response"
            ]
        )
        let viewModel = makeViewModel(apiClient: apiClient)

        await viewModel.load()
        await viewModel.refresh()

        #expect(viewModel.state.items.map(\.id) == ["fresh"])
        #expect(viewModel.state.canLoadMore)
    }

    @Test func loadMoreAppendsOnlyNewItems() async {
        let apiClient = APIClientMock(
            fixtureNames: [
                "catalog_load_more_initial_response",
                "catalog_load_more_next_response"
            ]
        )
        let viewModel = makeViewModel(apiClient: apiClient)

        await viewModel.load()
        await viewModel.loadMoreIfNeeded(currentItem: viewModel.state.items.last)

        #expect(viewModel.state.items.map(\.id) == ["existing", "new"])
        #expect(viewModel.state.canLoadMore)
    }

    @Test func loadMoreStopsWhenNoNewItemsArrive() async {
        let apiClient = APIClientMock(
            fixtureNames: [
                "catalog_load_more_initial_response",
                "catalog_load_more_initial_response"
            ]
        )
        let viewModel = makeViewModel(apiClient: apiClient)

        await viewModel.load()
        await viewModel.loadMoreIfNeeded(currentItem: viewModel.state.items.last)

        #expect(viewModel.state.items.map(\.id) == ["existing"])
        #expect(!viewModel.state.canLoadMore)
    }

    private func makeViewModel(apiClient: APIClientMock) -> CatalogListViewModel {
        let cacheStore = FileCacheStore(directoryURL: temporaryCacheDirectory())
        let remoteDataSource = CatalogRemoteDataSource(apiClient: apiClient)
        let cacheDataSource = CatalogCacheDataSource(cacheStore: cacheStore)
        let repository = CatalogRepository(
            remoteDataSource: remoteDataSource,
            cacheDataSource: cacheDataSource
        )

        return CatalogListViewModel(
            fetchUseCase: FetchCatalogItemsUseCase(repository: repository),
            refreshUseCase: RefreshCatalogItemsUseCase(repository: repository),
            loadMoreUseCase: LoadMoreCatalogItemsUseCase(repository: repository),
            clearCacheUseCase: ClearCatalogCacheUseCase(repository: repository)
        )
    }

    private func temporaryCacheDirectory() -> URL {
        FileManager.default.temporaryDirectory
            .appending(path: "DigidentityTests-\(UUID().uuidString)")
    }
}

final class APIClientMock: APIClient {
    private var responseData: [Data]

    init(fixtureNames: [String]) {
        responseData = fixtureNames.map { FixtureLoader.loadData(named: $0) }
    }

    func send<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard !responseData.isEmpty else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: responseData.removeFirst())
    }
}

enum FixtureLoader {
    static func loadData(named fixtureName: String) -> Data {
        guard let url = Bundle(for: APIClientMock.self).url(
            forResource: fixtureName,
            withExtension: "json"
        ) else {
            preconditionFailure("Missing test fixture: \(fixtureName).json")
        }

        do {
            return try Data(contentsOf: url)
        } catch {
            preconditionFailure("Unable to load test fixture: \(fixtureName).json")
        }
    }
}
