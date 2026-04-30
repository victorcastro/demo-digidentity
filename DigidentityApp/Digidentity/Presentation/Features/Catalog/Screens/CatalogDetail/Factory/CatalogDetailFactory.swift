import SwiftUI

struct CatalogDetailFactory {
    @MainActor
    func makeView(item: CatalogItem) -> some View {
        CatalogDetailView(
            viewModel: CatalogDetailViewModel(item: item)
        )
    }
}
