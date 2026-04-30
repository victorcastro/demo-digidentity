import Foundation

enum CatalogListError: LocalizedError {
    case load
    case refresh
    case loadMore
    case clearCache

    var errorDescription: String? {
        switch self {
        case .load:
            "Unable to load catalog items."
        case .refresh:
            "Unable to refresh catalog items."
        case .loadMore:
            "Unable to load more catalog items."
        case .clearCache:
            "Unable to clear catalog cache."
        }
    }
}
