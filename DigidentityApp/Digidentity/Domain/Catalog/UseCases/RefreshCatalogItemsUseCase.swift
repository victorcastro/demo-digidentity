import Foundation

struct RefreshCatalogItemsUseCase {
    private let repository: CatalogRepositoryProtocol

    init(repository: CatalogRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [CatalogItem] {
        try await repository.fetchItems()
    }
}
