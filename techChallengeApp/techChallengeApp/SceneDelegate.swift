//
//  SceneDelegate.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let firstScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: firstScene)
        
        
        var trendingViewController = TrendingViewController()
        let trendingNavigationController = UINavigationController(rootViewController: trendingViewController)
        trendingNavigationController.navigationBar.isHidden = true
        trendingNavigationController.navigationBar.barTintColor = AppColors.tab.color
        trendingNavigationController.navigationBar.tintColor = AppColors.white.color
        trendingNavigationController.navigationBar.isTranslucent = false
        
        
        trendingNavigationController.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(systemName: "star")?.withTintColor(AppColors.white.color), tag: 0)
        
        var favoriteViewController = FavoritesViewController()
        let favoritesNavigationController = UINavigationController(rootViewController: favoriteViewController)
        favoritesNavigationController.navigationBar.isHidden = true
        favoritesNavigationController.navigationBar.barTintColor = AppColors.tab.color
        favoritesNavigationController.navigationBar.tintColor = AppColors.white.color
        favoritesNavigationController.navigationBar.isTranslucent = false

        
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart")?.withTintColor(AppColors.white.color), tag: 0)
        
        let tabBarController = UITabBarController()
        let controllers = [trendingNavigationController,favoritesNavigationController]
        tabBarController.viewControllers = controllers
        tabBarController.tabBar.barTintColor = AppColors.tab.color
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.tintColor = AppColors.white.color

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

