import Foundation

protocol CatalogRepositoryProtocol {
    func cachedItems() throws -> [CatalogItem]
    func fetchItems() async throws -> [CatalogItem]
    func clearCachedItems() throws
}
