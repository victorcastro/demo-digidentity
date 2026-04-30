import Foundation

enum CatalogError: Error, Equatable {
    case cacheUnavailable
    case remoteUnavailable
}
