import Foundation

struct FetchCatalogItemsUseCase {
    private let repository: CatalogRepositoryProtocol

    init(repository: CatalogRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [CatalogItem] {
        do {
            let cachedItems = try repository.cachedItems()

            if !cachedItems.isEmpty {
                return cachedItems
            }
        } catch {
            Logger.error("Cache read failed: \(error)")
        }

        return try await repository.fetchItems()
    }
}
