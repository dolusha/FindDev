//
//  FullPageVC + CollectionView.swift
//  FindDev
//
//  Created by mac on 30.08.2026.
//

import Foundation
import UIKit

extension FullPageVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView === followingCollectionView
        ? followingList[indexPath.row]
        : followersList[indexPath.row]
        
        let nextVC = FullPageVC(login: item.login, modelContext: modelContext)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension FullPageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === followingCollectionView {
            return followingList.count
        } else {
            return followersList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowingGridCell", for: indexPath) as! FollowingGridCell
        let item = collectionView === followingCollectionView
        ? followingList[indexPath.row]
        : followersList[indexPath.row]
        cell.configure(login: item.login, avatarUrl: item.avatarUrl)
        return cell
    }
}
extension FullPageVC: UICollectionViewDelegateFlowLayout {
    
}
