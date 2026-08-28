//
//  NetworkManager.swift
//  FindDev
//
//  Created by mac on 28.08.2026.
//

import Foundation
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case rateLimit
    case notFound
}
enum NetworkManager {
    static func fetch<T: Decodable>(_ url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        switch response.statusCode {
        case 200...299: break
        case 429: throw NetworkError.rateLimit
        case 404: throw NetworkError.notFound
        case 500...599: throw NetworkError.invalidResponse
        default: throw NetworkError.invalidResponse
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.noData
        }
    }
}
