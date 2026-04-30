import Combine
import Foundation

@MainActor
final class CatalogListViewModel: ObservableObject {
    @Published private(set) var state = CatalogListState()

    private let fetchUseCase: FetchCatalogItemsUseCase
    private let refreshUseCase: RefreshCatalogItemsUseCase
    private let loadMoreUseCase: LoadMoreCatalogItemsUseCase
    private let clearCacheUseCase: ClearCatalogCacheUseCase

    init(
        fetchUseCase: FetchCatalogItemsUseCase,
        refreshUseCase: RefreshCatalogItemsUseCase,
        loadMoreUseCase: LoadMoreCatalogItemsUseCase,
        clearCacheUseCase: ClearCatalogCacheUseCase
    ) {
        self.fetchUseCase = fetchUseCase
        self.refreshUseCase = refreshUseCase
        self.loadMoreUseCase = loadMoreUseCase
        self.clearCacheUseCase = clearCacheUseCase
    }

    func load() async {
        guard state.items.isEmpty, !state.isLoading else {
            return
        }

        state.isLoading = true
        state.errorMessage = nil

        do {
            let items = try await fetchUseCase.execute()
            state.items = items
            state.canLoadMore = !items.isEmpty
        } catch {
            setError(CatalogListError.load)
        }

        state.isLoading = false
    }

    func refresh() async {
        guard !state.isRefreshing else {
            return
        }

        state.isRefreshing = true
        state.errorMessage = nil

        do {
            let items = try await refreshUseCase.execute()
            state.items = items
            state.canLoadMore = !items.isEmpty
        } catch {
            setError(CatalogListError.refresh)
        }

        state.isRefreshing = false
    }

    func loadMoreIfNeeded(currentItem: CatalogItem?) async {
        guard let currentItem,
              currentItem.id == state.items.last?.id,
              state.canLoadMore,
              !state.isLoadingMore,
              !state.isLoading,
              !state.isRefreshing
        else {
            return
        }

        state.isLoadingMore = true

        do {
            let newItems = try await loadMoreUseCase.execute(currentItems: state.items)

            if newItems.isEmpty {
                state.canLoadMore = false
            } else {
                state.items.append(contentsOf: newItems)
            }
        } catch {
            setError(CatalogListError.loadMore)
        }

        state.isLoadingMore = false
    }

    private func setError(_ error: CatalogListError) {
        state.errorMessage = error.errorDescription
    }

    func clearData() {
        do {
            try clearCacheUseCase.execute()
            state.items = []
            state.canLoadMore = true
            state.errorMessage = nil
        } catch {
            setError(CatalogListError.clearCache)
        }
    }
}
