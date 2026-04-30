import Foundation

final class CatalogRepository: CatalogRepositoryProtocol {
    private let remoteDataSource: CatalogRemoteDataSource
    private let cacheDataSource: CatalogCacheDataSource

    init(
        remoteDataSource: CatalogRemoteDataSource,
        cacheDataSource: CatalogCacheDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.cacheDataSource = cacheDataSource
    }

    func cachedItems() throws -> [CatalogItem] {
        try cacheDataSource.readItems()
    }

    func fetchItems() async throws -> [CatalogItem] {
        let remoteItems = try await remoteDataSource.fetchItems()
            .compactMap(CatalogItemMapper.map)

        try cacheDataSource.saveItems(remoteItems)
        return remoteItems
    }

    func clearCachedItems() throws {
        try cacheDataSource.clearItems()
    }
}
