//
//  SearchVC + TableView.swift
//  FindDev
//
//  Created by mac on 29.08.2026.
//

import Foundation
import SwiftData
import UIKit
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundUser != nil ? 1 : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitHubUserCell", for: indexPath) as! GitHubUserCell
        if let user = foundUser {
            let isFollowed = checkIfFollowed(login: user.login)
            cell.configure(with: user, isFollowed: isFollowed)
            cell.onSubscribeTapped = { [weak self] newState in
                self?.updateSubscription(user: user, isFollowed: newState)
            }
            cell.onVisitTapped = { [weak self] in
                let fullPageVC = FullPageVC()
                self?.navigationController?.pushViewController(fullPageVC, animated: true)
            }
        }
        return cell
    }
}
extension SearchVC {
    private func checkIfFollowed(login: String) -> Bool {
            let descriptor = FetchDescriptor<FollowedUser>(predicate: #Predicate { $0.login == login })
            let results = (try? modelContext.fetch(descriptor)) ?? []
            return !results.isEmpty
        }
    private func updateSubscription(user: GitHubUser, isFollowed: Bool) {
            if isFollowed {
                let newFollow = FollowedUser(login: user.login, avatarUrl: user.avatarUrl)
                modelContext.insert(newFollow)
            } else {
                let descriptor = FetchDescriptor<FollowedUser>(predicate: #Predicate { $0.login == user.login })
                if let existing = try? modelContext.fetch(descriptor).first {
                    modelContext.delete(existing)
                }
            }
            try? modelContext.save()
        }
}
