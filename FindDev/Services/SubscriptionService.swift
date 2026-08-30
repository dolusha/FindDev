//
//  SubscriptionService.swift
//  FindDev
//
//  Created by mac on 30.08.2026.
//

import Foundation
import SwiftData

enum SubscriptionService {
    static func isFollowed(login: String, context: ModelContext) -> Bool {
        let descriptor = FetchDescriptor<FollowedUser>(predicate: #Predicate { $0.login == login })
        return !((try? context.fetch(descriptor)) ?? []).isEmpty
    }
    
    static func toggle(login: String, avatarUrl: String, isFollowed: Bool, context: ModelContext) {
        if isFollowed {
            context.insert(FollowedUser(login: login, avatarUrl: avatarUrl))
        } else {
            let descriptor = FetchDescriptor<FollowedUser>(predicate: #Predicate { $0.login == login })
            if let existing = try? context.fetch(descriptor).first {
                context.delete(existing)
            }
        }
        try? context.save()
    }
}
