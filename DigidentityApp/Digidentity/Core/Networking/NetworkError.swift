import Foundation

enum NetworkError: Error, Equatable {
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed
}
