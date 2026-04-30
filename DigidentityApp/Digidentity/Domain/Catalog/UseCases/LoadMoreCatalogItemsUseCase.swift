import Foundation

struct LoadMoreCatalogItemsUseCase {
    private let repository: CatalogRepositoryProtocol

    init(repository: CatalogRepositoryProtocol) {
        self.repository = repository
    }

    func execute(currentItems: [CatalogItem]) async throws -> [CatalogItem] {
        let remoteItems = try await repository.fetchItems()
        let currentIDs = Set(currentItems.map(\.id))

        return remoteItems.filter { !currentIDs.contains($0.id) }
    }
}
