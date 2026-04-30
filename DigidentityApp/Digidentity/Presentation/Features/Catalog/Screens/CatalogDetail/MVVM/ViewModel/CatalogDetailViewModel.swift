import Combine
import Foundation

@MainActor
final class CatalogDetailViewModel: ObservableObject {
    @Published private(set) var state: CatalogDetailState

    init(item: CatalogItem) {
        state = CatalogDetailState(item: item)
    }
}
