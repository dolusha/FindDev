//
//  GitHubFollowItem.swift
//  FindDev
//
//  Created by mac on 30.08.2026.
//

import Foundation

struct GitHubFollowItem: Codable {
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
