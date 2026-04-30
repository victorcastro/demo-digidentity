import Foundation

struct CatalogListState: Equatable {
    var items: [CatalogItem] = []
    var isLoading = false
    var isRefreshing = false
    var isLoadingMore = false
    var canLoadMore = true
    var errorMessage: String?
}
