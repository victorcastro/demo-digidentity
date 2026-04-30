import UIKit

protocol RemoteImagePort {
    func loadImage(from url: URL, size: CGSize?) async throws -> UIImage
}

enum ImageLoadingError: Error {
    case failed
}
