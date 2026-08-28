//
//  GitHubUser.swift
//  FindDev
//
//  Created by mac on 28.08.2026.
//

import Foundation
struct GitHubUser: Codable {
    let login: String
    let name: String?
    let avatarUrl: String
    let bio: String?
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login, name, bio, followers, following
        case avatarUrl = "avatar_url"
    }
}
