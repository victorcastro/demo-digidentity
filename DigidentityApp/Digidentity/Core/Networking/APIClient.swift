import Foundation

protocol APIClient {
    func send<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class URLSessionAPIClient: APIClient {
    private let urlSession: URLSession
    private let requestBuilder: RequestBuilder
    private let decoder: JSONDecoder

    init(
        urlSession: URLSession = .shared,
        requestBuilder: RequestBuilder = RequestBuilder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.urlSession = urlSession
        self.requestBuilder = requestBuilder
        self.decoder = decoder
    }

    func send<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try requestBuilder.buildRequest(for: endpoint)
        let (data, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200 ... 299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
