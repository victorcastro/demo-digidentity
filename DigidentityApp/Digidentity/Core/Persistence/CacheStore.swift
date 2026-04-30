import Foundation

protocol CacheStore {
    func read<T: Decodable>(_ type: T.Type, forKey key: String) throws -> T?
    func write<T: Encodable>(_ value: T, forKey key: String) throws
    func delete(forKey key: String) throws
}
