import SwiftUI

struct CatalogItemsListView: View {
    let items: [CatalogItem]
    let isLoadingMore: Bool
    let emptyMessage: String?
    let onRetry: (() async -> Void)?
    let onLoadMoreIfNeeded: (CatalogItem) async -> Void

    var body: some View {
        if items.isEmpty {
            emptyState
        } else {
            itemsList
        }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            ContentUnavailableView(
                "No catalog items",
                systemImage: "shippingbox",
                description: Text(emptyMessage ?? "Pull to refresh or try again later.")
            )

            if let onRetry {
                HStack {
                    Spacer()

                    Button("Try again") {
                        Task {
                            await onRetry()
                        }
                    }
                    .buttonStyle(.borderedProminent)

                    Spacer()
                }
            }
            
            Spacer()
        }
    }

    private var itemsList: some View {
        List(items) { item in
            NavigationLink(value: CatalogRoute.detail(item)) {
                CatalogItemRowView(
                    item: item
                )
            }
            .task {
                await onLoadMoreIfNeeded(item)
            }
        }
        .overlay(alignment: .bottom) {
            if isLoadingMore {
                ProgressView()
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(Capsule())
            }
        }
    }
}
