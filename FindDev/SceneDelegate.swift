//
//  SceneDelegate.swift
//  FindDev
//
//  Created by mac on 28.08.2026.
//

import UIKit
import SwiftData
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var modelContainer: ModelContainer!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
            
        modelContainer = try! ModelContainer(for: FollowedUser.self)
            
        let tabBarController = MainTabBarController(modelContext: modelContainer.mainContext)
            
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

