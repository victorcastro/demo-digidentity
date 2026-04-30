import Foundation

enum Logger {
    static func error(_ message: String) {
        #if DEBUG
            print("Error: \(message)")
        #endif
    }
}
