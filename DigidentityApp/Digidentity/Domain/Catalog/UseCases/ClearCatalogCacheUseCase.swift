import Foundation

struct ClearCatalogCacheUseCase {
    private let repository: CatalogRepositoryProtocol

    init(repository: CatalogRepositoryProtocol) {
        self.repository = repository
    }

    func execute() throws {
        try repository.clearCachedItems()
    }
}
