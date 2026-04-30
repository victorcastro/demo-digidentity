import Foundation

final class CatalogRemoteDataSource {
    private let apiService: CatalogAPIServiceProtocol

    init(apiClient: APIClient) {
        apiService = CatalogAPIService(apiClient: apiClient)
    }

    init(apiService: CatalogAPIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchItems() async throws -> [CatalogItemDTO] {
        try await apiService.fetchItems()
    }
}
