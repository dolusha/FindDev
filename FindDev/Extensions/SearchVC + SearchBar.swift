//
//  SearchVC + SearchBar.swift
//  FindDev
//
//  Created by mac on 29.08.2026.
//

import Foundation
import UIKit
extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTask?.cancel()
        
        guard !searchText.isEmpty else {
            foundUser = nil
            tableView.reloadData()
            return
        }
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            guard !Task.isCancelled else { return }
            do {
                let user = try await FindGitHubService.fetchUser(for: searchText)
                guard !Task.isCancelled else { return }
                
                self.foundUser = user
                self.tableView.reloadData()
            } catch {
                self.foundUser = nil
                self.tableView.reloadData()
            }
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
