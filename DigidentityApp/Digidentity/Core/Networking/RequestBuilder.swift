import Foundation

struct RequestBuilder {
    private let baseURL: URL

    init(baseURL: URL = Constants.API.baseURL) {
        self.baseURL = baseURL
    }

    func buildRequest(for endpoint: Endpoint) throws -> URLRequest {
        let url = baseURL.appending(path: endpoint.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems

        guard let requestURL = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = endpoint.method.rawValue
        request.setValue(Constants.API.authorizationToken, forHTTPHeaderField: "Authorization")
        endpoint.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}
