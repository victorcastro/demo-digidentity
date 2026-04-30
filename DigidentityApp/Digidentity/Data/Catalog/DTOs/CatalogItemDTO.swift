import Foundation

struct CatalogItemDTO: Codable, Equatable {
    let text: String
    let confidence: Double
    let image: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case text
        case confidence
        case image
        case id = "_id"
    }
}
