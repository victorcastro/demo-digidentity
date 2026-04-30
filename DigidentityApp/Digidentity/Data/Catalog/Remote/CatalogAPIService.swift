import Foundation

protocol CatalogAPIServiceProtocol {
    func fetchItems() async throws -> [CatalogItemDTO]
}

final class CatalogAPIService: CatalogAPIServiceProtocol {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchItems() async throws -> [CatalogItemDTO] {
        let endpoint = Endpoint(
            path: Constants.APIPaths.items
        )

        return try await apiClient.send(endpoint)
    }
}
