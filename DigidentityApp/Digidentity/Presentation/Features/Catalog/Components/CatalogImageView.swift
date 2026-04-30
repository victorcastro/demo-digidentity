import SwiftUI
import UIKit

struct CatalogImageView: View {
    let url: URL
    let size: CGFloat

    @State private var image: UIImage?
    @State private var isLoading = true

    var body: some View {
        content
            .task(id: url) {
                await loadImage()
            }
            .frame(width: size, height: size)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    @ViewBuilder
    private var content: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else if isLoading {
            ProgressView()
        } else {
            Image(systemName: "photo")
                .font(.title2)
                .foregroundStyle(.secondary)
        }
    }

    private func loadImage() async {
        isLoading = true
        image = try? await RemoteImage.loadImage(from: url, size: .init(width: size, height: size))
        isLoading = false
    }
}
