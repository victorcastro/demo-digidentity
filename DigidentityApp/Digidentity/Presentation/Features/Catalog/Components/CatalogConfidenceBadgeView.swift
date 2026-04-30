import SwiftUI

struct CatalogConfidenceBadgeView: View {
    let confidence: Double

    var body: some View {
        Text("Confidence: \(confidence.formatted(.number.precision(.fractionLength(2))))")
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(.tertiarySystemFill))
            .clipShape(Capsule())
            .foregroundStyle(.secondary)
    }
}
