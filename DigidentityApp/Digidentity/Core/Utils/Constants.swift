import Foundation

enum Constants {
    enum API {
        static let host = "https://marlove.net"
        static let basePath = "e/mock/v1"

        static var authorizationToken: String {
            guard let token = Bundle.main.object(forInfoDictionaryKey: "CatalogAuthorizationToken") as? String,
                  !token.isEmpty
            else {
                preconditionFailure("Missing AUTH_TOKEN build setting")
            }

            return token
        }

        static let hostURL: URL = {
            guard let url = URL(string: host) else {
                preconditionFailure("Invalid catalog API host")
            }

            return url
        }()

        static var baseURL: URL {
            hostURL.appending(path: basePath)
        }
    }

    enum APIPaths {
        static let items = "items"
    }
}
