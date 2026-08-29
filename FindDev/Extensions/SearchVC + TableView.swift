//
//  SearchVC + TableView.swift
//  FindDev
//
//  Created by mac on 29.08.2026.
//

import Foundation
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
            cell.configure(with: user)
            cell.onVisitTapped = { [weak self] in
                let fullPageVC = FullPageVC()
                self?.navigationController?.pushViewController(fullPageVC, animated: true)
            }
            
        }
        return cell
    }
}
