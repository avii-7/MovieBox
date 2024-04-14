//
//  ViewController.swift
//  Netflix
//
//  Created by Arun on 09/04/24.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc1 = UINavigationController(rootViewController: HomeVC())
        let nc2 = UINavigationController(rootViewController: UpcomingVC())
        let nc3 = UINavigationController(rootViewController: SearchVC())
        let nc4 = UINavigationController(rootViewController: DownloadsVC())
         
        nc1.tabBarItem.image = UIImage(systemName: "house")
        nc2.tabBarItem.image = .init(systemName: "play.circle")
        nc3.tabBarItem.image = .init(systemName: "magnifyingglass")
        nc4.tabBarItem.image = .init(systemName: "arrow.down.to.line")
        
        nc1.title = "Home"
        nc2.title = "Comming Soon"
        nc3.title = "Searches"
        nc4.title = "Downloads"
        
        tabBar.tintColor = .label
        
        viewControllers = [nc1, nc2, nc3, nc4]
    }
}

