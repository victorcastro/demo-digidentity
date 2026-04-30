import Foundation

final class AppContainer {
    private let urlSessionAPIClient: APIClient
    private let fileCacheStore: CacheStore

    init(
        urlSessionAPIClient: APIClient = URLSessionAPIClient(),
        fileCacheStore: CacheStore = FileCacheStore()
    ) {
        self.urlSessionAPIClient = urlSessionAPIClient
        self.fileCacheStore = fileCacheStore
    }

    func makeCatalogRepository() -> CatalogRepositoryProtocol {
        let remoteDataSource = CatalogRemoteDataSource(apiClient: urlSessionAPIClient)
        let cacheDataSource = CatalogCacheDataSource(cacheStore: fileCacheStore)

        return CatalogRepository(
            remoteDataSource: remoteDataSource,
            cacheDataSource: cacheDataSource
        )
    }
}
