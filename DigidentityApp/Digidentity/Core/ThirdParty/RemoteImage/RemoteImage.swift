import UIKit

enum RemoteImage {
    private static let adapter: RemoteImagePort = SVGKitAdapter()

    static func loadImage(from url: URL, size: CGSize? = nil) async throws -> UIImage {
        try await adapter.loadImage(from: url, size: size)
    }
}
