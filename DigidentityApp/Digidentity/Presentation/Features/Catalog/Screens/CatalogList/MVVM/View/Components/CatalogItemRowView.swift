import SwiftUI

struct CatalogItemRowView: View {
    let item: CatalogItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CatalogImageView(
                url: item.imageURL,
                size: 72
            )

            VStack(alignment: .leading, spacing: 8) {
                Text(item.text)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text("ID: \(item.id)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                CatalogConfidenceBadgeView(confidence: item.confidence)
            }

            Spacer(minLength: 8)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
                .padding(.top, 4)
        }
        .padding(.vertical, 6)
    }
}
