//
//  SceneDelegate.swift
//  Westeros
//
//  Created by Kary Rguez on 11/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        // Desempaquetamos scene
        guard let scene = (scene as? UIWindowScene) else { return }
        
        // Creamos un objeto window
        let window = UIWindow(windowScene: scene)
        
        // Instanciamos un tab bar
        let tabBarController = UITabBarController()
        
        // Instanciamos nuestra lista de casas
        let houseListViewController = HouseListViewController()
        
        houseListViewController.tabBarItem = UITabBarItem(
            title: "Houses",
            image: UIImage(systemName: "house"), // SF Symbol
            selectedImage: UIImage(systemName: "house.fill"))  // SF Symbol
        
        let navigationController = UINavigationController(rootViewController: houseListViewController)
        let favouritesViewController = FavouriteHouseListViewController()
        favouritesViewController.tabBarItem = UITabBarItem(
            title: "Favourites",
            image: UIImage(systemName: "star"), // SF Symbol
            selectedImage: UIImage(systemName: "star.fill"))  // SF Symbol
        let favouritesNavigationController = UINavigationController(rootViewController: favouritesViewController)
        
        tabBarController.viewControllers = [navigationController, favouritesNavigationController]
        
        // Asignamos el primer view controller
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window 
    }

}

