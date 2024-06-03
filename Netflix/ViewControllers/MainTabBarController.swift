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
        
        let homeVC = getHomeVC()
        let nc1 = UINavigationController(rootViewController: homeVC)
        
        let nc2 = UINavigationController(rootViewController: NFUpcomingVC())
        
        let searchVC = getSearchVC()
        let nc3 = UINavigationController(rootViewController: searchVC)
        
        let downloadVC = getDownloadVC()
        let nc4 = UINavigationController(rootViewController: downloadVC)
         
        nc1.tabBarItem.image = UIImage(systemName: "house")
        nc2.tabBarItem.image = UIImage(systemName: "play.circle")
        nc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        nc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        nc1.title = "Home"
        nc2.title = "Comming Soon"
        nc3.title = "Searches"
        nc4.title = "Downloads"
        
        tabBar.tintColor = .label
        
        viewControllers = [nc1, nc2, nc3, nc4]
    }
    
    private func getHomeVC() -> NFHomeVC {
        let dataRepo = MovieCoreDataRespository()
        let homeVM = NFHomeViewVM(repository: dataRepo)
        let homeVC = NFHomeVC(viewModel: homeVM)
        return homeVC
    }
    
    private func getDownloadVC() -> NFDownloadsVC {
        let dataRepo = MovieCoreDataRespository()
        let downlaodVM = NFDownloadVM(repository: dataRepo)
        let downloadVC = NFDownloadsVC(viewModel: downlaodVM)
        return downloadVC
    }
    
    private func getSearchVC() -> NFSearchVC {
        let searchVM = NFSearchViewVM()
        let searchVC = NFSearchVC(viewModel: searchVM)
        return searchVC
    }
}

