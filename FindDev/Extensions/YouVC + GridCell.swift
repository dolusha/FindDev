//
//  YouVC + GridCell.swift
//  FindDev
//
//  Created by mac on 30.08.2026.
//

import Foundation
import UIKit
import SwiftData
extension YouVC: UICollectionViewDelegate {
    // TODO: visit full page
}
extension YouVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followedUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowingGridCell", for: indexPath) as! FollowingGridCell
        let user = followedUsers[indexPath.row]
        cell.configure(login: user.login, avatarUrl: user.avatarUrl)
        return cell
    }
}
extension YouVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16
        let itemWidth = (collectionView.bounds.width - spacing) / 2
        return CGSize(width: itemWidth, height: itemWidth + 30)
    }
}
