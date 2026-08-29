//
//  FollowedUser.swift
//  FindDev
//
//  Created by mac on 29.08.2026.
//

import Foundation
import SwiftData

@Model
class FollowedUser {
    var login: String
    
    init(login: String) {
        self.login = login
    }
}
