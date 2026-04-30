import Foundation

struct CatalogItem: Identifiable, Equatable, Hashable, Codable {
    let id: String
    let text: String
    let confidence: Double
    let imageURL: URL
}
