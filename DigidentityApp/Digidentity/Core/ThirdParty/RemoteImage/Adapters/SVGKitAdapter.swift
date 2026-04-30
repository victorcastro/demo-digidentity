import SVGKit
import UIKit

final class SVGKitAdapter: RemoteImagePort {
    func loadImage(from url: URL, size: CGSize?) async throws -> UIImage {
        try await Task.detached(priority: .userInitiated) {
            guard let svgImage = SVGKImage(contentsOf: url),
                  let image = svgImage.uiImage
            else {
                throw ImageLoadingError.failed
            }

            return image
        }.value
    }
}
