//
//  UIButton + SubscribeStyle.swift
//  FindDev
//
//  Created by mac on 30.08.2026.
//

import Foundation
import UIKit

extension UIButton {
    func configureSubscribeStyle(isFollowed: Bool) {
        var config = UIButton.Configuration.filled()
        config.title = isFollowed ? "Following" : "Subscribe"
        config.baseBackgroundColor = isFollowed ? .systemGray4 : UIColor(hex: "D80808")
        config.baseForegroundColor = isFollowed ? .darkGray : .white
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        self.configuration = config
    }
}
