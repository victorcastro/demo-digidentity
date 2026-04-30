import SwiftUI

struct CatalogListFactory {
    private let repository: CatalogRepositoryProtocol

    init(repository: CatalogRepositoryProtocol) {
        self.repository = repository
    }

    @MainActor
    func makeView() -> some View {
        let viewModel = CatalogListViewModel(
            fetchUseCase: FetchCatalogItemsUseCase(repository: repository),
            refreshUseCase: RefreshCatalogItemsUseCase(repository: repository),
            loadMoreUseCase: LoadMoreCatalogItemsUseCase(repository: repository),
            clearCacheUseCase: ClearCatalogCacheUseCase(repository: repository)
        )

        return CatalogListView(viewModel: viewModel)
    }
}
