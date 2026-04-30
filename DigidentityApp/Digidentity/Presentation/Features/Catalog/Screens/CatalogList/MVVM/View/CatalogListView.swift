import SwiftUI

struct CatalogListView: View {
    @EnvironmentObject private var themeStore: ThemeStore
    @StateObject private var viewModel: CatalogListViewModel

    init(viewModel: CatalogListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            if viewModel.state.isLoading {
                ProgressView()
            } else {
                CatalogItemsListView(
                    items: viewModel.state.items,
                    isLoadingMore: viewModel.state.isLoadingMore,
                    emptyMessage: viewModel.state.errorMessage,
                    onRetry: {
                        await viewModel.load()
                    },
                    onLoadMoreIfNeeded: { item in
                        await viewModel.loadMoreIfNeeded(currentItem: item)
                    }
                )
            }
        }
        .navigationTitle("Catalog")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    themeStore.toggleColorScheme()
                } label: {
                    Image(systemName: themeStore.colorSchemeOverride == .dark ? "sun.max.fill" : "moon.stars.fill")
                }
                .accessibilityLabel(themeStore
                    .colorSchemeOverride == .dark ? "Switch to light mode" : "Switch to dark mode")
            }
        }
        .task {
            await viewModel.load()
        }
        .alert(
            "Catalog error",
            isPresented: Binding(
                get: { viewModel.state.errorMessage != nil && !viewModel.state.items.isEmpty },
                set: { _ in }
            )
        ) {
            Button("Close", role: .cancel) {}
            Button("Clear cache", role: .destructive) {
                viewModel.clearData()
            }
        } message: {
            Text(viewModel.state.errorMessage ?? "")
        }
    }
}
