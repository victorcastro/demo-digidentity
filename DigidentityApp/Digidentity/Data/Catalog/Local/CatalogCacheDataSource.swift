import Foundation

final class CatalogCacheDataSource {
    private let cacheStore: CacheStore
    private let cacheKey = "catalog_items"

    init(cacheStore: CacheStore) {
        self.cacheStore = cacheStore
    }

    func readItems() throws -> [CatalogItem] {
        try cacheStore.read([CatalogItem].self, forKey: cacheKey) ?? []
    }

    func saveItems(_ items: [CatalogItem]) throws {
        try cacheStore.write(items, forKey: cacheKey)
    }

    func clearItems() throws {
        try cacheStore.delete(forKey: cacheKey)
    }
}
