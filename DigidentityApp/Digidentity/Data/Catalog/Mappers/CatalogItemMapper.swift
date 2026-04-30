import Foundation

enum CatalogItemMapper {
    static func map(_ dto: CatalogItemDTO) -> CatalogItem? {
        guard let imageURL = URL(string: dto.image) else {
            return nil
        }

        return CatalogItem(
            id: dto.id,
            text: dto.text,
            confidence: dto.confidence,
            imageURL: imageURL
        )
    }
}
