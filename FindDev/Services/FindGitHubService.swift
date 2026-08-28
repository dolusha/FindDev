//
//  FindGitHubService.swift
//  FindDev
//
//  Created by mac on 28.08.2026.
//

import Foundation

enum FindGitHubService {
    static func fetchUser(for login: String) async throws -> GitHubUser {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/users/\(login)"
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        return try await NetworkManager.fetch(url)
    }
}
