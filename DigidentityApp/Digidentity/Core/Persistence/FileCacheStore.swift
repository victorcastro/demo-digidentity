import Foundation

final class FileCacheStore: CacheStore {
    private let directoryURL: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let fileManager: FileManager

    init(
        directoryURL: URL? = nil,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder(),
        fileManager: FileManager = .default
    ) {
        self.fileManager = fileManager
        self.encoder = encoder
        self.decoder = decoder

        if let directoryURL {
            self.directoryURL = directoryURL
        } else {
            self.directoryURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
                .appending(path: "DigidentityCache")
        }
    }

    func read<T: Decodable>(_ type: T.Type, forKey key: String) throws -> T? {
        let fileURL = fileURL(forKey: key)

        guard fileManager.fileExists(atPath: fileURL.path) else {
            return nil
        }

        let data = try Data(contentsOf: fileURL)
        return try decoder.decode(type, from: data)
    }

    func write<T: Encodable>(_ value: T, forKey key: String) throws {
        try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        let data = try encoder.encode(value)
        try data.write(to: fileURL(forKey: key), options: .atomic)
    }

    func delete(forKey key: String) throws {
        let fileURL = fileURL(forKey: key)

        guard fileManager.fileExists(atPath: fileURL.path) else {
            return
        }

        try fileManager.removeItem(at: fileURL)
    }

    private func fileURL(forKey key: String) -> URL {
        directoryURL.appending(path: "\(key).json")
    }
}
