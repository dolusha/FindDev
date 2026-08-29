//
//  MainTabBarController.swift
//  FindDev
//
//  Created by mac on 29.08.2026.
//

import Foundation
import UIKit
import SwiftData
class MainTabBarController: UITabBarController {
    private let modelContext: ModelContext
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let searchVC = SearchVC(modelContext: modelContext)
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "Find", image: UIImage(systemName: "sparkle.magnifyingglass"), tag: 0)
        
        let youVC = YouVC(modelContext: modelContext)
        let youNav = UINavigationController(rootViewController: youVC)
        youNav.tabBarItem = UITabBarItem(title: "You", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        
        viewControllers = [searchNav, youNav]
    }
}
