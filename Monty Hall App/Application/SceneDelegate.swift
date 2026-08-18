//
//  SceneDelegate.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 16/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    var window: UIWindow?
    var appContainer: AppContainer?

    // MARK: - UIWindowSceneDelegate

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Setup container & main navigation hierarchy
        appContainer = AppContainer()
        guard let appContainer = appContainer else { return }

        let window = UIWindow(windowScene: windowScene)
        let rootViewController: UIViewController = UINavigationController(
            rootViewController: appContainer.makeHomeVC()
        )
        window.rootViewController = rootViewController

        self.window = window
        window.makeKeyAndVisible()

        // Start playing soundtrack
        audioManager.play(Tracklist.soundtrack)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
    }
}

